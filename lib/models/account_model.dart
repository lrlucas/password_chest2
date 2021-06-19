class AccountModel {
  int id;
  String title;
  String url;
  String email;
  String password;

  AccountModel({
    this.id,
    this.title = '',
    this.email,
    this.url,
    this.password,
  });

  factory AccountModel.fromJson(Map<String, dynamic> res) => AccountModel(
        id: res["id"],
        title: res["title"],
        url: res["url"],
        email: res["email"],
        password: res["password"],
      );

  // returned like a json object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'email': email,
      'url': url,
      'password': password,
    };
  }
}
