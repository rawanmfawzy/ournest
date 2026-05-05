import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  print('Starting image crop process...');
  
  final inputPath = 'pregnancy_stages.jpg';
  final outputDir = 'assets/images/weeks';
  
  final file = File(inputPath);
  if (!file.existsSync()) {
    print('Error: Could not find image at $inputPath');
    print('Please save the image exactly as pregnancy_stages.jpg in the main ournest folder.');
    return;
  }
  
  final imageBytes = file.readAsBytesSync();
  final image = img.decodeImage(imageBytes);
  
  if (image == null) {
    print('Error: Failed to decode the image.');
    return;
  }
  
  final dir = Directory(outputDir);
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }
  
  int width = image.width;
  int height = image.height;
  int rowHeight = height ~/ 5;
  int count = 1;
  
  print('Processing rows 1 to 3 (8 images per row)...');
  for (int row = 0; row < 3; row++) {
    int colWidth = width ~/ 8;
    for (int col = 0; col < 8; col++) {
      final cropped = img.copyCrop(image, x: col * colWidth, y: row * rowHeight, width: colWidth, height: rowHeight);
      File('$outputDir/week_$count.png').writeAsBytesSync(img.encodePng(cropped));
      print('Saved week_$count.png');
      count++;
    }
  }
  
  print('Processing rows 4 to 5 (6 images per row)...');
  for (int row = 3; row < 5; row++) {
    int colWidth = width ~/ 6;
    for (int col = 0; col < 6; col++) {
      final cropped = img.copyCrop(image, x: col * colWidth, y: row * rowHeight, width: colWidth, height: rowHeight);
      File('$outputDir/week_$count.png').writeAsBytesSync(img.encodePng(cropped));
      print('Saved week_$count.png');
      count++;
    }
  }
  
  print('Duplicating last image to reach week 40...');
  while(count <= 40) {
    File('$outputDir/week_${count-1}.png').copySync('$outputDir/week_$count.png');
    print('Saved week_$count.png (Duplicated)');
    count++;
  }
  
  print('-----------------------------------------');
  print('Successfully generated 40 images in $outputDir!');
}
