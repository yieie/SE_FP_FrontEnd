

import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/AnnouncementList.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';

class Get10AnnouncementUseCase implements UseCase<DataState<AnnouncementList>, int>{
  final AnnRepository _annRepository;
  
  Get10AnnouncementUseCase(this._annRepository);
  
  @override
  Future<DataState<AnnouncementList>> call({int? params}) {
    return _annRepository.get10announcement(params??0);
  }
  
}