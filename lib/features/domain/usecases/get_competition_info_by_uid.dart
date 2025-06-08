import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/TeamWithProject.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';

class GetCompetitionInfoByUIDUseCase implements UseCase<DataState<TeamWithProject>, String>{
  final CompetitionRepository _competitionRepository;
  
  GetCompetitionInfoByUIDUseCase(this._competitionRepository);
  
  @override
  Future<DataState<TeamWithProject>> call({String? params}) {
    return _competitionRepository.getCompetitionInfoByUID(params!);
  }
}