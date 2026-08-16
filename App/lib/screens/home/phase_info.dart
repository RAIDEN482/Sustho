import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/utils/cycle_engine.dart';
import '../../l10n/app_localizations.dart';

/// Visual + textual metadata for a cycle phase.
class PhaseInfo {
  const PhaseInfo({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String label;
  final String description;
  final IconData icon;
  final Color color;
}

PhaseInfo phaseInfo(CyclePhase phase, AppLocalizations l10n) {
  switch (phase) {
    case CyclePhase.period:
      return PhaseInfo(
        label: l10n.periodPhase,
        description: l10n.periodDesc,
        icon: Icons.water_drop_outlined,
        color: AppColors.primary,
      );
    case CyclePhase.fertileWindow:
      return PhaseInfo(
        label: l10n.fertileWindow,
        description: l10n.fertileWindowDesc,
        icon: Icons.spa_outlined,
        color: AppColors.secondary,
      );
    case CyclePhase.ovulation:
      return PhaseInfo(
        label: l10n.ovulation,
        description: l10n.ovulationDesc,
        icon: Icons.flare_outlined,
        color: AppColors.secondary,
      );
    case CyclePhase.follicular:
      return PhaseInfo(
        label: l10n.follicularPhase,
        description: l10n.follicularDesc,
        icon: Icons.eco_outlined,
        color: AppColors.secondaryLight,
      );
    case CyclePhase.luteal:
      return PhaseInfo(
        label: l10n.lutealPhase,
        description: l10n.lutealDesc,
        icon: Icons.cloud_outlined,
        color: AppColors.warning,
      );
    case CyclePhase.unknown:
      return PhaseInfo(
        label: l10n.noDataYet,
        description: l10n.logPeriod,
        icon: Icons.help_outline,
        color: AppColors.textTertiaryDark,
      );
  }
}
