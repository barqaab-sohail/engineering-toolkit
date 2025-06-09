import 'package:flutter/material.dart';
import 'solar_logic.dart';

class SolarHome extends StatefulWidget {
  const SolarHome({Key? key}) : super(key: key);

  @override
  State<SolarHome> createState() => _SolarHomeState();
}

class _SolarHomeState extends State<SolarHome> {
  final _appliances = <Appliance>[];

  final _applianceNameController = TextEditingController();
  final _applianceWattageController = TextEditingController();
  final _applianceQtyController = TextEditingController();
  int _installationRows = 1;

  double _panelWatt = 0;
  double _panelEfficiency = 100;
  double _panelWidth = 0;
  double _panelHeight = 0;

  SolarCalculationResult? _result;

  void _addAppliance() {
    final name = _applianceNameController.text.trim();
    final watt = double.tryParse(_applianceWattageController.text.trim()) ?? 0;
    final qty = int.tryParse(_applianceQtyController.text.trim()) ?? 1;

    if (name.isEmpty || watt <= 0 || qty <= 0) return;

    setState(() {
      _appliances.add(Appliance(name: name, wattage: watt, quantity: qty));
      _applianceNameController.clear();
      _applianceWattageController.clear();
      _applianceQtyController.clear();
    });
  }

  void _calculateSolarSystem() {
    if (_appliances.isEmpty ||
        _panelWatt <= 0 ||
        _panelEfficiency <= 0 ||
        _panelWidth <= 0 ||
        _panelHeight <= 0)
      return;

    final result = calculateSolarSystem(
      appliances: _appliances,
      panelWatt: _panelWatt,
      panelEfficiencyPercent: _panelEfficiency,
      panelWidthFt: _panelWidth,
      panelHeightFt: _panelHeight,
      rows: _installationRows,
    );

    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solar Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add Appliance",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _applianceNameController,
              decoration: const InputDecoration(labelText: 'Appliance Name'),
            ),
            TextField(
              controller: _applianceWattageController,
              decoration: const InputDecoration(labelText: 'Wattage (W)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _applianceQtyController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _addAppliance,
              child: const Text("Add Appliance"),
            ),
            const SizedBox(height: 10),
            if (_appliances.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    _appliances
                        .map(
                          (a) => Text(
                            "- ${a.name}: ${a.wattage}W x ${a.quantity} = ${a.totalWattage}W",
                          ),
                        )
                        .toList(),
              ),
            const Divider(height: 30),

            const Text(
              "Solar Panel Info",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Panel Wattage (W)'),
              keyboardType: TextInputType.number,
              onChanged: (val) => _panelWatt = double.tryParse(val) ?? 0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Efficiency (%)'),
              keyboardType: TextInputType.number,
              onChanged:
                  (val) => _panelEfficiency = double.tryParse(val) ?? 100,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Panel Width (feet)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => _panelWidth = double.tryParse(val) ?? 0,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Panel Height (feet)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => _panelHeight = double.tryParse(val) ?? 0,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Number of Installation Rows',
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) => _installationRows = int.tryParse(val) ?? 1,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculateSolarSystem,
              child: const Text("Calculate Solar System"),
            ),
            const SizedBox(height: 20),
            if (_result != null) ...[
              Text("🔌 Total Load: ${_result!.totalLoad.toStringAsFixed(2)} W"),
              Text("🔆 Required Panels: ${_result!.panelsRequired}"),
              Text(
                "📐 Panel Area Only: ${_result!.totalAreaRequired.toStringAsFixed(2)} ft²",
              ),
              Text(
                "➕ Area with 15% Spacing: ${_result!.totalAreaWithBuffer.toStringAsFixed(2)} ft²",
              ),
              Text(
                "📏 Rows: ${_result!.rows}, Panels/Row: ${_result!.panelsPerRow}",
              ),
              Text(
                "🧱 Layout: ${_result!.rowLength.toStringAsFixed(2)} ft (L) x ${_result!.rowWidth.toStringAsFixed(2)} ft (W)",
              ),
            ],
          ],
        ),
      ),
    );
  }
}
