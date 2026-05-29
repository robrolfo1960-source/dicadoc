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
  });

  final Terapia? terapia;
  final List<OrarioTerapia>? orariEsistenti;

  static Future<bool> mostra(
    BuildContext context, {
    Terapia? terapia,
    List<OrarioTerapia>? orariEsistenti,
  }) async {
    final risultato = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TerapiaFormSheet(
        terapia: terapia,
        orariEsistenti: orariEsistenti,
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
  late List<String> _orari;
  bool _salvataggio = false;

  bool get _isEdit => widget.terapia != null;

  @override
  void initState() {
    super.initState();
    final t = widget.terapia;
    _nomeFarmacoCtrl = TextEditingController(text: t?.nomeFarmaco ?? '');
    _dosaggioCtrl = TextEditingController(text: t?.dosaggio ?? '');
    _noteCtrl = TextEditingController(text: t?.note ?? '');
    _priorita = t?.priorita ?? PrioritaTerapia.media;
    _dataInizio = t?.dataInizio ?? DateTime.now();
    _orari = widget.orariEsistenti?.map((o) => o.ora).toList() ?? ['08:00'];
  }

  @override
  void dispose() {
    _nomeFarmacoCtrl.dispose();
    _dosaggioCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _scegliOrario(int index) async {
    final parti = _orari[index].split(':');
    final init = TimeOfDay(
      hour: int.tryParse(parti[0]) ?? 8,
      minute: int.tryParse(parti.length > 1 ? parti[1] : '0') ?? 0,
    );
    final picked = await showTimePicker(context: context, initialTime: init);
    if (picked == null) return;
    setState(() {
      _orari[index] =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      _orari.sort();
    });
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
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      if (_isEdit) {
        await repo.aggiornaTerapia(
          terapia: widget.terapia!,
          nomeFarmaco: _nomeFarmacoCtrl.text.trim(),
          dosaggio: _dosaggioCtrl.text.trim().isEmpty
              ? null
              : _dosaggioCtrl.text.trim(),
          priorita: _priorita,
          orari: _orari,
          dataInizio: _dataInizio,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        );
      } else {
        await repo.creaTerapia(
          pazienteId: pazienteId,
          nomeFarmaco: _nomeFarmacoCtrl.text.trim(),
          dosaggio: _dosaggioCtrl.text.trim().isEmpty
              ? null
              : _dosaggioCtrl.text.trim(),
          priorita: _priorita,
          orari: _orari,
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
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
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
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.etichetta),
                        ))
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
                    child: Text(
                      'Orari somministrazione',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => setState(() {
                      _orari.add('08:00');
                      _orari.sort();
                    }),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Aggiungi'),
                  ),
                ],
              ),
              ..._orari.asMap().entries.map(
                    (e) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.schedule_outlined),
                      title: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () => _scegliOrario(e.key),
                      trailing: _orari.length > 1
                          ? IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () =>
                                  setState(() => _orari.removeAt(e.key)),
                            )
                          : null,
                    ),
                  ),
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
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(_isEdit ? 'Salva modifiche' : 'Aggiungi terapia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
