import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_spacing.dart';
import '../controllers/analytics_controller.dart';

/// Analytics view with lead, source, department, staff, and conversion metrics.
class AnalyticsView extends StatelessWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalyticsController());

    return Scaffold(
      backgroundColor: NelsonColors.background,
      appBar: AppBar(title: const Text('Analytics')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: NelsonColors.primaryBlue));
        }

        return ListView(
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          children: [
            // Overview
            Text('Overview', style: AppTypography.sectionTitle),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _MetricChip(label: 'Total Leads', value: '156', color: NelsonColors.primaryBlue),
                _MetricChip(label: 'Calls Made', value: '89', color: NelsonColors.primaryRed),
                _MetricChip(label: 'Connected', value: '67', color: NelsonColors.statusConnected),
                _MetricChip(label: 'Appointments', value: '32', color: NelsonColors.successGreen),
                _MetricChip(label: 'Conversions', value: '18', color: NelsonColors.statusConverted),
                _MetricChip(label: 'Lost', value: '12', color: NelsonColors.statusLost),
              ],
            ),

            const SizedBox(height: AppSpacing.sectionGap),
            Text('Source Performance', style: AppTypography.sectionTitle),
            const SizedBox(height: 12),
            _BarChart(items: [
              _BarItem('WhatsApp', 45, NelsonColors.successGreen),
              _BarItem('Instagram', 28, NelsonColors.womenPink),
              _BarItem('Website', 22, NelsonColors.primaryBlue),
              _BarItem('Facebook', 18, NelsonColors.statusNew),
              _BarItem('Google', 15, NelsonColors.statusContacted),
              _BarItem('Walk-in', 12, NelsonColors.textSecondary),
              _BarItem('Referral', 10, NelsonColors.statusAssigned),
              _BarItem('Phone', 6, NelsonColors.primaryRed),
            ]),

            const SizedBox(height: AppSpacing.sectionGap),
            Text('Staff Performance', style: AppTypography.sectionTitle),
            const SizedBox(height: 12),
            _StaffRow(name: 'Rahul Sharma', leads: 35, calls: 28, conversions: 8),
            _StaffRow(name: 'Priya Patel', leads: 30, calls: 24, conversions: 6),
            _StaffRow(name: 'Amit Kumar', leads: 42, calls: 35, conversions: 9),
            _StaffRow(name: 'Neha Gupta', leads: 28, calls: 22, conversions: 5),

            const SizedBox(height: AppSpacing.sectionGap),
            Text('Conversion Funnel', style: AppTypography.sectionTitle),
            const SizedBox(height: 12),
            _FunnelStep(label: 'Leads', value: 156, width: 1.0),
            _FunnelStep(label: 'Contacted', value: 89, width: 0.57),
            _FunnelStep(label: 'Interested', value: 52, width: 0.33),
            _FunnelStep(label: 'Appointments', value: 32, width: 0.21),
            _FunnelStep(label: 'Converted', value: 18, width: 0.12),

            const SizedBox(height: 32),
          ],
        );
      }),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _MetricChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 52) / 3,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: NelsonColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: NelsonColors.border, width: 0.5),
      ),
      child: Column(
        children: [
          Text(value, style: AppTypography.sectionTitleLarge.copyWith(color: color)),
          const SizedBox(height: 2),
          Text(label, style: AppTypography.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

class _BarItem {
  final String label;
  final int value;
  final Color color;
  const _BarItem(this.label, this.value, this.color);
}

class _BarChart extends StatelessWidget {
  final List<_BarItem> items;
  const _BarChart({required this.items});

  @override
  Widget build(BuildContext context) {
    final maxValue = items.fold<int>(0, (max, item) => item.value > max ? item.value : max);
    return Column(
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            SizedBox(width: 72, child: Text(item.label, style: AppTypography.caption.copyWith(fontSize: 12))),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: item.value / maxValue,
                  backgroundColor: NelsonColors.border,
                  valueColor: AlwaysStoppedAnimation(item.color),
                  minHeight: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(width: 28, child: Text('${item.value}', style: AppTypography.captionMedium, textAlign: TextAlign.right)),
          ],
        ),
      )).toList(),
    );
  }
}

class _StaffRow extends StatelessWidget {
  final String name;
  final int leads, calls, conversions;
  const _StaffRow({required this.name, required this.leads, required this.calls, required this.conversions});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: NelsonColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: NelsonColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: AppTypography.bodyMedium)),
          _Stat(label: 'Leads', value: '$leads', color: NelsonColors.primaryBlue),
          const SizedBox(width: 16),
          _Stat(label: 'Calls', value: '$calls', color: NelsonColors.primaryRed),
          const SizedBox(width: 16),
          _Stat(label: 'Conv.', value: '$conversions', color: NelsonColors.successGreen),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  final Color color;
  const _Stat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTypography.bodyMedium.copyWith(color: color)),
        Text(label, style: AppTypography.caption.copyWith(fontSize: 10)),
      ],
    );
  }
}

class _FunnelStep extends StatelessWidget {
  final String label;
  final int value;
  final double width;
  const _FunnelStep({required this.label, required this.value, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: FractionallySizedBox(
        widthFactor: width.clamp(0.2, 1.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: NelsonColors.primaryBlue.withValues(alpha: 0.08 + (0.12 * width)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.captionMedium.copyWith(color: NelsonColors.primaryBlue)),
              Text('$value', style: AppTypography.bodyMedium.copyWith(color: NelsonColors.primaryBlue)),
            ],
          ),
        ),
      ),
    );
  }
}
