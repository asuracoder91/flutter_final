import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';

class FluidFillIconData {
  final List<ui.Path> paths;
  FluidFillIconData(this.paths);
}

class FluidFillIcons {
  static final platform = FluidFillIconData([
    ui.Path()
      ..moveTo(0, -6)
      ..lineTo(10, -6),
    ui.Path()
      ..moveTo(5, 0)
      ..lineTo(-5, 0),
    ui.Path()
      ..moveTo(-10, 6)
      ..lineTo(0, 6),
  ]);
  static final arrow = FluidFillIconData([
    ui.Path()
      ..moveTo(-10, 6)
      ..lineTo(10, 6)
      ..moveTo(10, 6)
      ..lineTo(3, 0)
      ..moveTo(10, 6)
      ..lineTo(3, 12),
    ui.Path()
      ..moveTo(10, -6)
      ..lineTo(-10, -6)
      ..moveTo(-10, -6)
      ..lineTo(-3, 0)
      ..moveTo(-10, -6)
      ..lineTo(-3, -12),
  ]);
  static final user = FluidFillIconData([
    ui.Path()
      ..arcTo(const Rect.fromLTRB(-5, -16, 5, -6), 0, 1.9 * math.pi, true),
    ui.Path()
      ..arcTo(const Rect.fromLTRB(-10, 0, 10, 20), 0, -1.0 * math.pi, true),
  ]);
  static final fountainPen = FluidFillIconData([
    // The main body of the pen
    ui.Path()
      ..addPath(
        (ui.Path()
          ..moveTo(-2, -12)
          ..lineTo(2, -12)
          ..lineTo(2.5, 10)
          ..lineTo(-2.5, 10)
          ..close()),
        const ui.Offset(0, 0),
        matrix4: (Matrix4.rotationZ(math.pi / 4)).storage,
      ),

    // The nib of the fountain pen
    ui.Path()
      ..addPath(
        (ui.Path()
          ..moveTo(-2.5, 10)
          ..lineTo(2.5, 10)
          ..lineTo(0, 15)
          ..close()),
        const ui.Offset(0, 0),
        matrix4: (Matrix4.rotationZ(math.pi / 4)).storage,
      ),
  ]);

  static final home = FluidFillIconData([
    // The main body of the house (the rectangle representing the building structure)
    ui.Path()..addRRect(const RRect.fromLTRBXY(-10, -2, 10, 10, 2, 2)),

    // The roof of the house (the triangle on top)
    ui.Path()
      ..moveTo(-14, -2)
      ..quadraticBezierTo(-7, -12, 0, -16) // Left side of the roof with a curve
      ..quadraticBezierTo(7, -12, 14, -2) // Right side of the roof with a curve
      ..close(),
  ]);
}
