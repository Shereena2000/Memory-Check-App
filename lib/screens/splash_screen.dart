import 'package:flip_card/screens/game_guide_screen.dart';
import 'package:flip_card/screens/game_screen.dart';
import 'package:flip_card/utils/colors_constand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToAppropriateScreen();
    });
  }

  Future<void> _navigateToAppropriateScreen() async {
    // Add a small delay for the splash screen to be visible
    await Future.delayed(const Duration(seconds: 5));
    
    if (!mounted) return;
    
    if (await GameGuideScreen.isFirstLaunch()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GameGuideScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GameScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background pattern
            Positioned.fill(
              child: Opacity(
                opacity: 0.1,
                child: CustomPaint(
                  painter: _DiamondPatternPainter(
                    color: lightPurpleColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            
            // Main content
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 2),
                
                // Animated card flip effect
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 1000),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(value * 3.14), // 180 degrees in radians
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: lightPurpleColor,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: lightPurpleColor.withOpacity(0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.psychology_alt,
                        size: 60,
                        color: Colors.yellow[600],
                      ),
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Game title with glow effect
                ShaderMask(
                  shaderCallback: (bounds) {
                    return LinearGradient(
                      colors: [
                        lightPurpleColor,
                        Colors.yellow[600]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    "FLIP CARDS",
                    style: GoogleFonts.orbitron(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 5,
                      height: 1.2,
                      color: lightPurpleColor
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Subtitle
                Text(
                  "Test your memory skills",
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 2,
                  ),
                ),
                
                const Spacer(flex: 2),
                
                // Progress indicator with custom design
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(lightPurpleColor),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Loading...",
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for diamond pattern background
class _DiamondPatternPainter extends CustomPainter {
  final Color color;
  
  _DiamondPatternPainter({required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const diamondSize = 50.0;
    
    for (double i = -diamondSize; i < size.width; i += diamondSize * 2) {
      for (double j = -diamondSize; j < size.height; j += diamondSize * 2) {
        final path = Path()
          ..moveTo(i + diamondSize, j)
          ..lineTo(i + diamondSize * 2, j + diamondSize)
          ..lineTo(i + diamondSize, j + diamondSize * 2)
          ..lineTo(i, j + diamondSize)
          ..close();
        canvas.drawPath(path, paint);
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}