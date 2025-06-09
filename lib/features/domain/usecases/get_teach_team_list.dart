import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/TeamWithProjectList.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';

class GetTeachTeamListUseCase implements UseCase<DataState<TeamWithProjectList>, void>{
  final CompetitionRepository _competitionRepository;

  GetTeachTeamListUseCase(this._competitionRepository);

  @override
  Future<DataState<TeamWithProjectList>> call({void params,int? page, String? teacherid}) {
    return _competitionRepository.getTeachTeam(page!, teacherid!);
  }

}