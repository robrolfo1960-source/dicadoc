import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/enums.dart';
import '../../../data/db/database.dart';
import '../terapia_providers.dart';

class TerapiaFormSheet extends ConsumerStatefulWidget {
  const TerapiaFormSheet({
    super.key,
    this.terapia,
    this.orariEsistenti,
    this.pazienteId,
  });

  final Terapia? terapia;
  final List<OrarioTerapia>? orariEsistenti;
  /// Se fornito usa questo pazienteId (medico). Altrimenti legge dal provider (paziente).
  final int? pazienteId;

  static Future<bool> mostra(
    BuildContext context, {
    Terapia? terapia,
    List<OrarioTerapia>? orariEsistenti,
    int? pazienteId,
  }) async {
    final risultato = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TerapiaFormSheet(
        terapia: terapia,
        orariEsistenti: orariEsistenti,
        pazienteId: pazienteId,
      ),
    );
    return risultato ?? false;
  }

  @override
  ConsumerState<TerapiaFormSheet> createState() => _TerapiaFormSheetState();
}

class _TerapiaFormSheetState extends ConsumerState<TerapiaFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeFarmacoCtrl;
  late final TextEditingController _dosaggioCtrl;
  late final TextEditingController _noteCtrl;
  late PrioritaTerapia _priorita;
  late DateTime _dataInizio;
  // Lista di orari come (ora, minuto)
  late List<(int, int)> _orari;
  bool _salvataggio = false;

  bool get _isEdit => widget.terapia != null;

  static String _fmt(int h, int m) =>
      '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';

  static (int, int) _parse(String s) {
    final p = s.split(':');
    return (int.tryParse(p[0]) ?? 8, int.tryParse(p.length > 1 ? p[1] : '0') ?? 0);
  }

  @override
  void initState() {
    super.initState();
    final t = widget.terapia;
    _nomeFarmacoCtrl = TextEditingController(text: t?.nomeFarmaco ?? '');
    _dosaggioCtrl = TextEditingController(text: t?.dosaggio ?? '');
    _noteCtrl = TextEditingController(text: t?.note ?? '');
    _priorita = t?.priorita ?? PrioritaTerapia.media;
    _dataInizio = t?.dataInizio ?? DateTime.now();
    final esistenti = widget.orariEsistenti;
    _orari = esistenti != null && esistenti.isNotEmpty
        ? esistenti.map((o) => _parse(o.ora)).toList()
        : [const (8, 0)];
  }

  @override
  void dispose() {
    _nomeFarmacoCtrl.dispose();
    _dosaggioCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _scegliData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataInizio,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dataInizio = picked);
  }

  Future<void> _salva() async {
    if (!_formKey.currentState!.validate()) return;
    if (_orari.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aggiungi almeno un orario.')),
      );
      return;
    }
    setState(() => _salvataggio = true);
    try {
      final repo = ref.read(terapiaRepositoryProvider);
      final pid = widget.pazienteId ?? ref.read(pazienteCorrenteIdProvider) as int;
      final orariStr = _orari.map((o) => _fmt(o.$1, o.$2)).toList()..sort();

      if (_isEdit) {
        await repo.aggiornaTerapia(
          terapia: widget.terapia!,
          nomeFarmaco: _nomeFarmacoCtrl.text.trim(),
          dosaggio: _dosaggioCtrl.text.trim().isEmpty ? null : _dosaggioCtrl.text.trim(),
          priorita: _priorita,
          orari: orariStr,
          dataInizio: _dataInizio,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        );
      } else {
        await repo.creaTerapia(
          pazienteId: pid,
          nomeFarmaco: _nomeFarmacoCtrl.text.trim(),
          dosaggio: _dosaggioCtrl.text.trim().isEmpty ? null : _dosaggioCtrl.text.trim(),
          priorita: _priorita,
          orari: orariStr,
          dataInizio: _dataInizio,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Errore: $e')));
      }
    } finally {
      if (mounted) setState(() => _salvataggio = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMMM yyyy', 'it_IT');
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isEdit ? 'Modifica terapia' : 'Nuova terapia',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomeFarmacoCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nome farmaco *',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo obbligatorio' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dosaggioCtrl,
                decoration: const InputDecoration(
                  labelText: 'Dosaggio',
                  hintText: 'es. 10 mg, 1 compressa',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<PrioritaTerapia>(
                initialValue: _priorita,
                decoration: const InputDecoration(
                  labelText: 'Priorità',
                  border: OutlineInputBorder(),
                ),
                items: PrioritaTerapia.values
                    .map((p) => DropdownMenuItem(value: p, child: Text(p.etichetta)))
                    .toList(),
                onChanged: (v) => setState(() => _priorita = v!),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_today_outlined),
                title: const Text('Data inizio'),
                subtitle: Text(fmt.format(_dataInizio)),
                onTap: _scegliData,
              ),
              const Divider(),
              Row(
                children: [
                  const Expanded(
                    child: Text('Orari somministrazione',
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  TextButton.icon(
                    onPressed: () => setState(() => _orari.add(const (8, 0))),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Aggiungi'),
                  ),
                ],
              ),
              ..._orari.asMap().entries.map((e) => _OrarioRow(
                    ora: e.value.$1,
                    minuto: e.value.$2,
                    mostraElimina: _orari.length > 1,
                    onChanged: (h, m) => setState(() => _orari[e.key] = (h, m)),
                    onElimina: () => setState(() => _orari.removeAt(e.key)),
                  )),
              const Divider(),
              TextFormField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _salvataggio ? null : _salva,
                child: _salvataggio
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(_isEdit ? 'Salva modifiche' : 'Aggiungi terapia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Riga con due dropdown ora/minuto — molto più intuitivo del clock.
class _OrarioRow extends StatelessWidget {
  const _OrarioRow({
    required this.ora,
    required this.minuto,
    required this.mostraElimina,
    required this.onChanged,
    required this.onElimina,
  });

  final int ora;
  final int minuto;
  final bool mostraElimina;
  final void Function(int h, int m) onChanged;
  final VoidCallback onElimina;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.schedule_outlined, color: Colors.black54),
          const SizedBox(width: 12),
          // Ore
          DropdownButton<int>(
            value: ora,
            items: List.generate(24, (h) => DropdownMenuItem(
              value: h,
              child: Text('${h.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            )),
            onChanged: (h) => onChanged(h!, minuto),
            underline: const SizedBox(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(':', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          // Minuti (ogni 5 min)
          DropdownButton<int>(
            value: (minuto ~/ 5) * 5, // arrotonda al multiplo di 5
            items: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
                .map((m) => DropdownMenuItem(
                      value: m,
                      child: Text(m.toString().padLeft(2, '0'),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    ))
                .toList(),
            onChanged: (m) => onChanged(ora, m!),
            underline: const SizedBox(),
          ),
          const Spacer(),
          if (mostraElimina)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onElimina,
            ),
        ],
      ),
    );
  }
}
