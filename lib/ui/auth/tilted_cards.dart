import 'package:flutter/material.dart';

class TiltedCards extends StatelessWidget {
  const TiltedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: const AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: _Card(
                imageUrl: 'assets/big-kanji.jpeg',
                width: 160,
                height: 218,
                tilt: -3.83 / 360,
              ),
            ),
            Positioned(
              right: 0,
              child: _Card(
                imageUrl: 'assets/big-kanji-2.jpeg',
                width: 144,
                height: 184,
                tilt: 3.46 / 360,
              ),
            ),
            _Card(
              imageUrl: 'assets/kanji-purp.png',
              width: 180,
              height: 258,
              tilt: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.tilt,
  });

  final double tilt;
  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(tilt),
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [Image.asset(imageUrl, fit: BoxFit.cover)],
          ),
        ),
      ),
    );
  }
}
