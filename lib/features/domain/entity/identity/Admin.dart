
import 'package:front_end/features/domain/entity/identity/User.dart';

class Admin extends User{
  Admin({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone
  });
}