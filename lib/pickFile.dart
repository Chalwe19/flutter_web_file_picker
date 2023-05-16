import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

import 'file_model.dart';

class FilePick extends StatefulWidget {
  const FilePick({super.key});

  @override
  State<FilePick> createState() => _FilePickState();
}

class _FilePickState extends State<FilePick> {
  DocModel? pickedFile;
  bool hasFile = false;

  uploadFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'png', 'webp'],
    );

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;

      final fileName = result.files.first.name;

      final mime = lookupMimeType('', headerBytes: fileBytes);
      setState(() {
        pickedFile = DocModel(
          name: fileName,
          mimeType: mime,
          fileBytes: fileBytes,
          file: File.fromRawPath(fileBytes!),
        );
        hasFile = true;
      });
    } else {
      //user did not pick
      setState(() {
        pickedFile = DocModel();
        hasFile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: hasFile == false
          ? Center(
              child: ElevatedButton(
              onPressed: () => uploadFiles(),
              child: const Text('Upload File'),
            ))
          : Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    width: 400,
                    child: Image.memory(pickedFile!.fileBytes!),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              pickedFile = DocModel();
                              hasFile = false;
                            });
                          },
                          icon: Icon(Icons.close)))
                ],
              ),
            ),
    );
  }
}
