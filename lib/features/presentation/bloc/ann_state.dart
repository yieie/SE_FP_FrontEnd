import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';
import 'package:front_end/features/domain/entity/AnnouncementList.dart';

abstract class AnnState extends Equatable{
  final AnnouncementList ? announcementList;
  final Announcement ? announcementDetail;
  final DioException ? error;

  const AnnState({this.announcementList,this.announcementDetail ,this.error});

  @override
  List<Object?> get props => [announcementList,announcementDetail, error];
}

class AnnouncementLoading extends AnnState{
  const AnnouncementLoading();
}

class AnnouncementDone extends AnnState {
  final int currentPage;
  const AnnouncementDone(AnnouncementList announcementList, {required this.currentPage}) : super(announcementList: announcementList);

  @override
  List<Object?> get props => [announcementList, currentPage];
}


class AnnouncementDetailDone extends AnnState {
  final int aid;
  const AnnouncementDetailDone(Announcement announcement, {required this.aid}) : super(announcementDetail: announcement);

  @override
  List<Object?> get props => [announcementDetail, aid];
}

class AnnouncementError extends AnnState{
  const AnnouncementError(DioException error) : super(error: error);
}