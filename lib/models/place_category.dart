class PlaceCategory {
  String name;
  bool isSelected;

  PlaceCategory(String name) {
    this.name = name;
    this.isSelected = false;
  }

  @override
  String toString() {
    return this.name;
  }
}

class PlaceCategories {
  List<PlaceCategory> placeCategories = [
    PlaceCategory('amusement_park'),
    PlaceCategory('art_gallery'),
    PlaceCategory('bar'),
    PlaceCategory('beauty_salon'),
    PlaceCategory('bowling_alley'),
    PlaceCategory('cafe'),
    PlaceCategory('casino'),
    PlaceCategory('gym'),
    PlaceCategory('library'),
    PlaceCategory('liquor_store'),
    PlaceCategory('meal_takeaway'),
    PlaceCategory('movie_rental'),
    PlaceCategory('movie_theater'),
    PlaceCategory('museum'),
    PlaceCategory('night_club'),
    PlaceCategory('park'),
    PlaceCategory('restaurant'),
    PlaceCategory('shopping_mall'),
    PlaceCategory('spa'),
    PlaceCategory('stadium'),
    PlaceCategory('tourist_attraction'),
    PlaceCategory('zoo')
  ];
}
