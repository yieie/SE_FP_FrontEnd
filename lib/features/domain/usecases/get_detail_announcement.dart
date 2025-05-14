import 'package:front_end/cores/resources/data_state.dart';
import 'package:front_end/cores/usecase/usecase.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/repositories/ann_repository.dart';

class GetDetailAnnouncementUseCase implements UseCase<DataState<Announcement>, int>{
  final AnnRepository _annRepository;

  GetDetailAnnouncementUseCase(this._annRepository);
  
  @override
  Future<DataState<Announcement>> call({int? params}) {
    return _annRepository.getdetailannouncement(params??0);
  }
  
}