class WorkDay {
  int? id;
  String? dayName;
  String? fromTime;
  String? toTime;
  int? instructorId;

  WorkDay({
    this.id,
    this.dayName,
    this.fromTime,
    this.toTime,
    this.instructorId,
  });

  WorkDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['day_name'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    instructorId = json['instructor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dayName'] = dayName;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    data['instructorId'] = instructorId;
    return data;
  }
}
