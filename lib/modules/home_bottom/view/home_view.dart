import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemeye_pdf_mobile/common/add_password.dart';
import 'package:stemeye_pdf_mobile/common/add_stamp.dart';
import 'package:stemeye_pdf_mobile/common/add_watermark.dart';
import 'package:stemeye_pdf_mobile/common/auto_split.dart';
import 'package:stemeye_pdf_mobile/common/compress_pdf.dart';
import 'package:stemeye_pdf_mobile/common/crop_pdf.dart';
import 'package:stemeye_pdf_mobile/common/cus_user_input.dart';
import 'package:stemeye_pdf_mobile/common/custom/custom_app_bar.dart';
import 'package:stemeye_pdf_mobile/common/custom/verticlacon.dart';
import 'package:stemeye_pdf_mobile/common/delete_pages.dart';
import 'package:stemeye_pdf_mobile/common/merge_multipage_intoone.dart';
import 'package:stemeye_pdf_mobile/common/overlaypdf.dart';
import 'package:stemeye_pdf_mobile/common/picked_file.dart';
import 'package:stemeye_pdf_mobile/common/remove_blank_pages.dart';
import 'package:stemeye_pdf_mobile/common/remove_pass.dart';
import 'package:stemeye_pdf_mobile/common/rotate.pdf.dart';
import 'package:stemeye_pdf_mobile/modules/file_bottom/controller/files_controller.dart';
import 'package:stemeye_pdf_mobile/modules/home_bottom/binding/home_binding.dart';
import 'package:stemeye_pdf_mobile/utils/constant/colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final toggelController = Get.put(FilesController());
    //final allConversion = AllConversion();
    return Scaffold(
      appBar: CustomAppBar(
        title: "All-In-One",
        subtitle: "Pdf Tools",
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.withOpacity(0.2)),
              child: IconButton(
                icon: Icon(
                  Icons.swap_vert,
                  color: MyColors.black,
                ), // Button to switch layout
                onPressed: () {
                  toggelController
                      .toggleLayout(); // Toggle layout on button press
                },
              ),
            ),
          ),
        ],
        bgColor: Colors.blue.withOpacity(0.2),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                return toggelController.isStacked.value
                    ? Column(
                        children: [
                          Column(
                            // Vertical stacked layout
                            children: buildContainers(),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          GridView.count(
                            crossAxisCount:
                                3, // Grid layout with 3 containers per row
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: buildContainers(),
                          ),
                        ],
                      );
              }))),
    );
  }

// Method to build the containers
  List<Widget> buildContainers() {
    final toggelController = Get.put(FilesController());
    return [
      Verticlacon(
        //containerColor: Colors.grey.withOpacity(0.010),
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Pdf to Xml",
        isStacked: toggelController.isStacked.value,
        conversionIcon: 'assets/conversion_icons/pdftoxml.svg',
        ontap: () async {
          String conversionType = 'pdf to xml';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
      ),
      Verticlacon(
        containerColor: Colors.blue.withOpacity(0.2),
        containerName: "Pdf to word",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to word';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftoword.svg',
      ),
      Verticlacon(
        containerColor: Color.fromARGB(255, 13, 145, 145),
        containerName: "Pdf to Rttext",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to rttext';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftorttext.svg',
      ),
      Verticlacon(
        containerColor: Colors.orange,
        containerName: "Pdf to Prensent",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to presentation';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftopresentation.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Pdf to Pdfa",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to pdfa';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftopdfa.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 140, 150, 0),
        containerName: "Pdf to Image",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to image';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftoimage.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Pdf to Csv",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to csv';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftocsv.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Pdf to Html",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to html';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftohtml.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 76, 44, 131),
        containerName: "Pdf to S.Page",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf to single page';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftosinglepage.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Markdown to Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'markdown';
          Get.to(CusUserInput(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/markdowntopdf.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Url to Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'url';
          Get.to(CusUserInput(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/urltopdf.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "File to Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'file to pdf';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/filetopdf.svg',
      ),
      Verticlacon(
        containerColor: const Color.fromARGB(255, 13, 145, 145),
        containerName: "Html to Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'html to pdf';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdftohtml.svg',
      ),
      // Verticlacon(
      //   containerColor: const Color.fromARGB(255, 140, 150, 0),
      //   containerName: "Images to Pdf",
      //   isStacked: toggelController.isStacked.value,
      //   ontap: () async {
      //     String conversionType = 'images to pdf';
      //     Get.to(PickedfileScreen(conversionType: conversionType),
      //         binding: HomeBinding());
      //   },
      //   conversionIcon: 'assets/conversion_icons/pdftoimage.svg',
      // ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Seneitize",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'sanitize pdf';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/sanitizepdf.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Remove Pass",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'remove password';
          Get.to(RemovePass(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/removepass.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Remove Cert",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'remove certificate';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/removecertificate.svg',
      ),
      Verticlacon(
        containerColor: Colors.green,
        containerName: "Pdf info",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'pdf info';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/pdfinfo.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Protect Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'protect pdf';
          Get.to(AddPassword(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/protectpdf.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Repair Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'repair pdf';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/repairpdf.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Watermark",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'add watermark';
          Get.to(AddWatermark(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/addwatermark.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Remove B-Pages",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'remove blank pages';
          Get.to(RemoveBlankPages(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/removeblankpages.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Flatten Pdf",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'flatten pdf';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/flatten.svg',
      ),
      Verticlacon(
        containerColor: Colors.green,
        containerName: "Extract Images",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'extract images';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/extractimage.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Compress",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          //String conversionType = 'extract images';
          Get.to(
              CompressPdf(
                conversionType: 'compress',
              ),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/compress.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Rename",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'auto rename';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/rename.svg',
      ),
      Verticlacon(
        containerColor: Colors.pink,
        containerName: "Stamp",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'add stamp';
          Get.to(AddStamp(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/addstamp.svg',
      ),
      Verticlacon(
        containerColor: Colors.green,
        containerName: "Add P.Num",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'add page num';
          Get.to(AddStamp(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/addpagenum.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Split Size",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'split by size';
          Get.to(AutoSplitPdf(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/splitsize.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Split Page Count",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'split by page counte';
          Get.to(AutoSplitPdf(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/splitpage.svg',
      ),
      Verticlacon(
        containerColor: Colors.red,
        containerName: "Split Doc count",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'split by doc count';
          Get.to(AutoSplitPdf(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/splitdoc.svg',
      ),
      Verticlacon(
        containerColor: Colors.deepPurple,
        containerName: "Delete Pages",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          //String conversionType = 'split by doc count';
          Get.to(
              DeletePages(
                conversionType: 'delete pages',
              ),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/deletepages.svg',
      ),
      Verticlacon(
        containerColor: Colors.deepPurple,
        containerName: "Rotate",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          //String conversionType = 'split by doc count';
          Get.to(
              Rotatepdf(
                conversionType: 'rotate pdf',
              ),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/rotatepdf.svg',
      ),
      Verticlacon(
        containerColor: Colors.green,
        containerName: "Remove Images",
        isStacked: toggelController.isStacked.value,
        ontap: () async {
          String conversionType = 'remove images';
          Get.to(PickedfileScreen(conversionType: conversionType),
              binding: HomeBinding());
        },
        conversionIcon: 'assets/conversion_icons/removeimages.svg',
      ),
      // Verticlacon(
      //   containerColor: Colors.green,
      //   containerName: "Overlay",
      //   isStacked: toggelController.isStacked.value,
      //   ontap: () async {
      //     //String conversionType = '';
      //     Get.to(
      //         Overlaypdf(
      //           conversionType: 'overlay',
      //         ),
      //         binding: HomeBinding());
      //   },
      //   conversionIcon: 'assets/conversion_icons/overlaypdf.svg',
      // ),
      // Verticlacon(
      //   containerColor: Colors.deepPurple,
      //   containerName: "Crop",
      //   isStacked: toggelController.isStacked.value,
      //   ontap: () async {
      //     //String conversionType = '';
      //     Get.to(
      //         CropPdf(
      //           conversionType: 'crop pdf',
      //         ),
      //         binding: HomeBinding());
      //   },
      //   conversionIcon: 'assets/conversion_icons/croppdf.svg',
      // ),
      // Verticlacon(
      //   containerColor: Colors.deepPurple,
      //   containerName: "Merge",
      //   isStacked: toggelController.isStacked.value,
      //   ontap: () async {
      //     //String conversionType = '';
      //     Get.to(
      //         MergeMultipageIntoone(
      //           conversionType: 'mul page into one',
      //         ),
      //         binding: HomeBinding());
      //   },
      //   conversionIcon: 'assets/conversion_icons/merge.svg',
      // ),
    ];
  }
}
