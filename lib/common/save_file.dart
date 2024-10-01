import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';

Future<void> saveFile( String fileName, String extension, List <int> data) async {
    
      // Save the file
      await FileSaver.instance.saveAs(
        name: fileName,
        bytes: Uint8List.fromList(data),
        ext: extension,
        mimeType: MimeType.other,
      );
}
