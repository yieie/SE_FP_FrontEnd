
class Project {
  final String ? workID;
  final String ? name;
  final String ? abstract;
  final String ? sdgs;
  final String ? introductionFile;
  final String ? consentFile;
  final String ? affidavitFile;
  final List<String> ? url;
  final double? score;
  final String? state;

  const Project({
    this.workID,
    this.name='',
    this.abstract='',
    this.sdgs='',
    this.introductionFile='',
    this.consentFile='',
    this.affidavitFile='',
    this.url,
    this.score,
    this.state
  });

  Project copyWith({
    String ? workID,
    String ? name,
    String ? abstract,
    String ? sdgs,
    String ? introductionFile,
    String ? consentFile,
    String ? affidavitFile,
    List<String> ? url,
    double ? score,
    String ? state
  }) {
    return Project(
      workID: workID ?? this.workID,
      name:name ?? this.name,
      abstract: abstract ?? this.abstract,
      sdgs: sdgs ?? this.sdgs,
      introductionFile: introductionFile ?? introductionFile,
      consentFile: consentFile ?? consentFile,
      affidavitFile: affidavitFile ?? affidavitFile,
      url: url ?? this.url,
      score: score ?? this.score,
      state: state ?? this.state
    );
  }

}