import 'package:eduroom/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Basılanda gradient istiqaməti yüngül sürüşən animasiya ilə SIGN IN düyməsi.
class LoginSignInButton extends StatefulWidget {
  const LoginSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final Future<void> Function() onPressed;
  final bool isLoading;

  @override
  State<LoginSignInButton> createState() => _LoginSignInButtonState();
}

class _LoginSignInButtonState extends State<LoginSignInButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;

  static const _gradientColors = <Color>[
    AppColors.primaryGradientTop,
    Color(0xFF7292CF),
  ];

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.isLoading) return;
    await widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.isLoading;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: disabled ? null : (_) => _pressController.forward(),
        onTapUp: disabled ? null : (_) => _pressController.reverse(),
        onTapCancel: disabled ? null : () => _pressController.reverse(),
        onTap: disabled
            ? null
            : () async {
                await _handleTap();
              },
        child: AnimatedBuilder(
          animation: _pressController,
          builder: (context, child) {
            final t = Curves.easeInOutCubic.transform(_pressController.value);
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment(-1.15 + t * 0.55, -1),
                  end: Alignment(1.15 - t * 0.55, 1),
                  colors: _gradientColors,
                ),
              ),
              child: child,
            );
          },
          child: Center(
            child: widget.isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      14.horizontalSpace,
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
