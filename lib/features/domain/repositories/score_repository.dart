import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';

abstract class ScoreRepository {
  
  Future<DataState<TeamWithProjectList>> getScoreList(int page);

  Future<DataState<ResponseMessage>> scoringTeam(double score, String judgeid, String workid);
}