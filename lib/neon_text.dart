import 'package:flutter/material.dart';

/// Defines the neon intensity level.
///
/// - `low`: Applies a subtle neon glow.
/// - `high`: Enhances the glow effect for a stronger neon appearance.
enum NeonLevel { low, high }

/// Defines the type of animation applied to the neon text.
///
/// - `glow`: A continuous glowing effect.
/// - `pulse`: A pulsating effect where brightness fluctuates.
/// - `none`: No animation; the text remains static.
enum NeonAnimationType { glow, pulse, none }

/// A customizable neon text widget with glowing and animation effects.
///
/// This widget allows you to create visually striking neon-styled text
/// with adjustable colors, stroke width, blur radius, and animations.
///
/// ## Example Usage:
/// ```dart
/// NeonText(
///   text: "Flutter Neon!",
///   neonColor: Colors.cyanAccent,
///   fontSize: 40,
///   blurRadius: 20,
///   strokeWidth: 2,
///   letterSpacing: 2.0,
///   animationType: NeonAnimationType.pulse,
///   animationDuration: 3,
/// ),
/// ```
class NeonText extends StatefulWidget {
  /// The text to be displayed with the neon effect.
  final String text;

  /// The primary neon glow color.
  final Color neonColor;

  /// The font family for the text.
  final String? font;

  /// The font size of the neon text.
  final double? fontSize;

  /// The blur radius for the glow effect.
  final double blurRadius;

  /// The alpha transparency value (0-255).
  final int alpha;

  /// The stroke width for the neon outline.
  final double strokeWidth;

  /// The inner text color.
  final Color? textColor;

  /// Additional text styling.
  final TextStyle? textStyle;

  /// The type of animation applied to the text.
  final NeonAnimationType animationType;

  /// The duration of the animation in seconds.
  final int animationDuration;

  /// The letter spacing of the text.
  final double letterSpacing;

  /// Creates a neon-styled text widget with customizable glow and animations.
  ///
  /// The `NeonText` widget allows control over stroke width, blur radius,
  /// and animations like glow and pulse for an engaging text effect.
  ///
  /// ## Parameters:
  /// - [text]: The main text content.
  /// - [neonColor]: The glow color.
  /// - [font]: The font family (optional).
  /// - [fontSize]: The font size (optional, defaults to `30.0`).
  /// - [blurRadius]: The intensity of the glow (default: `10`).
  /// - [alpha]: Alpha transparency level (default: `150`).
  /// - [strokeWidth]: Thickness of the neon outline (default: `1.0`).
  /// - [textColor]: The inner text color (optional).
  /// - [textStyle]: Additional text styling (optional).
  /// - [animationType]: Type of animation (`glow`, `pulse`, or `none`).
  /// - [animationDuration]: Duration of animation in seconds (default: `2`).
  /// - [letterSpacing]: Adjust spacing between letters (default: `1.0`).
  const NeonText({
    Key? key,
    required this.text,
    required this.neonColor,
    this.font,
    this.fontSize,
    this.blurRadius = 10,
    this.alpha = 150,
    this.textColor,
    this.textStyle,
    this.strokeWidth = 1.0,
    this.animationType = NeonAnimationType.glow,
    this.animationDuration = 2,
    this.letterSpacing = 1.0,
  }) : super(key: key);

  @override
  NeonTextState createState() => NeonTextState();
}

/// The state class for [NeonText], responsible for managing animations.
///
/// This class controls the glowing and pulsating effects and ensures
/// smooth transitions using an animation controller.
class NeonTextState extends State<NeonText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.animationDuration),
    );

    if (widget.animationType != NeonAnimationType.none) {
      _animationController.repeat(reverse: true);
    }

    _glowAnimation = Tween<double>(
      begin: widget.animationType == NeonAnimationType.pulse ? 0.8 : 1.0,
      end: widget.animationType == NeonAnimationType.pulse ? 1.3 : 1.2,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        double radius =
            widget.animationType == NeonAnimationType.none
                ? widget.blurRadius
                : widget.blurRadius * _glowAnimation.value;

        return Stack(
          children: [
            _buildNeonText(radius, true),
            if (widget.textColor != null) _buildNeonText(radius, false),
          ],
        );
      },
    );
  }

  /// Builds the neon-styled text with glow effects.
  ///
  /// This method applies both stroke and filled styles to create
  /// the neon appearance.
  ///
  /// - [radius]: Determines the glow intensity.
  /// - [isStroke]: If `true`, renders the outer stroke effect.
  Widget _buildNeonText(double radius, bool isStroke) {
    return Text(
      widget.text,
      style: (widget.textStyle ?? const TextStyle()).copyWith(
        fontFamily: widget.font,
        fontSize: widget.fontSize ?? 30.0,
        letterSpacing: widget.letterSpacing,
        foreground:
            Paint()
              ..style = isStroke ? PaintingStyle.stroke : PaintingStyle.fill
              ..strokeWidth = widget.strokeWidth
              ..color =
                  isStroke
                      ? widget.neonColor.withAlpha(220)
                      : _backgroundColor().withAlpha(widget.alpha),
        shadows: _getShadows(radius),
      ),
    );
  }

  /// Returns the background color for the neon text.
  ///
  /// If no color is provided, it defaults to `Colors.black`.
  Color _backgroundColor() => widget.textColor ?? Colors.black;

  /// Generates shadow effects for the neon glow.
  ///
  /// This method applies multiple shadows to mimic the glow effect
  /// with increasing blur radii.
  ///
  /// - [radius]: The blur radius for the glow.
  List<Shadow> _getShadows(double radius) {
    return [
      Shadow(color: widget.neonColor, blurRadius: radius / 3),
      Shadow(color: widget.neonColor, blurRadius: radius / 1.5),
      Shadow(color: widget.neonColor, blurRadius: radius * 2),
    ];
  }
}
