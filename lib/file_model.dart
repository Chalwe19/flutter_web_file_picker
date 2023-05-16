import 'dart:io';
import 'dart:typed_data';

class DocModel {
  int? id;
  String? path;
  String? name;
  File? file;
  String? mimeType;
  Uint8List? fileBytes;

  DocModel({
    this.path,
    this.name,
    this.file,
    this.mimeType,
    this.id,
    this.fileBytes,
  });
}
