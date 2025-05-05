import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';

abstract class AnnState extends Equatable{
  final List<Announcement> ? announcements;
  final Announcement ? announcementDetail;
  final DioException ? error;

  const AnnState({this.announcements,this.announcementDetail ,this.error});

  @override
  List<Object> get props => [announcements!, error!];
}

class AnnouncementLoading extends AnnState{
  const AnnouncementLoading();
}

class AnnouncementDone extends AnnState {
  final int currentPage;
  const AnnouncementDone(List<Announcement> announcement, {required this.currentPage}) : super(announcements: announcement);
}


class AnnouncementDetailDone extends AnnState {
  final int aid;
  const AnnouncementDetailDone(Announcement announcement, {required this.aid}) : super(announcementDetail: announcement);
}

class AnnouncementError extends AnnState{
  const AnnouncementError(DioException error) : super(error: error);
}