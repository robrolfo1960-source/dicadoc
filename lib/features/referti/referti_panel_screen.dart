import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../monitora/monitora_providers.dart';
import 'referti_providers.dart';
import 'widgets/image_source_sheet.dart';
import 'widgets/ocr_review_sheet.dart';

class RefertiPanelScreen extends ConsumerStatefulWidget {
  const RefertiPanelScreen({super.key});

  @override
  ConsumerState<RefertiPanelScreen> createState() => _RefertiPanelScreenState();
}

class _RefertiPanelScreenState extends ConsumerState<RefertiPanelScreen> {
  bool _elaborando = false;
  String? _errore;

  Future<void> _importa(String imagePath) async {
    setState(() {
      _elaborando = true;
      _errore = null;
    });
    try {
      final repo = ref.read(refertiRepositoryProvider);
      final valori = await repo.estraiDaImmagine(imagePath);
      if (!mounted) return;
      await OcrReviewSheet.mostra(
        context,
        valori: valori,
        onSalvato: () {
          ref.invalidate(storicoOcrProvider);
          ref.invalidate(parametriAbilitatiProvider);
        },
      );
    } catch (e) {
      setState(() => _errore = 'Errore OCR: $e');
    } finally {
      if (mounted) setState(() => _elaborando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final storicoAsync = ref.watch(storicoOcrProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('P3 - Referti')),
      floatingActionButton: _elaborando
          ? FloatingActionButton(
              onPressed: null,
              backgroundColor: AppTheme.brand,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white),
              ),
            )
          : FloatingActionButton.extended(
              backgroundColor: AppTheme.brand,
              onPressed: () => ImageSourceSheet.mostra(
                context,
                onPicked: _importa,
              ),
              icon: const Icon(Icons.document_scanner_outlined,
                  color: Colors.white),
              label: const Text('Importa referto',
                  style: TextStyle(color: Colors.white)),
            ),
      body: Column(
        children: [
          if (_errore != null)
            MaterialBanner(
              content: Text(_errore!),
              actions: [
                TextButton(
                  onPressed: () => setState(() => _errore = null),
                  child: const Text('OK'),
                )
              ],
            ),
          Expanded(
            child: storicoAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Errore: $e')),
              data: (storico) {
                if (storico.isEmpty) {
                  return const _EmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
                  itemCount: storico.length,
                  itemBuilder: (_, i) => _StoricoTile(storico[i] as dynamic),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 64, color: Colors.black26),
          const SizedBox(height: 12),
          Text(
            'Nessun referto importato',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Tocca "Importa referto" per scansionare\nun referto di laboratorio',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _StoricoTile extends StatelessWidget {
  const _StoricoTile(this.misurazione);
  final dynamic misurazione;

  @override
  Widget build(BuildContext context) {
    final data = DateFormat('d MMM yyyy HH:mm', 'it_IT')
        .format(misurazione.data as DateTime);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading:
            const Icon(Icons.receipt_outlined, color: AppTheme.brand),
        title: Text('Import OCR'),
        subtitle: Text(data),
        trailing: const Icon(Icons.check_circle_outline,
            color: AppTheme.statoOk),
      ),
    );
  }
}
