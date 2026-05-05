abstract class Appimages{
  static const String _imagePath = 'assets/images/';
  static const String burger='${_imagePath}burger.jpg';
  static const String our_nest='${_imagePath}ournest.png';
  static const String skin='${_imagePath}skin.jpg';
  static const String text_our_nest='${_imagePath}text_our_nest.png';
  static const String box1='${_imagePath}box1.png';
  static const String box2='${_imagePath}box2.png';
  static const String box3='${_imagePath}box3.png';
  static const String box4='${_imagePath}box4.png';
  static const String box5='${_imagePath}box5.png';
  static const String box6='${_imagePath}box6.png';
  static const String partner='${_imagePath}partner.png';
  static const String baby='${_imagePath}baby.png';
  static const String person_image='${_imagePath}personphoto.png';
  static const String babyfeed='${_imagePath}babyfeed.jpg';
  static const String food='${_imagePath}food.jpg';
  static const String cry='${_imagePath}cry.jpg';
  static const String feeding='${_imagePath}feeding.jpg';
  static const String naps='${_imagePath}naps.jpg';
  static const String temperature='${_imagePath}temperature.jpg';
  static const String vaccine='${_imagePath}vaccine.jpg';
  static const String fatherimage='${_imagePath}personphoto.png';
  static const String ex1='${_imagePath}ex1.png';
  static const String ex2='${_imagePath}ex2.png';
  static String getWeekImage(int week) {
    if (week >= 1 && week <= 5) return '${_imagePath}weeks_edits/week$week.png';
    if (week == 6) return '${_imagePath}weeks_edits/week6.png';
    if (week >= 7 && week <= 24) return '${_imagePath}weeks_edits/week$week.png';
    if (week >= 25 && week <= 27) return '${_imagePath}weeks_edits/week$week.png';
    if (week >= 28 && week <= 30) return '${_imagePath}weeks_edits/week$week.png';
    if (week >= 31 && week <= 35) return '${_imagePath}weeks_edits/week$week.png';
    if (week >= 36 && week <= 40) return '${_imagePath}weeks_edits/week36.png';
    return baby; // Fallback
  }
}
