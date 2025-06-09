import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/CompetitionForm.dart';
import 'package:front_end/features/domain/repositories/competition_repository.dart';

class EditCompetitionInfoUseCase implements UseCase<DataState<ResponseMessage>,void> {
  final CompetitionRepository _competitionRepository;

  EditCompetitionInfoUseCase(this._competitionRepository);

  @override
  Future<DataState<ResponseMessage>> call({void params,CompetitionForm? data, String? workid, String? teamid}) async {
    final essential = await _competitionRepository.editCompetitionInfo(teamid!, workid!, data!);
    if(essential is DataFailed){
      return essential;
    }
    if(data.affidavitFile != null || data.consentFile != null || data.introductionFile != null){
      if(data.affidavitFile != null){
        final delete = await _competitionRepository.deleteAffidavitFile(workid);
        if(delete is DataFailed){
          return delete;
        }
      }
      if(data.consentFile != null){
        final delete = await _competitionRepository.deleteConsentFile(workid);
        if(delete is DataFailed){
          return delete;
        }
      }
      if(data.introductionFile != null){
        final delete = await _competitionRepository.deleteIntroductionFile(workid);
        if(delete is DataFailed){
          return delete;
        }
      }
      final upload =await _competitionRepository.uploadFiles(workid, data.consentFile, data.introductionFile, data.affidavitFile);
      if(upload is DataFailed){
        return upload;
      }
    }
    if(data.members != null){
      for(int i=0;i<data.members!.length;i++){
        final delete = await _competitionRepository.deleteStudentCard(data.members![i].studentID);
        if(delete is DataFailed){
          return delete;
        }
        final upload = await _competitionRepository.uploadStudentIDCard(data.members![i].studentID, data.members![i].idCard);
        if(upload is DataFailed){
          return upload;
        }
      }
    }
    return essential;
  }

}