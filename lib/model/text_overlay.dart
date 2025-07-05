class TextOverlay {
  String text;
  double x;
  double y;
  double fontSize;
  bool isSelected;

  TextOverlay({
    required this.text,
    required this.x,
    required this.y,
    this.fontSize = 20,
    this.isSelected = false,
  });

  TextOverlay copyWith({
    String? text,
    double? x,
    double? y,
    double? fontSize,
    bool? isSelected,
  }) {
    return TextOverlay(
      text: text ?? this.text,
      x: x ?? this.x,
      y: y ?? this.y,
      fontSize: fontSize ?? this.fontSize,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
