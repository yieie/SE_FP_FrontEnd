/*

User is super class
-uid


*/

abstract class User {
  final String uid;
  final String name;
  final String email;
  final String sexual;
  final String phone;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.sexual,
    required this.phone
  });
}