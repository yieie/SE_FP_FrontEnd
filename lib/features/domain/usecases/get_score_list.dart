import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
import 'package:front_end/features/domain/repositories/score_repository.dart';

class GetScoreList implements UseCase<DataState<TeamWithProjectList>, int>{
  final ScoreRepository _scoreRepository;
  
  GetScoreList(this._scoreRepository);
  
  @override
  Future<DataState<TeamWithProjectList>> call({int? params}) {
    return _scoreRepository.getScoreList(params??1);
  }
  
}