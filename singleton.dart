class indexPage {
  int currentIndex = 6;

  static final indexPage _instance = indexPage._internal();

  factory indexPage() {
    return _instance;
  }

  indexPage._internal();
}
