import 'package:front_end/features/domain/entity/identity/User.dart';

class Lecturer extends User{
  final String ? title;
  Lecturer({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    this.title
  });
}