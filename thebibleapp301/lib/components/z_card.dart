import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebibleapp/models_providers/theme_provider.dart';

class ZCard extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Color color;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final GestureTapCallback onLongPress;
  final Color shadowColor;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  ZCard({
    Key key,
    this.child,
    this.borderRadius,
    this.color,
    this.onTap,
    this.shadowColor,
    this.elevation,
    this.margin,
    this.padding,
    this.onDoubleTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isThemeModeLight = themeProvider.isThemeModeLight;
    final currentColor = isThemeModeLight ? null : Color(0xFF1B2023);
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        color: color ?? currentColor,
        elevation: elevation ?? 1,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
        child: InkWell(
          splashColor: null,
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          onTap: onTap ?? null,
          onDoubleTap: onDoubleTap ?? null,
          onLongPress: onLongPress ?? null,
          child: Container(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: child,
          ),
        ),
      ),
    );
  }
}
