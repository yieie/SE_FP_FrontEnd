import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:front_end/features/domain/entity/Announcement.dart';

abstract class AnnState extends Equatable{
  final List<Announcement> ? announcements;
  final DioException ? error;

  const AnnState({this.announcements, this.error});

  @override
  List<Object> get props => [announcements!, error!];
}

class AnnouncementLoading extends AnnState{
  const AnnouncementLoading();
}

class AnnouncementDone extends AnnState {
  const AnnouncementDone(List<Announcement> announcement) : super(announcements: announcement);
}

class AnnouncementError extends AnnState{
  const AnnouncementError(DioException error) : super(error: error);
}