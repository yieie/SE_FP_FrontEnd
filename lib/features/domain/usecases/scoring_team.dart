import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/repositories/score_repository.dart';

class GetScoreList implements UseCase<DataState<ResponseMessage>, int>{
  final ScoreRepository _scoreRepository;
  
  GetScoreList(this._scoreRepository);
  
  @override
  Future<DataState<ResponseMessage>> call({int? params,double score=0,String judgeid='',String workid=''}) {
    return _scoreRepository.scoringTeam(score, judgeid, workid);
  }
  
}