class Event {
  String name;
  String locationCity;
  String locationAddress;
  String category;
  DateTime dateTimeBegin;
  DateTime dateTimeEnd;
  String description;
  int userRating;

  Event(
      {this.name,
      this.locationCity,
      this.locationAddress,
      this.category,
      this.dateTimeBegin,
      this.dateTimeEnd,
      this.description,
      this.userRating});
}
