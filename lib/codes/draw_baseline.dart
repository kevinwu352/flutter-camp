class myPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.black, fontSize: 30);
    final textSpan = TextSpan(
      text: 'Flutter widget每日更新IAM17',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    // 把 TextBaseline.ideographic 改为 TextBaseline.alphabetic 画字母基线。
    final distanceToBaseline = textPainter.computeDistanceToActualBaseline(
      TextBaseline.ideographic,
    );

    canvas.drawLine(
      Offset(0, distanceToBaseline),
      Offset(textPainter.width, distanceToBaseline),
      paint,
    );
    final offset = Offset(0, 0);
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
