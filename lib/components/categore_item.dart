import 'dart:ui';
import 'package:flutter/material.dart';

class CategoreItem extends StatefulWidget {
  const CategoreItem({
    super.key,
    required this.text,
    required this.colors,
    required this.ontap,
    this.icon,
  });

  final String text;
  final Color colors;
  final VoidCallback ontap;
  final IconData? icon;

  @override
  State<CategoreItem> createState() => _CategoreItemState();
}

class _CategoreItemState extends State<CategoreItem>
    with SingleTickerProviderStateMixin {
  double scale = 1;

  void _onTapDown(TapDownDetails d) {
    setState(() => scale = 0.96);
  }

  void _onTapUp(TapUpDetails d) {
    setState(() => scale = 1);
  }

  void _onTapCancel() {
    setState(() => scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTap: widget.ontap,
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.colors.withOpacity(0.85),
                    widget.colors.withOpacity(0.55),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withOpacity(0.25)),
                boxShadow: [
                  BoxShadow(
                    color: widget.colors.withOpacity(0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  splashColor: Colors.white24,

                  onTap: widget.ontap,

                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // ICON
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.icon ?? Icons.category,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),

                        const SizedBox(width: 15),

                        // TEXT
                        Expanded(
                          child: Text(
                            widget.text,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
