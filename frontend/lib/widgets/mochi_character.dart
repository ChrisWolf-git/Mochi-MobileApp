import 'package:flutter/material.dart';

class MochiCharacter extends StatelessWidget {
  final String mood;
  final double size;

  const MochiCharacter({
    super.key,
    required this.mood,
    this.size = 180,
  });

  String _getImageForMood() {
    switch (mood) {
      case "Fröhlich":
        return "assets/images/mochi/mochi_happy.png";
      case "Müde":
        return "assets/images/mochi/mochi_tired.png";
      case "Überreizt":
        return "assets/images/mochi/mochi_ueberreizt.png";
      case "Überfordert":
        return "assets/images/mochi/mochi_overwhelmed.png";
      case "Im Hyperfokus":
        return "assets/images/mochi/mochi_hyperfocus.png";
      case "Gestresst":
        return "assets/images/mochi/mochi_stressed.png";
      case "Unsicher":
        return "assets/images/mochi/mochi_unsicher.png";
      case "Erschöpft":
        return "assets/images/mochi/mochi_erschöpft.png";
      case "Unruhig":
        return "assets/images/mochi/mochi_unruhig.png";
      case "Energetisch":
        return "assets/images/mochi/mochi_energetisch.png";
      case "Motiviert":
        return "assets/images/mochi/mochi_motiviert.png";
      case "Abgelenkt":
        return "assets/images/mochi/mochi_abgelenkt.png";
      default:
        return "assets/images/mochi/mochi_happy.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        _getImageForMood(),
        fit: BoxFit.contain,
      ),
    );
  }
}
