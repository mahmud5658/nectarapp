class UserModel {
  const UserModel({
    required this.name,
    required this.avatar,
    required this.token,
  });

  final String name;
  final String avatar;

  final String token;

  static const UserModel ui = UserModel(
    name: "",
    avatar: "https://cdn3.iconfinder.com/data/icons/business-avatar-1/512/3_avatar-512.png",
    token: "token",
  );
}
