int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor.replaceAll('#', '');
  int finalColor = int.parse(newColor);
  return finalColor;
}

final buttoncolor = hexColor('3199D8');
final introBg = hexColor('FFFFFF');
final smallText = hexColor('737373');
final fillColor = hexColor('E0EFF9');
