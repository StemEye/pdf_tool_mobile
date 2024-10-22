import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stemeye_pdf_mobile/common/custom/conversion_history.dart'; // Ensure this file contains the Conversion class

class FilesController extends GetxController {
  // This flag will control the layout
  var isStacked = false.obs;

  //Observable list for conversion history
  var conversionHistory = <Conversion>[].obs;

  var favoriteConversions =
      <Conversion>[].obs; // Observable for favorite conversions
  var allConversions = <Conversion>[].obs; // Store all conversions
  var filteredConversions =
      <Conversion>[].obs; // Observable list for filtered files

  var isSearching = false.obs; // To control search mode

  final TextEditingController searchController = TextEditingController();

  // Method to toggle the layout
  void toggleLayout() {
    isStacked.value = !isStacked.value;
  }

  // void toggleSearch() {
  //   isSearching.value = !isSearching.value;
  //   if (!isSearching.value) {
  //    searchController.clear(); // Clear search when exiting search mode
  //     filteredConversions.clear(); // Clear filtered results
  //     filteredConversions.assignAll(allConversions); // Show all files when search mode is exited
  //   }
  // }
  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear(); // Clear search field when not searching
      filterFiles(''); // Reset file list
    }
  }

  void filterFiles(String query) {
    if (query.isEmpty) {
      filteredConversions
          .assignAll(allConversions); // Show all when query is empty
    } else {
      filteredConversions.value = allConversions
          .where((conversion) =>
              conversion.filePath.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadFavorites(); // Load favorites when the controller initializes
    // filteredConversions
    //     .assignAll(conversionHistory); // Initially all conversions are visible
  }

  // Add to fav
  void addToFavorites(Conversion conversion) {
    // Check if the conversion is already in favorites
    if (!favoriteConversions
        .any((fav) => fav.filePath == conversion.filePath)) {
      favoriteConversions.add(conversion); // Add to observable list
      saveFavorites(); // Save the updated favorites to shared preferences
    }
  }

// Add remove from fav
  void removeFromFavorites(Conversion conversion) {
    favoriteConversions
        .removeWhere((fav) => fav.filePath == conversion.filePath);
    saveFavorites(); // Save the updated favorites to shared preferences
  }

// Update the loadFavorites method to also load favorite conversions
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoritesJson = prefs.getString('favoriteConversions');

    if (favoritesJson != null) {
      List<dynamic> favoritesList = jsonDecode(favoritesJson);
      favoriteConversions.value = favoritesList
          .map((item) => Conversion.fromJson(item))
          .toList()
          .cast<Conversion>();
    }
  }

// save fav in pref
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favoritesList =
        favoriteConversions.map((item) => item.toJson()).toList();
    await prefs.setString('favoriteConversions', jsonEncode(favoritesList));
  }

  // void openConvertedFile(String filePath) {
  //   try {
  //     // Encode the file path to handle spaces and special characters
  //     String encodedPath = Uri.encodeFull(filePath);

  //     // Open the file using your preferred method (e.g., launching a viewer)
  //     File file = File(encodedPath);

  //     if (file.existsSync()) {
  //       // Proceed with opening the file using your file viewer logic
  //       // Example: Opening with a PDF viewer or another app
  //       print('File found, opening: $encodedPath');

  //       // You can use any package to open the file, like 'open_file' or 'file_picker' package
  //       // Example (using the open_file package):
  //       OpenFile.open(encodedPath);
  //     } else {
  //       print('File not found at path: $encodedPath');
  //       Get.snackbar("Error", "File not found or could not be opened.");
  //     }
  //   } catch (e) {
  //     // Catch and handle any exceptions
  //     print('Error opening file: $e');
  //     Get.snackbar("Error", "An error occurred while opening the file.");
  //   }
  // }

  //popup
  // void openFile(String filePath) async {
  //   final encodedFilePath = Uri.encodeFull(filePath);
  //   final fileExists = await File(encodedFilePath).exists();

  //   if (!fileExists) {
  //     Get.snackbar('Error', 'File does not exist: $filePath');
  //     return;
  //   }

  //   Get.dialog(
  //       Center(child: CircularProgressIndicator())); // Show loading indicator

  //   final result = await OpenFile.open(encodedFilePath);
  //   Get.back(); // Close the loading dialog
  //   if (result.type == ResultType.error) {
  //     Get.snackbar('Error', 'Could not open file: ${result.message}');
  //   }
  // }

  void renameFile(String filePath) {
    // Handle rename action
    Get.snackbar('Rename', 'Rename option selected for $filePath');
  }

  void deleteFile(String filePath) {
    // Handle delete action
    Get.snackbar('Delete', 'Delete option selected for $filePath');
  }

  void shareFile(String filePath) {
    // Handle share action
    Get.snackbar('Share', 'Share option selected for $filePath');
  }

  //show file info
  void showFileInfo(BuildContext context, String filePath) async {
    // Get the file size
    final file = File(filePath);
    final fileSize = await file.length(); // Get file size in bytes
    final fileName = file.path.split('/').last; // Get file name
    final fileCreationDate = file.statSync().changed; // Get file creation date

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(20.0),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File Info',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'File Name: $fileName',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'File Size: ${(fileSize / 1024).toStringAsFixed(2)} KB',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Date Added: ${fileCreationDate.toLocal()}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Time Added: ${fileCreationDate.hour}:${fileCreationDate.minute}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
