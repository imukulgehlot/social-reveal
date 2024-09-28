class CommonUIModel {
  final String title;
  final String? image;
  final String? body;
  final String? thirdLine;
  bool isSelected;
  DateTime? dateTime;
  bool isSelectedTwo;
  final List<CommonUIModel>? innerList;

  CommonUIModel(
      {this.image,
      this.body,
      this.isSelectedTwo = false,
      this.thirdLine,
      this.dateTime,
      this.innerList,
      required this.title,
      this.isSelected = false});
}
