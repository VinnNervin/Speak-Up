import 'package:first_app/core/widgets/MainButton/main_button_config.dart';
import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final MainButtonConfig config;
  final VoidCallback? onPressed;

  const MainButton({super.key, required this.config, this.onPressed});

  factory MainButton.icon({
    Key? key,
    required MainButtonConfig config,
    required IconData icon,
    double iconSize = 24,
    Color? iconColor,
    VoidCallback? onPressed,
  }) {
    return MainButton(
      key: key,
      onPressed: onPressed,
      config: config.copyWith(icon: icon, iconSize: iconSize, iconColor: iconColor),
    );
  }

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        widget.onPressed!();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        width: widget.config.width,
        height: widget.config.height,
        transform: Matrix4.translationValues(0, _isPressed ? 4 : 0, 0),
        decoration: BoxDecoration(
          color: widget.config.backgroundColor,
          border: widget.config.borderWidth > 0
              ? Border.all(color: widget.config.borderColor, width: widget.config.borderWidth)
              : null,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: widget.config.shadowColor,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.config.icon != null) ...[
                Icon(
                  widget.config.icon,
                  size: widget.config.iconSize,
                  color: widget.config.iconColor ?? widget.config.fontColor,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.config.label,
                style: TextStyle(
                  fontWeight: FontWeight(widget.config.fontWeight),
                  fontSize: widget.config.fontSize,
                  color: widget.config.fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
