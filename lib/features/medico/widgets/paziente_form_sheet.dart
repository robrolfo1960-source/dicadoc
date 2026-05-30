import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../data/db/database.dart';
import '../pazienti_providers.dart';

class PazienteFormSheet extends ConsumerStatefulWidget {
  const PazienteFormSheet({super.key, this.paziente});

  final Paziente? paziente;

  static Future<bool> mostra(BuildContext context, {Paziente? paziente}) async {
    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => PazienteFormSheet(paziente: paziente),
    );
    return ok ?? false;
  }

  @override
  ConsumerState<PazienteFormSheet> createState() => _PazienteFormSheetState();
}

class _PazienteFormSheetState extends ConsumerState<PazienteFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nomeCtrl;
  late final TextEditingController _cognomeCtrl;
  late final TextEditingController _cfCtrl;
  late final TextEditingController _cellulareCtrl;
  late final TextEditingController _telefonoCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _indirizzoCtrl;
  late DateTime _dataNascita;
  bool _saving = false;

  bool get _isEdit => widget.paziente != null;

  @override
  void initState() {
    super.initState();
    final p = widget.paziente;
    _nomeCtrl = TextEditingController(text: p?.nome ?? '');
    _cognomeCtrl = TextEditingController(text: p?.cognome ?? '');
    _cfCtrl = TextEditingController(text: p?.codiceFiscale ?? '');
    _cellulareCtrl = TextEditingController(text: p?.cellulare ?? '');
    _telefonoCtrl = TextEditingController(text: p?.telefono ?? '');
    _emailCtrl = TextEditingController(text: p?.email ?? '');
    _indirizzoCtrl = TextEditingController(text: p?.indirizzo ?? '');
    _dataNascita = p?.dataNascita ?? DateTime(1970);
  }

  @override
  void dispose() {
    for (final c in [
      _nomeCtrl, _cognomeCtrl, _cfCtrl, _cellulareCtrl,
      _telefonoCtrl, _emailCtrl, _indirizzoCtrl
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _scegliData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataNascita,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dataNascita = picked);
  }

  Future<void> _salva() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(pazientiRepositoryProvider);
      if (_isEdit) {
        await repo.aggiornaPaziente(
          id: widget.paziente!.id,
          nome: _nomeCtrl.text.trim(),
          cognome: _cognomeCtrl.text.trim(),
          codiceFiscale: _cfCtrl.text.trim().toUpperCase(),
          dataNascita: _dataNascita,
          cellulare: _cellulareCtrl.text.trim(),
          telefono: _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
          indirizzo: _indirizzoCtrl.text.trim().isEmpty ? null : _indirizzoCtrl.text.trim(),
        );
      } else {
        await repo.creaPaziente(
          nome: _nomeCtrl.text.trim(),
          cognome: _cognomeCtrl.text.trim(),
          codiceFiscale: _cfCtrl.text.trim().toUpperCase(),
          dataNascita: _dataNascita,
          cellulare: _cellulareCtrl.text.trim(),
          telefono: _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
          email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
          indirizzo: _indirizzoCtrl.text.trim().isEmpty ? null : _indirizzoCtrl.text.trim(),
        );
      }
      ref.invalidate(listaPazientiProvider);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Errore: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
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
                _isEdit ? 'Modifica paziente' : 'Nuovo paziente',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nomeCtrl,
                      decoration: const InputDecoration(labelText: 'Nome *', border: OutlineInputBorder()),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => v!.trim().isEmpty ? 'Obbligatorio' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _cognomeCtrl,
                      decoration: const InputDecoration(labelText: 'Cognome *', border: OutlineInputBorder()),
                      textCapitalization: TextCapitalization.words,
                      validator: (v) => v!.trim().isEmpty ? 'Obbligatorio' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cfCtrl,
                decoration: const InputDecoration(labelText: 'Codice Fiscale *', border: OutlineInputBorder()),
                textCapitalization: TextCapitalization.characters,
                validator: (v) {
                  if (v!.trim().isEmpty) return 'Obbligatorio';
                  if (v.trim().length < 11) return 'Minimo 11 caratteri';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.cake_outlined),
                title: const Text('Data di nascita *'),
                subtitle: Text(fmt.format(_dataNascita)),
                onTap: _scegliData,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cellulareCtrl,
                decoration: const InputDecoration(labelText: 'Cellulare *', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.trim().isEmpty ? 'Obbligatorio' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _telefonoCtrl,
                      decoration: const InputDecoration(labelText: 'Telefono', border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _indirizzoCtrl,
                decoration: const InputDecoration(labelText: 'Indirizzo', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saving ? null : _salva,
                child: _saving
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : Text(_isEdit ? 'Salva modifiche' : 'Registra paziente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
