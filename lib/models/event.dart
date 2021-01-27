class Event {
  String name;
  String locationCity;
  String locationAddress;
  int categoryID;
  String categoryName;
  String dateTimeBegin;
  String dateTimeEnd;
  String description;
  int userRating;

  Event(
      {this.name,
      this.locationCity,
      this.locationAddress,
      this.categoryID,
      this.categoryName,
      this.dateTimeBegin,
      this.dateTimeEnd,
      this.description,
      this.userRating});

  factory Event.fromJson(dynamic json) {
    return Event(
      name: json['event_name'],
      locationCity: json['location_city'],
      locationAddress: json['location_address'],
      categoryID: json['category_id'],
      categoryName: json['category_name'],
      dateTimeBegin: json['begin_time'],
      dateTimeEnd: json['end_time'],
      description: json['description'],
      userRating: int.parse(json['rating']),
    );
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.locationCity}, ${this.locationAddress}, ${this.categoryID}, ${this.categoryName}, ${this.dateTimeBegin}, ${this.dateTimeEnd}, ${this.description}, ${this.userRating} }';
  }
}
