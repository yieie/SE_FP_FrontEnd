import 'package:front_end/features/domain/entity/identity/Attendee.dart';

class AttendeeModel extends Attendee{
  AttendeeModel({
    required super.uid,
    super.name,
    super.email,
    super.sexual,
    super.phone,
    super.department,
    super.grade,
    super.studentCard,
    super.teamID,
    super.workID
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      uid: json['uId'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      sexual: json['sexual'] as String?,
      phone: json['phone'] as String?,
      department: json['studentInfo']['department'] as String?,
      grade: json['studentInfo']['grade'] as String?,
      studentCard: json['attendeeInfo']['studentCard'] as String?,
      teamID: json['attendeeInfo']['teamId'] as String?,
      workID: json['attendeeInfo']['workId'] as String?
    );
  }

  factory AttendeeModel.fromEntity(AttendeeModel attendee){
    return AttendeeModel(
      uid: attendee.uid,
      name: attendee.name,
      email: attendee.email,
      sexual: attendee.sexual,
      phone: attendee.phone,
      department: attendee.department,
      grade: attendee.grade
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "uId": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "sexual": sexual,
      "studentInfo": {
          "department": department,
          "grade": grade
      },
    };
  }
}