class UserModel {
  const UserModel({
    required this.name,
    required this.avatar,
    required this.token,
  });

  final String name;
  final String avatar;

  //use auth repo for this
  final String token;

  static const UserModel ui = UserModel(
    name: "Abdullah",
    avatar: "https://avatars.githubusercontent.com/u/104672914?s=96&v=4",
    token: "token",
  );
}
