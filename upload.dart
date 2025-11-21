import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadFilesPage extends StatefulWidget {
  const UploadFilesPage({super.key});

  @override
  State<UploadFilesPage> createState() => _UploadFilesPageState();
}

class _UploadFilesPageState extends State<UploadFilesPage> {
  List<String> uploadedFiles = [];

  
  Future<bool> requestAllFilesPermission() async {
    var status = await Permission.manageExternalStorage.status;

    if (status.isGranted) return true;

    status = await Permission.manageExternalStorage.request();

    if (status.isGranted) return true;

    // If denied again, open settings manually
    await openAppSettings();
    return false;
  }

  // ⭐ File Picker Function
  Future<void> pickFile() async {
    print("PICKER OPENING...");

    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      withData: true,
      withReadStream: true,
    );

    print("PICKER RAN");

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;

      setState(() {
        uploadedFiles.add(file.name);
      });

      print("FILE SELECTED → ${file.name}");
    } else {
      print("User cancelled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Upload Files",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Upload your project files:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 20),

            // ⭐ UPLOAD BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text(
                  "Choose File",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onPressed: () async {
                  print("BUTTON WORKED");

                  // STEP 1 → Ask Vivo for FULL FILE ACCESS
                  bool allowed = await requestAllFilesPermission();
                  if (!allowed) {
                    print("Permission not granted");
                    return;
                  }

                  // STEP 2 → Open file picker
                  await pickFile();
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Uploaded Files",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ⭐ FILE LIST
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    uploadedFiles.isEmpty
                        ? const Center(
                          child: Text(
                            "No files uploaded yet.",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                        : ListView.builder(
                          itemCount: uploadedFiles.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.insert_drive_file,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: Text(
                                      uploadedFiles[index],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),

                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        uploadedFiles.removeAt(index);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
