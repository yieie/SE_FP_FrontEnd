import 'dart:io';

import 'package:front_end/cores/resources/ResponseMessage.dart';
import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/repositories/workshop_repository.dart';

class JoinWorkshopUseCase implements UseCase<DataState<ResponseMessage>, void>{
  final WorkshopRepository _workshopRepository;

  JoinWorkshopUseCase(this._workshopRepository);
  
  @override
  Future<DataState<ResponseMessage>> call({void params , String uid='', int wsid=0}) async { 
    return _workshopRepository.joinWorkshop(uid, wsid);
  }
  
 

}