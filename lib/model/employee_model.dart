import 'dart:convert';

class EmployeeModel {
  final int employeeCode;
  final String employeeName;
  final String adress1;
  final String mobileNo;
  final String dateOfBirth;
  final String remarks;
  EmployeeModel({
    required this.employeeCode,
    required this.employeeName,
    required this.adress1,
    required this.mobileNo,
    required this.dateOfBirth,
    required this.remarks,
  });

  EmployeeModel copyWith({
    int? employeeCode,
    String? employeeName,
    String? adress1,
    String? mobileNo,
    String? dateOfBirth,
    String? remarks,
  }) {
    return EmployeeModel(
      employeeCode: employeeCode ?? this.employeeCode,
      employeeName: employeeName ?? this.employeeName,
      adress1: adress1 ?? this.adress1,
      mobileNo: mobileNo ?? this.mobileNo,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      remarks: remarks ?? this.remarks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'employeeCode': employeeCode,
      'employeeName': employeeName,
      'adress1': adress1,
      'mobileNo': mobileNo,
      'dateOfBirth': dateOfBirth,
      'remarks': remarks,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      employeeCode: map['employeeCode']?.toInt() ?? 0,
      employeeName: map['employeeName'] ?? '',
      adress1: map['adress1'] ?? '',
      mobileNo: map['mobileNo'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      remarks: map['remarks'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EmployeeModel(employeeCode: $employeeCode, employeeName: $employeeName, adress1: $adress1, mobileNo: $mobileNo, dateOfBirth: $dateOfBirth, remarks: $remarks)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel &&
        other.employeeCode == employeeCode &&
        other.employeeName == employeeName &&
        other.adress1 == adress1 &&
        other.mobileNo == mobileNo &&
        other.dateOfBirth == dateOfBirth &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return employeeCode.hashCode ^
        employeeName.hashCode ^
        adress1.hashCode ^
        mobileNo.hashCode ^
        dateOfBirth.hashCode ^
        remarks.hashCode;
  }
}
