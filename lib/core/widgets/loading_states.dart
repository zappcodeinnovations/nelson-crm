import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Empty state widget with icon, title and action.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    this.icon = Icons.inbox_outlined,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: NelsonColors.blueSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: NelsonColors.primaryBlue.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTypography.sectionTitle.copyWith(color: NelsonColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: AppTypography.body.copyWith(color: NelsonColors.textTertiary),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add, size: 18),
                label: Text(actionLabel!),
                style: TextButton.styleFrom(
                  foregroundColor: NelsonColors.primaryRed,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error state with retry.
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    this.message = 'Something went wrong. Please try again.',
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: NelsonColors.redSurface,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: NelsonColors.primaryRed.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: AppTypography.body.copyWith(color: NelsonColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Retry'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: NelsonColors.primaryBlue,
                  side: const BorderSide(color: NelsonColors.border),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading state with shimmer-like placeholder.
class LoadingState extends StatelessWidget {
  final int itemCount;
  final bool isList;

  const LoadingState({
    super.key,
    this.itemCount = 5,
    this.isList = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isList) {
      return const Center(
        child: CircularProgressIndicator(
          color: NelsonColors.primaryBlue,
          strokeWidth: 2.5,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, __) => const _ShimmerCard(),
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard();

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.7).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: NelsonColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: NelsonColors.border, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: 160, height: 14),
              const SizedBox(height: 10),
              _shimmerBox(width: 220, height: 12),
              const SizedBox(height: 8),
              _shimmerBox(width: 120, height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: NelsonColors.border.withValues(alpha: _animation.value),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
