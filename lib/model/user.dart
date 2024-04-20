class User {
  final String name;
  final String email;
  final String password;

  User({required this.name, required this.email, required this.password});

  static User empty = new User(email: '', name: '', password: '');
}
