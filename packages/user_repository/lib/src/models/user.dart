class User {
  final String? uid;
  const User({required this.uid});

  static const empty = User(uid: "0");
}