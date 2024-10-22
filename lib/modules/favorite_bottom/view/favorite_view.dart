import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_app_bar.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/controller/files_controller.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final FilesController _controller = Get.put(FilesController());

    // Load the favorite conversions when the view is built
    _controller.loadFavorites();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Favorites",
        subtitle: "Your Favorite Conversions",
        bgColor: Colors.blueAccent.withOpacity(0.2),
      ),
      body: Obx(() {
        if (_controller.favoriteConversions.isEmpty) {
          return Center(child: Text("No favorites yet"));
        }

        return ListView.builder(
          itemCount: _controller.favoriteConversions.length,
          itemBuilder: (context, index) {
            final conversion = _controller.favoriteConversions[index];

            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.picture_as_pdf, color: Colors.red),
                title: Text(conversion.filePath.split('/').last),
                subtitle: Text(
                  conversion.timestamp.toString(),
                ),
                onTap: () async {
                  print('Attempting to open file at: ${conversion.filePath}');

                  final fileExists = await File(conversion.filePath).exists();
                  print('File exists: $fileExists');

                  if (!fileExists) {
                    Get.snackbar(
                        'Error', 'File does not exist: ${conversion.filePath}');
                    return;
                  }

                  Get.dialog(Center(
                      child:
                          CircularProgressIndicator())); // Show loading indicator

                  final result = await OpenFile.open(conversion.filePath);
                  Get.back(); // Close the loading dialog
                  if (result.type == ResultType.error) {
                    Get.snackbar(
                        'Error', 'Could not open file: ${result.message}');
                  }
                },
              ),
            );
          },
        );
      }),
    );
  }
}
