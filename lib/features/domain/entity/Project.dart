import 'package:equatable/equatable.dart';

class Project extends Equatable{
  final String ? name;
  final String ? abstract;
  final String ? sdgs;
  final String ? introductionFile;
  final String ? consentFile;
  final String ? affidavitFile;
  final List<String> ? url;

  const Project({
    this.name,
    this.abstract,
    this.sdgs,
    this.introductionFile,
    this.consentFile,
    this.affidavitFile,
    this.url
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    name, abstract, sdgs, introductionFile, consentFile, affidavitFile, url
  ];

  

}