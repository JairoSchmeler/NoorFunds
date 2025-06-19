import 'package:flutter/material.dart';

extension ColorOpacityExtension on Color {
  /// Returns a copy of this color with the given opacity [alpha] value.
  ///
  /// The [alpha] is expected to be between 0.0 and 1.0. If `alpha` is null,
  /// the original color is returned unchanged.
  Color withValues({double? alpha}) {
    if (alpha == null) {
      return this;
    }
    final double opacity = alpha.clamp(0.0, 1.0);
    return withOpacity(opacity);
  }
}
