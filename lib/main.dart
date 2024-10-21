import 'package:flutter/material.dart';
import 'Circle.dart';
import 'Rectangle.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator Menu',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: HomeScreen(),
    );
  }
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  List<MenuItem> filteredMenuItems = menuItems;

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredMenuItems = menuItems;
      } else {
        filteredMenuItems = menuItems
            .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Calculation'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search calculations...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Menu Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: filteredMenuItems.length,
                itemBuilder: (context, index) {
                  return MenuCard(menuItem: filteredMenuItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final MenuItem menuItem;

  MenuCard({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => menuItem.route),
        );
      },
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(menuItem.icon, size: 60, color: Colors.grey[800]),
              SizedBox(height: 20),
              Text(
                menuItem.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final Widget route;

  MenuItem({required this.title, required this.icon, required this.route});
}

List<MenuItem> menuItems = [
  MenuItem(
    title: 'Circle Area',
    icon: Icons.circle_outlined,
    route: CalculatorScreen(),
  ),
  MenuItem(
    title: 'Rectangle Area',
    icon: Icons.square_outlined,
    route: RectangleCalculatorScreen(),
  ),
  MenuItem(
    title: 'Take a Picture',
    icon: Icons.camera_alt_outlined,
    route: PictureAnalysisScreen(),
  ),
];

// class CircleAreaScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Circle Area Calculation'),
//       ),
//       body: Center(
//         child: Text('Circle Area Calculation Screen'),
//       ),
//     );
//   }
// }

// class RectangleAreaScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rectangle Area Calculation'),
//       ),
//       body: Center(
//         child: Text('Rectangle Area Calculation Screen'),
//       ),
//     );
//   }
// }

class PictureAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Analysis'),
      ),
      body: const Center(
        child: Text('Picture Analysis Screen'),
      ),
    );
  }
}
