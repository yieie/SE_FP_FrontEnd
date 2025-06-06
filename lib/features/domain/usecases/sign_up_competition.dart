import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';

class SignUpCompetitionUseCase extends UseCase<DataState<ResponseMessage>, CompetitionForm>{
  final CompetitionRepository _competitionRepository;

  SignUpCompetitionUseCase(this._competitionRepository);

  @override
  Future<DataState<ResponseMessage>> call({CompetitionForm? params}) async {
    final essential = await _competitionRepository.signUpCompetition(params!);
    if(essential is DataFailed){
        return essential;
      }
    for(int i=0; i<params.members!.length; i++){
      final studentID = await _competitionRepository.uploadStudentIDCard(params.members![i].studentID, params.members![i].idCard);
      if(studentID is DataFailed){
        return studentID;
      }
    }
    
    final files = await _competitionRepository.uploadFiles(essential.data!.extraData!["workId"], params.consentFile!, params.introductionFile!, params.affidavitFile!);
    return files;
  }

}