import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme.dart';
import '../../data/config/app_config.dart';
import '../../data/db/database.dart';
import '../../core/enums.dart';
import '../../features/terapia/terapia_providers.dart';
import '../../features/terapia/widgets/terapia_form_sheet.dart';
import 'pazienti_providers.dart';
import 'widgets/paziente_form_sheet.dart';
import 'widgets/qr_paziente_dialog.dart';

class PazienteDetailScreen extends ConsumerStatefulWidget {
  const PazienteDetailScreen({super.key, required this.paziente});

  final Paziente paziente;

  @override
  ConsumerState<PazienteDetailScreen> createState() =>
      _PazienteDetailScreenState();
}

class _PazienteDetailScreenState extends ConsumerState<PazienteDetailScreen> {
  late Paziente _paziente;
  List<Terapia> _terapie = [];
  List<Misurazione> _misurazioni = [];
  List<ParametroCatalogo?> _catalogo = [];
  bool _caricamento = true;
  bool _sync = false;
  String? _syncMsg;

  @override
  void initState() {
    super.initState();
    _paziente = widget.paziente;
    _carica();
  }

  Future<void> _carica() async {
    setState(() => _caricamento = true);
    final repo = ref.read(pazientiRepositoryProvider);
    final t = await repo.terapieAttive(_paziente.id);
    final m = await repo.misurazioniRecenti(_paziente.id);
    final cat = await Future.wait(m.map((mis) => repo.parametroById(mis.parametroId)));
    setState(() {
      _terapie = t;
      _misurazioni = m;
      _catalogo = cat;
      _caricamento = false;
    });
  }

  Future<void> _sincronizza() async {
    setState(() { _sync = true; _syncMsg = null; });
    final repo = ref.read(pazientiRepositoryProvider);
    final msg = await repo.sincronizza(_paziente.id);
    await _carica();
    setState(() { _sync = false; _syncMsg = msg; });
  }

  Future<void> _mostraQr() async {
    final serverUrl = await AppConfig.instance.getServerUrl();
    if (!mounted) return;
    await QrPazienteDialog.mostra(
      context,
      paziente: _paziente,
      serverUrl: serverUrl,
    );
  }

  Future<void> _aggiungiTerapia() async {
    final salvata = await TerapiaFormSheet.mostra(
      context,
      pazienteId: _paziente.id,
    );
    if (salvata) await _carica();
  }

  Future<void> _modificaTerapia(Terapia t) async {
    final db = ref.read(appDatabaseProvider);
    final orari = await (db.select(db.orariTerapia)
          ..where((o) => o.terapiaId.equals(t.id)))
        .get();
    if (!mounted) return;
    final salvata = await TerapiaFormSheet.mostra(
      context,
      terapia: t,
      orariEsistenti: orari,
      pazienteId: _paziente.id,
    );
    if (salvata) await _carica();
  }

  Future<void> _disattivaTerapia(Terapia t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Disattiva terapia'),
        content: Text('Disattivare "${t.nomeFarmaco}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annulla')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Disattiva')),
        ],
      ),
    );
    if (ok != true) return;
    final tRepo = ref.read(terapiaRepositoryProvider);
    await tRepo.disattivaTerapia(t);
    await _carica();
  }

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('d MMMM yyyy', 'it_IT');
    final fmtDt = DateFormat('d MMM HH:mm', 'it_IT');
    final p = _paziente;

    return Scaffold(
        appBar: AppBar(
          title: Text('${p.nome} ${p.cognome}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Modifica anagrafica',
              onPressed: () async {
                final ok = await PazienteFormSheet.mostra(context, paziente: p);
                if (ok) {
                  final pazienti = await ref.read(pazientiRepositoryProvider).listaPazienti();
                  final aggiornato = pazienti.firstWhere((x) => x.id == p.id, orElse: () => p);
                  setState(() => _paziente = aggiornato);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.qr_code),
              tooltip: 'Genera QR onboarding',
              onPressed: _mostraQr,
            ),
            _sync
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  )
                : IconButton(
                    icon: const Icon(Icons.sync),
                    tooltip: 'Sincronizza con server',
                    onPressed: _sincronizza,
                  ),
          ],
        ),
        body: _caricamento
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: _carica,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  children: [
                    if (_syncMsg != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Card(
                          color: AppTheme.statoOk.withValues(alpha: 0.1),
                          child: ListTile(
                            leading: const Icon(Icons.check_circle_outline, color: AppTheme.statoOk),
                            title: Text(_syncMsg!),
                            trailing: IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () => setState(() => _syncMsg = null),
                            ),
                          ),
                        ),
                      ),

                    // ── ANAGRAFICA ──────────────────────────────────────
                    _SectionTitle('Anagrafica'),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _InfoRow(Icons.badge_outlined, 'Codice Fiscale', p.codiceFiscale),
                            _InfoRow(Icons.cake_outlined, 'Data di nascita',
                                '${fmt.format(p.dataNascita)} (${p.anni} anni)'),
                            _InfoRow(Icons.phone_android_outlined, 'Cellulare', p.cellulare),
                            if (p.telefono != null)
                              _InfoRow(Icons.phone_outlined, 'Telefono', p.telefono!),
                            if (p.email != null)
                              _InfoRow(Icons.email_outlined, 'Email', p.email!),
                            if (p.indirizzo != null)
                              _InfoRow(Icons.home_outlined, 'Indirizzo', p.indirizzo!),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ── TERAPIE ──────────────────────────────────────────
                    Row(
                      children: [
                        Expanded(child: _SectionTitle('Terapie attive (${_terapie.length})')),
                        TextButton.icon(
                          onPressed: _aggiungiTerapia,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Aggiungi'),
                        ),
                      ],
                    ),
                    if (_terapie.isEmpty)
                      const _EmptyHint('Nessuna terapia prescritta')
                    else
                      ..._terapie.map((t) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: const Icon(Icons.medication_outlined,
                                  color: AppTheme.brand),
                              title: Text(t.nomeFarmaco,
                                  style: const TextStyle(fontWeight: FontWeight.w600)),
                              subtitle: Text(
                                  '${t.dosaggio ?? ''} · ${t.priorita.etichetta}'),
                              trailing: PopupMenuButton<String>(
                                onSelected: (v) {
                                  if (v == 'modifica') _modificaTerapia(t);
                                  if (v == 'disattiva') _disattivaTerapia(t);
                                },
                                itemBuilder: (_) => [
                                  const PopupMenuItem(value: 'modifica',
                                      child: ListTile(leading: Icon(Icons.edit_outlined), title: Text('Modifica'), contentPadding: EdgeInsets.zero)),
                                  const PopupMenuItem(value: 'disattiva',
                                      child: ListTile(leading: Icon(Icons.stop_circle_outlined), title: Text('Disattiva'), contentPadding: EdgeInsets.zero)),
                                ],
                              ),
                            ),
                          )),
                    const SizedBox(height: 20),

                    // ── MISURAZIONI ──────────────────────────────────────
                    _SectionTitle('Misurazioni ricevute (${_misurazioni.length})'),
                    if (_misurazioni.isEmpty)
                      const _EmptyHint('Nessuna misurazione ancora ricevuta dal paziente')
                    else
                      ..._misurazioni.asMap().entries.map((e) {
                        final m = e.value;
                        final cat = e.key < _catalogo.length ? _catalogo[e.key] : null;
                        final val = cat?.tipoValore.index == 1
                            ? '${m.valore1?.toStringAsFixed(0) ?? '?'} / ${m.valore2?.toStringAsFixed(0) ?? '?'}'
                            : (m.valore1 != null
                                ? (m.valore1! % 1 == 0
                                    ? m.valore1!.toStringAsFixed(0)
                                    : m.valore1!.toStringAsFixed(1))
                                : m.valoreTesto ?? '—');
                        return Card(
                          margin: const EdgeInsets.only(bottom: 6),
                          child: ListTile(
                            dense: true,
                            leading: const Icon(Icons.monitor_heart_outlined,
                                color: AppTheme.brand),
                            title: Text(cat?.nomeVisualizzato ?? 'Parametro #${m.parametroId}'),
                            subtitle: Text(fmtDt.format(m.data)),
                            trailing: Text(
                              '$val ${cat?.unitaMisura ?? ''}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
        );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: AppTheme.brand, fontWeight: FontWeight.bold)),
      );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(icon, size: 18, color: Colors.black45),
            const SizedBox(width: 10),
            Text('$label: ', style: const TextStyle(color: Colors.black54)),
            Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text,
            style: const TextStyle(color: Colors.black45, fontStyle: FontStyle.italic)),
      );
}
