import 'package:flutter/material.dart';
import 'package:project_management/views/students/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final List<Map<String, String>> uploads = [
    {'name': 'Carrier guidance.pdf'},
    {'name': 'management system.pdf'},
    {'name': 'Chatbot development.pdf'},
    {'name': 'Smart learning.pdf'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),

            // 👉 Back Navigation Goes to Homepage
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0, top: 15),
          child: const Text(
            "Uploads",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Date uploaded',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, size: 20),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.view_headline,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.grid_view, size: 20, color: Colors.grey[700]),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: ListView.separated(
              itemCount: uploads.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return _buildFileItem(uploads[index]['name']!);
              },
            ),
          ),
        ],
      ),
    );
  }

  // FILE ITEM UI
  Widget _buildFileItem(String fileName) {
    return Container(
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.picture_as_pdf, color: Colors.white, size: 20),
              Text(
                'PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          fileName,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            _showOptionsMenu(context, fileName);
          },
        ),
      ),
    );
  }

  // BOTTOM SHEET OPTIONS
  void _showOptionsMenu(BuildContext context, String fileName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.open_in_new),
                title: const Text('Open'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
