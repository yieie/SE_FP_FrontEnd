import 'dart:io';

import 'package:dio/dio.dart';
import 'package:front_end/features/domain/entity/identity/Attendee.dart';
import 'package:file_picker/file_picker.dart';
import 'package:front_end/features/domain/entity/identity/Student.dart';

enum SubmissionStatus { initial, submitting, success, failure }

class SignUpCompetitionState {
  final SubmissionStatus status;
  final int currentPage;
  final String? errorMessage;
  final DioException? error;
  final String teamName;
  final String teamType;
  final String projectName;
  final String projectAbstract;
  final String ytUrl;
  final String githubUrl;
  final Set<int> sdgs;
  final List<Student> members;
  final List<PlatformFile?> studentCard;
  final String teacherID;
  final String teacherName;
  final String teacherTitle;
  final String teacherDepartment;
  final String teacherOrganization;
  final PlatformFile? introductionFile;
  final PlatformFile? consentFile;
  final PlatformFile? affidavitFile;

  SignUpCompetitionState({
    this.status = SubmissionStatus.initial,
    this.currentPage = 0,
    this.errorMessage,
    this.error,
    this.teamName = '',
    this.teamType = '',
    this.projectName = '',
    this.projectAbstract = '',
    this.ytUrl = '',
    this.githubUrl='',
    this.sdgs = const <int>{},
    this.members = const <Attendee>[],
    this.studentCard = const <PlatformFile>[],
    this.teacherID='',
    this.teacherName = '',
    this.teacherTitle = '',
    this.teacherDepartment='',
    this.teacherOrganization = '',
    this.introductionFile,
    this.consentFile,
    this.affidavitFile,
  });

  SignUpCompetitionState copyWith({
    SubmissionStatus ? status,
    int? currentPage,
    String ? errorMessage,
    DioException? error,
    String? teamName,
    String? teamType,
    String? projectName,
    String? projectAbstract,
    String? ytUrl,
    String? githubUrl,
    Set<int>? sdgs,
    List<Student>? members,
    List<PlatformFile?>? studentCard,
    String? teacherID,
    String? teacherName,
    String? teacherTitle,
    String? teacherDepartment,
    String? teacherOrganization,
    PlatformFile? introductionFile,
    PlatformFile? consentFile,
    PlatformFile? affidavitFile,
  }) {
    return SignUpCompetitionState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error ?? this.error,
      teamName: teamName ?? this.teamName,
      teamType: teamType ?? this.teamType,
      projectName: projectName ?? this.projectName,
      projectAbstract: projectAbstract ?? this.projectAbstract,
      ytUrl: ytUrl ?? this.ytUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      sdgs: sdgs ?? this.sdgs,
      members: members ?? this.members,
      studentCard: studentCard ?? this.studentCard,
      teacherID: teacherID ?? this.teacherID,
      teacherName: teacherName ?? this.teacherName,
      teacherTitle: teacherTitle ?? this.teacherTitle,
      teacherDepartment: teacherDepartment ?? this.teacherDepartment,
      teacherOrganization: teacherOrganization ?? this.teacherOrganization,
      introductionFile: introductionFile ?? this.introductionFile,
      consentFile: consentFile ?? this.consentFile,
      affidavitFile: affidavitFile ?? this.affidavitFile,
    );
  }

}
