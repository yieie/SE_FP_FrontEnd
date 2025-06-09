import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/features/domain/entity/Admin_Overview.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
import 'package:front_end/features/domain/entity/UserList.dart';


abstract class AdminRepository {
  Future<DataState<AdminOverview>> getOverview();

  Future<DataState<TeamWithProjectList>> getVertifyTeam(int page, int year);

  Future<DataState<ResponseMessage>> updateTeamState(String teamid, String state, String? message);

  Future<DataState<TeamWithProjectList>> getScoreResults(int page,String year,String teamType);
  
  Future<DataState<UserList>> getUserList(int page, String usertype);
}