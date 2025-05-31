import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:file_picker/file_picker.dart';

abstract class SignUpCompetitionEvent {}
class ResetSubmissionStatus extends SignUpCompetitionEvent {}

class LoadMainUserEvent extends SignUpCompetitionEvent {
  final String uid;
  LoadMainUserEvent(this.uid);
}

class AddTeammateEvent extends SignUpCompetitionEvent {
  final String uid;
  AddTeammateEvent(this.uid);
}

class AddTeacherEvent extends SignUpCompetitionEvent {
  final String uid;
  AddTeacherEvent(this.uid);
}

class SubmitCompetitionFormEvent extends SignUpCompetitionEvent {}

class GoToPreviousPage extends SignUpCompetitionEvent{}

class GoToNextPage extends SignUpCompetitionEvent{}

class UpdateFieldEvent extends SignUpCompetitionEvent {
  final String field;
  final dynamic value;

  UpdateFieldEvent(this.field, this.value);
}

class UploadStudentCard extends SignUpCompetitionEvent{
  final int order;
  final PlatformFile studentCard;

  UploadStudentCard(this.order,this.studentCard);
}

