import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_file/open_file.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_listtile.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/controller/files_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/controller/home_controller.dart';
import 'package:stemeye_pdf_mobile/utils/helpers/helper_function.dart';

class FilesView extends StatelessWidget {
  FilesView({super.key});

  final TextEditingController searchController = TextEditingController();

  // Function to return appropriate icon based on file extension
  Widget getFileIcon(String filePath) {
    print("File path: $filePath"); // Print the file path
    // Clean the file name to avoid unwanted characters
    String cleanedFilePath =
        filePath.split('(').first.trim(); // Remove anything after '('
    final extension = cleanedFilePath
        .split('.')
        .last
        .toLowerCase()
        .trim(); // Get the file extension

    print("File extension: $extension");

    // Define a map for file extensions and their corresponding icon paths
    const fileIcons = {
      'pdf': 'assets/convert_file/pdf.svg',
      'ppt': 'assets/convert_file/presentation.svg',
      'pptx': 'assets/convert_file/presentation.svg',
      'doc': 'assets/convert_file/word.svg',
      'docx': 'assets/convert_file/word.svg',
      'txt': 'assets/convert_file/text.svg',
      'rtf': 'assets/convert_file/text.svg',
      'png': 'assets/convert_file/image.svg',
      'jpg': 'assets/convert_file/image.svg',
      'csv': 'assets/convert_file/csv.svg',
      'html': 'assets/convert_file/html.svg',
      'xml': 'assets/convert_file/xml.svg',
      'zip': 'assets/convert_file/zipfile.svg',
    };

    // Return the corresponding icon if found, otherwise return the unknown icon
    final iconPath = fileIcons[extension] ?? 'assets/convert_file/pdf.svg';
    print("Returning icon path: $iconPath");

    return SvgPicture.asset(
      iconPath,
      height: 40,
      width: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    FilesController _controller = Get.put(FilesController());
    HomeController homeController =
        Get.find<HomeController>(); // Keep this to access latest conversions

    // Load the conversion history when the view is built
    homeController.loadConversionHistory();
    _controller.allConversions
        .assignAll(homeController.conversionHistory); // Assign all conversions

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return _controller.isSearching.value
              ? TextField(
                  controller: _controller.searchController,
                  onChanged: (value) {
                    _controller.filterFiles(value);
                  },
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle:
                        TextStyle(fontSize: 16, color: Colors.grey.shade500),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Colors.transparent,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black.withOpacity(0.5),
                        size: 25,
                      ),
                      onPressed: () {
                        _controller.searchController.clear();
                        _controller.filterFiles('');
                        _controller.toggleSearch();
                      },
                    ),
                  ),
                )
              : Text(
                  "Files",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                );
        }),
        actions: [
          Obx(() {
            return _controller.isSearching.value
                ? SizedBox() // Hide action icons when searching
                : IconButton(
                    onPressed: () {
                      _controller.toggleSearch();
                    },
                    icon: Icon(Iconsax.search_normal_14),
                  );
          }),
        ],
        backgroundColor: Colors.blue.withOpacity(0.2),
      ),
      body: Obx(() {
        // final conversions = _controller.filteredConversions;

        // if (conversions.isEmpty) {
        //   return Center(child: Text("No files found"));
        // }
        //Combine completed conversions and conversion history
        // Use the filtered list for display
        final filesToDisplay = _controller.filteredConversions.isEmpty
            ? _controller
                .allConversions // Display all conversions if no filtered results
            : _controller.filteredConversions;
        if (filesToDisplay.isEmpty) {
          return Center(child: Text("No favorites yet"));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListView.builder(
            //itemCount: homeController.conversionHistory.length,
            itemCount: filesToDisplay.length,
            itemBuilder: (context, index) {
              // final conversion = homeController.conversionHistory[index];
              final conversion = filesToDisplay[index];

              // Wrap ListTile with Container
              return Container(
                height: MyHelperFunctions.screenHeight() * 0.1,
                margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey
                      .withOpacity(0.2), // Background color for each item
                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white, // Shadow color
                      offset: Offset(0, 4), // Shadow position
                      blurRadius: 4.0, // Shadow blur effect
                    ),
                  ],
                ),
                // child: ListTile(
                //   leading: getFileIcon(conversion.filePath),
                //   title: Text(conversion.filePath.split('/').last,
                //       style:
                //           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                //   //Text(conversion.conversionType),
                //   subtitle: Text(
                //     // "${conversion.filePath} - ${conversion.timestamp}",
                //     conversion.timestamp.toString(),
                //     style: TextStyle(fontSize: 12),
                //     overflow: TextOverflow.ellipsis,
                //   ),

                //   //add to fav
                //   trailing: Obx(() {
                //     // Check if this conversion is in the favorite list
                //     bool isFavorite = _controller.favoriteConversions
                //         .any((fav) => fav.filePath == conversion.filePath);

                //     return IconButton(
                //       icon: Icon(
                //         isFavorite ? Iconsax.star5 : Iconsax.star_1,
                //         color: isFavorite ? Colors.red : null,
                //         size: 30,
                //       ),
                //       onPressed: () {
                //         // Toggle favorite status when star icon is clicked
                //         if (isFavorite) {
                //           _controller.removeFromFavorites(conversion);
                //         } else {
                //           _controller.addToFavorites(conversion);
                //         }
                //       },
                //     );
                //   }),
                //   onTap: () async {
                //     print('Attempting to open file at: ${conversion.filePath}');

                //     final fileExists = await File(conversion.filePath).exists();
                //     print('File exists: $fileExists');

                //     if (!fileExists) {
                //       Get.snackbar('Error',
                //           'File does not exist: ${conversion.filePath}');
                //       return;
                //     }

                //     Get.dialog(Center(
                //         child:
                //             CircularProgressIndicator())); // Show loading indicator

                //     final result = await OpenFile.open(conversion.filePath);
                //     Get.back(); // Close the loading dialog
                //     if (result.type == ResultType.error) {
                //       Get.snackbar(
                //           'Error', 'Could not open file: ${result.message}');
                //     }
                //   },
                // ),
                child: CustomListTile(
                  title: Text(
                    conversion.filePath.split('/').last,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    // "${conversion.filePath} - ${conversion.timestamp}",
                    conversion.timestamp.toString(),
                    style: TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                  leading: getFileIcon(conversion.filePath),
                  trailing: //   //add to fav
                      Obx(() {
                    // Check if this conversion is in the favorite list
                    bool isFavorite = _controller.favoriteConversions
                        .any((fav) => fav.filePath == conversion.filePath);

                    return IconButton(
                      icon: Icon(
                        isFavorite ? Iconsax.star5 : Iconsax.star_1,
                        color: isFavorite ? Colors.red : null,
                        size: 30,
                      ),
                      onPressed: () {
                        // Toggle favorite status when star icon is clicked
                        if (isFavorite) {
                          _controller.removeFromFavorites(conversion);
                        } else {
                          _controller.addToFavorites(conversion);
                        }
                      },
                    );

                    // //popup menu button
                    // PopupMenuButton<String>(
                    //   icon: Icon(Icons.more_vert),
                    //   onSelected: (String value) {
                    //     switch (value) {
                    //       case 'Info':
                    //         _controller.showFileInfo(
                    //             context, conversion.filePath);
                    //         break;
                    //       case 'Rename':
                    //         _controller.renameFile(conversion.filePath);
                    //         break;
                    //       case 'Delete':
                    //         _controller.deleteFile(conversion.filePath);
                    //         break;
                    //       case 'Share':
                    //         _controller.shareFile(conversion.filePath);
                    //         break;
                    //     }
                    //   },
                    //   itemBuilder: (BuildContext context) {
                    //     return [
                    //       PopupMenuItem(
                    //         value: 'Info',
                    //         child: Text('Info'),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Rename',
                    //         child: Text('Rename'),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Delete',
                    //         child: Text('Delete'),
                    //       ),
                    //       PopupMenuItem(
                    //         value: 'Share',
                    //         child: Text('Share'),
                    //       ),
                    //     ];
                  }),
                  onTap: () async {
                    print('Attempting to open file at: ${conversion.filePath}');

                    // Encode the file path to handle spaces and special characters
                    //final encodedFilePath = Uri.encodeFull(conversion.filePath);

                    final fileExists = await File(conversion.filePath).exists();
                    print('File exists: $fileExists');

                    if (!fileExists) {
                      Get.snackbar('Error',
                          'File does not exist: ${conversion.filePath}');
                      return;
                    }

                    // Compare the paths
                    print('Original file path: ${conversion.filePath}');

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
          ),
        );
      }),
    );
  }
}
