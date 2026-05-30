import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/db/database.dart';
import '../monitora_providers.dart';
import '../../terapia/terapia_providers.dart';

class GestisciParametriSheet extends ConsumerStatefulWidget {
  const GestisciParametriSheet({super.key});

  static Future<bool> mostra(BuildContext context) async {
    final risultato = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const GestisciParametriSheet(),
    );
    return risultato ?? false;
  }

  @override
  ConsumerState<GestisciParametriSheet> createState() =>
      _GestisciParametriSheetState();
}

class _GestisciParametriSheetState
    extends ConsumerState<GestisciParametriSheet> {
  List<(ParametroCatalogo, bool)>? _parametri;
  bool _caricamento = true;

  @override
  void initState() {
    super.initState();
    _carica();
  }

  Future<void> _carica() async {
    final repo = ref.read(monitoraRepositoryProvider);
    final pazienteId = ref.read(pazienteCorrenteIdProvider);
    final lista = await repo.tuttiIParametriCatalogo(pazienteId);
    if (mounted) setState(() { _parametri = lista; _caricamento = false; });
  }

  Future<void> _toggle(ParametroCatalogo p, bool abilitato) async {
    final repo = ref.read(monitoraRepositoryProvider);
    final pazienteId = ref.read(pazienteCorrenteIdProvider);
    if (abilitato) {
      await repo.disabilitaParametro(pazienteId, p.id);
    } else {
      await repo.abilitaParametro(pazienteId, p.id);
    }
    final lista = await repo.tuttiIParametriCatalogo(pazienteId);
    if (mounted) setState(() => _parametri = lista);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Parametri monitorati',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Chiudi'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (_caricamento)
            const Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            )
          else
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _parametri!.length,
                itemBuilder: (_, i) {
                  final (p, abilitato) = _parametri![i];
                  return CheckboxListTile(
                    value: abilitato,
                    title: Text(p.nomeVisualizzato),
                    subtitle: Text(p.unitaMisura),
                    secondary: Icon(
                      abilitato
                          ? Icons.monitor_heart
                          : Icons.monitor_heart_outlined,
                      color: abilitato
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black38,
                    ),
                    onChanged: (_) => _toggle(p, abilitato),
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
