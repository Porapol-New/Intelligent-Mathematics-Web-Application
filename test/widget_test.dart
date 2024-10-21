import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // ส่งภาพไปประมวลผล
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Genius'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _getImage,
          child: const Text('ถ่ายภาพ'),
        ),
      ),
    );
  }
}
