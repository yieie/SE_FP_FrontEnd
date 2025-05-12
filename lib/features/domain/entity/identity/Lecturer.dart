import 'package:front_end/features/domain/entity/identity/User.dart';

class Lecturer extends User{
  Lecturer({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone
  });
}