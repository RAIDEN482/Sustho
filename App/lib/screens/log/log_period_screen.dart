import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/app_providers.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/date_formats.dart';
import '../../l10n/app_localizations.dart';
import '../../models/cycle_entry.dart';
import '../../models/enums.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_card.dart';
import '../../widgets/selectable_chip.dart';

class LogPeriodScreen extends ConsumerStatefulWidget {
  const LogPeriodScreen({super.key, this.initialDate});

  final DateTime? initialDate;

  @override
  ConsumerState<LogPeriodScreen> createState() => _LogPeriodScreenState();
}

class _LogPeriodScreenState extends ConsumerState<LogPeriodScreen> {
  late DateTime _date;
  late FlowLevel _flow;
  ProductUsed _product = ProductUsed.none;
  bool _hasClots = false;
  ClotSize _clotSize = ClotSize.small;
  String _notes = '';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _date = widget.initialDate != null
        ? DateTime(widget.initialDate!.year, widget.initialDate!.month,
            widget.initialDate!.day)
        : DateTime(now.year, now.month, now.day);
    _flow = FlowLevel.medium;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year, now.month, now.day),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _save() async {
    final controller = ref.read(cycleControllerProvider);
    final existing = controller.entryFor(_date);
    if (existing != null) {
      existing
        ..flow = _flow
        ..productUsed = _product
        ..hasClots = _hasClots
        ..clotSize = _clotSize
        ..notes = _notes;
      await controller.repository.saveEntry(existing);
      controller.reload();
    } else {
      await controller.repository.saveEntry(
        CycleEntry.create(
          date: _date,
          flow: _flow,
          productUsed: _product,
          hasClots: _hasClots,
          clotSize: _clotSize,
          notes: _notes,
        ),
      );
      controller.reload();
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.logPeriod)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.pickDate, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                _DateRow(
                  label: DateFormats.full(_date, bn: l10n.isBn),
                  onTap: _pickDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.flow, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    for (final flow in const [
                      FlowLevel.spotting,
                      FlowLevel.light,
                      FlowLevel.medium,
                      FlowLevel.heavy,
                    ])
                      SelectableChip(
                        label: switch (flow) {
                          FlowLevel.spotting => l10n.spotting,
                          FlowLevel.light => l10n.flowLight,
                          FlowLevel.medium => l10n.flowMedium,
                          FlowLevel.heavy => l10n.flowHeavy,
                          FlowLevel.none => l10n.flowNone,
                        },
                        icon: switch (flow) {
                          FlowLevel.spotting => Icons.water_drop_outlined,
                          FlowLevel.light => Icons.water_drop_outlined,
                          FlowLevel.medium => Icons.opacity_outlined,
                          FlowLevel.heavy => Icons.waves_outlined,
                          FlowLevel.none => Icons.block_outlined,
                        },
                        selected: _flow == flow,
                        onTap: () => setState(() => _flow = flow),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (_flow != FlowLevel.none) ...[
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.productUsed, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final product in const [
                        ProductUsed.none,
                        ProductUsed.pad,
                        ProductUsed.tampon,
                        ProductUsed.cup,
                        ProductUsed.underwear,
                      ])
                        SelectableChip(
                          label: switch (product) {
                            ProductUsed.none => l10n.productNone,
                            ProductUsed.pad => l10n.productPad,
                            ProductUsed.tampon => l10n.productTampon,
                            ProductUsed.cup => l10n.productCup,
                            ProductUsed.underwear => l10n.productUnderwear,
                          },
                          selected: _product == product,
                          onTap: () => setState(() => _product = product),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.grain_outlined,
                          size: 20, color: AppColors.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(l10n.clots, style: theme.textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: SelectableChip(
                          label: l10n.clotNone,
                          selected: !_hasClots,
                          onTap: () => setState(() => _hasClots = false),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: SelectableChip(
                          label: l10n.hasClots,
                          selected: _hasClots,
                          onTap: () => setState(() => _hasClots = true),
                        ),
                      ),
                    ],
                  ),
                  if (_hasClots) ...[
                    const SizedBox(height: AppSpacing.md),
                    Text(l10n.clotSize, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final size in const [
                          ClotSize.small,
                          ClotSize.medium,
                          ClotSize.large,
                        ])
                          SelectableChip(
                            label: switch (size) {
                              ClotSize.small => l10n.clotSmall,
                              ClotSize.medium => l10n.clotMedium,
                              ClotSize.large => l10n.clotLarge,
                              ClotSize.none => l10n.clotNone,
                            },
                            selected: _clotSize == size,
                            onTap: () => setState(() => _clotSize = size),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.notes, style: theme.textTheme.titleMedium),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: TextEditingController(text: _notes),
                    onChanged: (v) => _notes = v,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: l10n.notesHint,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppRadii.control),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: l10n.save,
            icon: Icons.check_outlined,
            expanded: true,
            onPressed: _save,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: l10n.markNotPeriod,
            icon: Icons.close_outlined,
            style: AppButtonStyle.ghost,
            expanded: true,
            onPressed: () async {
              await ref.read(cycleControllerProvider).markNotPeriod(_date);
              if (!context.mounted) return;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _DateRow extends ConsumerWidget {
  const _DateRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.control),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadii.control),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today_outlined,
                size: 20, color: AppColors.primary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }
}
