double calculateBTU({
  required double widthFt,
  required double heightFt,
  required double depthFt,
  required bool isTopFloor,
}) {
  final roomVolumeFt3 = widthFt * heightFt * depthFt;
  final baseBTU = roomVolumeFt3 * 4; // 4 BTU per ft³ (average)

  // Add 15% more if room is on top floor
  final adjustmentFactor = isTopFloor ? 1.15 : 1.0;

  return baseBTU * adjustmentFactor;
}
