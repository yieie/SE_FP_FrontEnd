import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

abstract class CompetitionRepository {
  Future<DataState<ResponseMessage>> signUpCompetition(CompetitionForm data);

  Future<DataState<ResponseMessage>> uploadStudentIDCard(String uid, PlatformFile filePath);

  Future<DataState<ResponseMessage>> uploadFiles(String workid, PlatformFile? consent, PlatformFile? introduction, PlatformFile? affidavit);

  Future<DataState<ResponseMessage>> editCompetitionInfo(String teamid,String workid,CompetitionForm data);

  Future<DataState<ResponseMessage>> deleteAffidavitFile(String workid);

  Future<DataState<ResponseMessage>> deleteConsentFile(String workid);

  Future<DataState<ResponseMessage>> deleteIntroductionFile(String workid);

  Future<DataState<ResponseMessage>> deleteStudentCard(String uid);

  Future<DataState<TeamWithProject>> getCompetitionInfoByUID(String uid);
  
  Future<DataState<TeamWithProject>> getCompetitionInfoByTeamID(String teamid);
  
  Future<DataState<List<TeamWithProject>>> getPastProjectList(String year, String teamType);

  Future<DataState<TeamWithProjectList>> getTeachTeam(int page, String teacherid);
}