class Appliance {
  final String name;
  final double wattage;
  final int quantity;

  Appliance({
    required this.name,
    required this.wattage,
    required this.quantity,
  });

  double get totalWattage => wattage * quantity;
}

class SolarCalculationResult {
  final double totalLoad;
  final int panelsRequired;
  final double totalAreaRequired; // square feet
  final int rows;
  final int panelsPerRow;
  final double rowLength;
  final double rowWidth;
  final double totalAreaWithBuffer;

  SolarCalculationResult({
    required this.totalLoad,
    required this.panelsRequired,
    required this.totalAreaRequired,
    required this.totalAreaWithBuffer,
    required this.rows,
    required this.panelsPerRow,
    required this.rowLength,
    required this.rowWidth,
  });
}

SolarCalculationResult calculateSolarSystem({
  required List<Appliance> appliances,
  required double panelWatt,
  required double panelEfficiencyPercent,
  required double panelWidthFt,
  required double panelHeightFt,
  required int rows,
}) {
  final totalLoad = appliances.fold(0.0, (sum, a) => sum + a.totalWattage);
  final usablePanelWatt = panelWatt * (panelEfficiencyPercent / 100);
  final panelsRequired = (totalLoad / usablePanelWatt).ceil();

  final panelArea = panelWidthFt * panelHeightFt;
  final totalArea = panelArea * panelsRequired;
  final totalAreaWithBuffer = totalArea * 1.15; // 15% extra for spacing

  final panelsPerRow = (panelsRequired / rows).ceil();
  final rowLength = panelsPerRow * panelWidthFt;
  final rowWidth = panelHeightFt * rows;

  return SolarCalculationResult(
    totalLoad: totalLoad,
    panelsRequired: panelsRequired,
    totalAreaRequired: totalArea,
    totalAreaWithBuffer: totalAreaWithBuffer,
    rows: rows,
    panelsPerRow: panelsPerRow,
    rowLength: rowLength,
    rowWidth: rowWidth,
  );
}
