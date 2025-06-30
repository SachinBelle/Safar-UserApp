import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';

class SlideToConfirmButton extends StatefulWidget {
  final String text;
  final VoidCallback onConfirmed;

  const SlideToConfirmButton({
    super.key,
    required this.text,
    required this.onConfirmed,
  });

  @override
  State<SlideToConfirmButton> createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<SlideToConfirmButton> {
  double _dragPosition = 0.0;
  bool _confirmed = false;

  static const double buttonWidth = 345;
  static const double buttonHeight = 60;
  static const double circleDiameter = 50;
  static const double arrowSize = 30;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.delta.dx;
      _dragPosition = _dragPosition.clamp(0.0, buttonWidth - circleDiameter);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragPosition > buttonWidth - circleDiameter - 10) {
      setState(() {
        _confirmed = true;
        _dragPosition = buttonWidth - circleDiameter;
      });
      widget.onConfirmed();
    } else {
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color transition based on drag position
    final Color backgroundColor = Color.lerp(
      const Color(0xFF1D3557),
      const Color(0xFFF4A261),
      _dragPosition / (buttonWidth - circleDiameter),
    )!;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background with color transition
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(widget.text, style: AppTextStyles.filledButtonText),
          ),
          // Sliding circle
          Positioned(
            left: _dragPosition,
            child: GestureDetector(
              onHorizontalDragUpdate: _confirmed ? null : _onDragUpdate,
              onHorizontalDragEnd: _confirmed ? null : _onDragEnd,
              child: Container(
                width: circleDiameter,
                height: circleDiameter,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDFCFB),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    size: arrowSize,
                    color: const Color(0xFF2C2C2C),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
