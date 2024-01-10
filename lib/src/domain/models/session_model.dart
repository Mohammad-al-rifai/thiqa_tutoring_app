class Session {
  int? instructorId;
  int? studentId;
  String? startFromTime;
  String? dayName;

  Session({this.instructorId, this.studentId, this.startFromTime,this.dayName});

  Session.fromJson(Map<String, dynamic> json) {
    instructorId = json['instructor_id'];
    studentId = json['student_id'];
    startFromTime = json['start_from_time'];
    dayName = json['day_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instructor_id'] = instructorId;
    data['student_id'] = studentId;
    data['start_from_time'] = startFromTime;
    data['day_name'] = dayName;
    return data;
  }
}
