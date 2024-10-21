import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimalist Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _radiusController = TextEditingController();

  double _circleArea = 0.0;

  void _calculateCircleArea() {
    final radius = double.tryParse(_radiusController.text);
    if (radius != null) {
      setState(() {
        _circleArea = 3.1416 * radius * radius;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minimalist Calculator'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDescriptionText(
                      'สูตรคำนวณพื้นที่วงกลม: พื้นที่ = π x รัศมียกกำลังสอง\n'
                      'กรุณากรอกรัศมีเพื่อคำนวณพื้นที่วงกลม',
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    _buildTextField(
                      controller: _radiusController,
                      label: 'Radius of Circle',
                      icon: Icons.circle_outlined,
                    ),
                    SizedBox(height: 8),
                    _buildCalculateButton(
                      label: 'Calculate Circle Area',
                      onPressed: _calculateCircleArea,
                    ),
                    SizedBox(height: 8),
                    _buildResultText('Circle Area: $_circleArea'),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildCalculateButton(
      {required String label, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildResultText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDescriptionText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[800],
      ),
    );
  }
}
