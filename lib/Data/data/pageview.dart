class Data {
  final String title;
  final String imageurl;

  Data({
    required this.title,
    required this.imageurl,
  });
}

final List<Data> myData = [
  Data(title: "sport is useful to you", imageurl: "images/sports.png"),
  Data(
    title: "Sport is a group of exercises and physical movements",
    imageurl: "images/sport-png-png-mart-21.png",
  ),
  Data(
    title: "How do I become a sports person?",
    imageurl: "images/question.png",
  )
];
