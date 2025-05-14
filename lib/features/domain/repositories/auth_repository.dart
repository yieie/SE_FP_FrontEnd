

import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Student.dart';

abstract class AuthRepository {
  Future<DataState<Student>> signUp(Student student, String password);
}