class User {
  String name;
  String token;

  User(String name, String token) {
    this.name = name;
    this.token = token;
  }

  String getName() {
    return name;
  }

  String getToken() {
    return token;
  }
}
