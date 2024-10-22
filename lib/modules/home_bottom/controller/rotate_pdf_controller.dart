import 'package:get/get.dart';

class RotatePdfController extends GetxController {
  var rotationAngle = 0.obs; // Observable to track rotation angle (in degrees)

  // Method to rotate PDF left (counterclockwise)
  void rotateLeft() {
    rotationAngle.value -= 90; // Rotate left by 90 degrees
  }

  // Method to rotate PDF right (clockwise)
  void rotateRight() {
    rotationAngle.value += 90; // Rotate right by 90 degrees
  }
}
