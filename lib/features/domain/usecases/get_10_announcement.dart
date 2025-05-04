import 'dart:ffi';

import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';

class Get10AnnouncementUseCase implements UseCase<DataState<List<Announcement>>, int>{
  final AnnRepository _annRepository;

  Get10AnnouncementUseCase(this._annRepository);
  
  @override
  Future<DataState<List<Announcement>>> call({int? params}) {
    return _annRepository.get10announcement(params??0);
  }
  
}