

import 'package:front_end/features/domain/entity/identity/User.dart';

class Judge extends User {
  final String ? title;

  Judge({
    super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    this.title
  });
}