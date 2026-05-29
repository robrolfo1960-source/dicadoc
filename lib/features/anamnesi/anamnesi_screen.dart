import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme.dart';
import '../terapia/terapia_providers.dart';
import 'anamnesi_providers.dart';
import 'anamnesi_repository.dart';

class AnamnesiScreen extends ConsumerStatefulWidget {
  const AnamnesiScreen({super.key});

  @override
  ConsumerState<AnamnesiScreen> createState() => _AnamnesiScreenState();
}

class _AnamnesiScreenState extends ConsumerState<AnamnesiScreen> {
  late Map<String, bool> _risposte;
  bool _inizializzato = false;
  bool _salvando = false;

  @override
  Widget build(BuildContext context) {
    final anamnesiAsync = ref.watch(anamnesiProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anamnesi'),
        actions: [
          if (_inizializzato)
            TextButton(
              onPressed: _salvando ? null : _salva,
              child: _salvando
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Salva',
                      style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: anamnesiAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Errore: $e')),
        data: (salvate) {
          if (!_inizializzato) {
            _risposte = {
              for (final d in domandheAnamnesi)
                d: salvate[d] ?? false,
            };
            _inizializzato = true;
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                color: AppTheme.brand.withValues(alpha: 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline,
                          color: AppTheme.brand, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Le risposte aiutano il medico a personalizzare '
                          'la terapia. I dati restano sul device.',
                          style:
                              Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...domandheAnamnesi.asMap().entries.map(
                    (e) => _DomandaTile(
                      numero: e.key + 1,
                      domanda: e.value,
                      risposta: _risposte[e.value] ?? false,
                      onChanged: (v) =>
                          setState(() => _risposte[e.value] = v),
                    ),
                  ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _salvando ? null : _salva,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Salva anamnesi'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _salva() async {
    setState(() => _salvando = true);
    try {
      final repo = ref.read(anamnesiRepositoryProvider);
      final pazienteId = ref.read(pazienteCorrenteIdProvider);
      await repo.salva(pazienteId, _risposte);
      ref.invalidate(anamnesiProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Anamnesi salvata')),
        );
        Navigator.pop(context);
      }
    } finally {
      if (mounted) setState(() => _salvando = false);
    }
  }
}

class _DomandaTile extends StatelessWidget {
  const _DomandaTile({
    required this.numero,
    required this.domanda,
    required this.risposta,
    required this.onChanged,
  });

  final int numero;
  final String domanda;
  final bool risposta;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        value: risposta,
        onChanged: onChanged,
        activeThumbColor: AppTheme.brand,
        title: Text(
          '$numero.  $domanda',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Text(
          risposta ? 'Sì' : 'No',
          style: TextStyle(
            color: risposta ? AppTheme.brand : Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
