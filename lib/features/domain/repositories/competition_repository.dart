import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';

abstract class CompetitionRepository {
  Future<DataState<ResponseMessage>> signUpCompetition(CompetitionForm data);

  Future<DataState<ResponseMessage>> uploadStudentIDCard(String uid, PlatformFile filePath);

  Future<DataState<ResponseMessage>> uploadFiles(String workid, PlatformFile consent, PlatformFile introduction, PlatformFile affidavit);
  
  Future<DataState<TeamWithProject>> getCompetitionInfoByUID(String uid);
}