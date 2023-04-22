import 'dart:convert'; // to parse JSON

class User {
  final String password;
  final String email;

  User(this.password, this.email);
}

class Profile{
  late String first_name;
  late String  last_name;
  late String email;
  late String phone_number;
  late String regNo;
  late String id;
  late String student_profile;
}

class Institution {
  String id;
  String name;

  Institution({required this.id, required this.name});

  factory Institution.fromJson(Map<String, dynamic> json) {
    return Institution(
      id: json['id'],
      name: json['institution_name'],
    );
  }
}
class ClassModel{
    late String class_id;
    late String unit_id;
    late String lec_id;
    late String class_sem;
    late String class_year;
    late String class_start;
    late String date_start;
    late String time_start;
    late String class_stop;
    late String date_stop;
    late String time_stop;
    late String status;
    late String class_code;
    late String unit_name;
    late String unit_code;
    late String lec_name;
    ClassModel({ 
      required this.class_id, 
      required this.unit_id,
      required this.lec_id,
      required this.class_sem, 
      required this.class_year, 
      required this.class_start,
      required this.date_start,
      required this.time_start,
      required this.class_stop,
      required this.date_stop,
      required this.time_stop,
      required this.status,
      required this.class_code,
      required this.unit_code,
      required this.unit_name,
      required this.lec_name

     });
    factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      class_id: json[' class_id'],
      unit_id: json['unit_id'],
      lec_id: json['lec_id'],
      class_sem: json['class_sem'],
      class_year: json['class_year'],
      class_start: json['class_start'],
      date_start: json['date_start'],
      time_start: json['time_start'],
      class_stop: json['class_stop'],
      date_stop: json['date_stop'],
      class_code: json['class_code'],
      status: json['status'],
      unit_code: json['unit_code'],
      unit_name: json['unit_name'],
      lec_name: json['lec_name'],
      time_stop: json['time_stop'],

    );
  }
}
