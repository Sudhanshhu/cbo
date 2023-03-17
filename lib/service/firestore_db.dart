import 'package:cbo_employee/model/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_path.dart';

class FirestoreDb {
  static Stream<List<EmployeeModel>> employeesStream() {
    // Stream<QuerySnapshot>
    Stream<QuerySnapshot<Object?>> stream =
        FirestorePath.employeeRoutePath.snapshots();
    return stream.map((event) => event.docs
        .map((e) => EmployeeModel.fromMap(e.data() as Map<String, dynamic>))
        .toList());
  }

  static Future<void> addEmployee(EmployeeModel employeeModel) async {
    try {
      await FirestorePath.employeeRoutePath
          .doc(employeeModel.employeeCode.toString())
          .set(employeeModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateEmployee(EmployeeModel employeeModel) async {
    try {
      await FirestorePath.employeeRoutePath
          .doc(employeeModel.employeeCode.toString())
          .set(employeeModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> deleteEmployee(int docId) async {
    try {
      await FirestorePath.employeeRoutePath.doc(docId.toString()).delete();
    } catch (e) {
      rethrow;
    }
  }

  static Future<EmployeeModel?> checkIfEmployeeIdPresent(int docId) async {
    try {
      DocumentSnapshot<Object?> employee =
          await FirestorePath.employeeRoutePath.doc(docId.toString()).get();
      if (employee.exists) {
        return EmployeeModel.fromMap(employee.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
