import 'package:flutter/material.dart';
import '../utils/spacing_extension.dart';

/// A compact badge widget that displays a [status] string colour-coded by its
/// semantic meaning.
///
/// Built-in status groups:
/// - **Yellow** – PENDING, LEFT, REQUESTED
/// - **Blue** – PRIMARY
/// - **Green** – ACCEPTED, DRAFT, RE_SCHEDULED, ACTIVE, COMPLETED, CONFIRMED
/// - **Red (theme error)** – REJECTED, INACTIVE, CANCELLED, CANCELED
/// - **Grey (default)** – any unrecognised status
///
/// To support additional statuses without subclassing, supply an [extraConfigs]
/// map that overrides or extends the built-in lookup:
///
/// ```dart
/// AurumStatusView(
///   status: 'ON_HOLD',
///   extraConfigs: {
///     'ON_HOLD': AurumStatusConfig(
///       backgroundColor: Colors.orange.withOpacity(0.15),
///       borderColor: Colors.orange.withOpacity(0.4),
///       dotColor: Colors.orange,
///       textColor: Colors.orange,
///     ),
///   },
/// )
/// ```
class AurumStatusView extends StatelessWidget {
  const AurumStatusView({
    required this.status,
    super.key,
    this.extraConfigs = const <String, AurumStatusConfig>{},
  });

  final String status;

  /// Optional map of additional / override status configs keyed by the
  /// **uppercased** status string.
  final Map<String, AurumStatusConfig> extraConfigs;

  @override
  Widget build(BuildContext context) {
    final String upperStatus = status.toUpperCase();
    final AurumStatusConfig config =
        _resolveConfig(upperStatus, context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: config.borderColor),
        borderRadius: BorderRadius.circular(8),
        color: config.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.circle,
              color: config.dotColor,
              size: 8,
            ),
            6.w,
            Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: config.textColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            4.w,
          ],
        ),
      ),
    );
  }

  AurumStatusConfig _resolveConfig(String upperStatus, BuildContext context) {
    // Caller-supplied overrides take precedence.
    if (extraConfigs.containsKey(upperStatus)) {
      return extraConfigs[upperStatus]!;
    }

    // ── Yellow ────────────────────────────────────────────────────────────────
    const Color _yellow = Color(0xFFF5A623);
    const Color _yellowLight = Color(0xFFFFF8E1);
    const Color _yellowBorder = Color(0xFFFFCC80);

    // ── Blue ──────────────────────────────────────────────────────────────────
    const Color _blue = Color(0xFF1565C0);
    const Color _blueLight = Color(0xFFE3F2FD);
    const Color _blueBorder = Color(0xFF90CAF9);

    // ── Green ─────────────────────────────────────────────────────────────────
    const Color _green = Color(0xFF2E7D32);
    const Color _greenWithOpacity16 = Color(0x292E7D32); // 16 % opacity
    const Color _greenWithOpacity50 = Color(0x7F2E7D32); // 50 % opacity

    // ── Grey ──────────────────────────────────────────────────────────────────
    const Color _grey = Color(0xFF9E9E9E);
    const Color _greyLight = Color(0x1A9E9E9E); // 10 % opacity

    switch (upperStatus) {
      case 'PENDING':
      case 'LEFT':
      case 'REQUESTED':
        return const AurumStatusConfig(
          backgroundColor: _yellowLight,
          borderColor: _yellowBorder,
          dotColor: _yellow,
          textColor: _yellow,
        );

      case 'PRIMARY':
        return const AurumStatusConfig(
          backgroundColor: _blueLight,
          borderColor: _blueBorder,
          dotColor: _blue,
          textColor: _blue,
        );

      case 'ACCEPTED':
      case 'DRAFT':
      case 'RE_SCHEDULED':
      case 'ACTIVE':
      case 'COMPLETED':
      case 'CONFIRMED':
        return const AurumStatusConfig(
          backgroundColor: _greenWithOpacity16,
          borderColor: _greenWithOpacity50,
          dotColor: _green,
          textColor: _green,
        );

      case 'REJECTED':
      case 'INACTIVE':
      case 'CANCELLED':
      case 'CANCELED':
        final Color error = Theme.of(context).colorScheme.error;
        return AurumStatusConfig(
          backgroundColor: error.withOpacity(0.16),
          borderColor: error.withOpacity(0.5),
          dotColor: error,
          textColor: error,
        );

      default:
        return const AurumStatusConfig(
          backgroundColor: _greyLight,
          borderColor: _grey,
          dotColor: _grey,
          textColor: _grey,
        );
    }
  }
}

/// Holds the four colours that define how a status badge is rendered.
class AurumStatusConfig {
  const AurumStatusConfig({
    required this.backgroundColor,
    required this.borderColor,
    required this.dotColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color dotColor;
  final Color textColor;
}
