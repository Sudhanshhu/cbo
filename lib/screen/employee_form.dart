import 'package:cbo_employee/service/firestore_db.dart';
import 'package:cbo_employee/utils/const.dart';
import 'package:cbo_employee/utils/show_msg_utils.dart';
import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../widget/custom_text_form.dart';
import 'common_bg.dart';

class EmployeeFormScreen extends StatefulWidget {
  static const routeName = "employeeFormScreen";
  final EmployeeModel? employee;
  const EmployeeFormScreen({super.key, this.employee});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _form = GlobalKey<FormState>();
  final employeeCodeController = TextEditingController();
  final emplyeeNameController = TextEditingController();
  final adressController = TextEditingController();
  final mobileNoController = TextEditingController();
  final dobController = TextEditingController();
  final remarkController = TextEditingController();
  Color color = Colors.black;
  bool employeeCodeEditable = true;
  bool searchingCodeId = false;
  bool isLoading = false;

  @override
  void dispose() {
    employeeCodeController.dispose();
    emplyeeNameController.dispose();
    adressController.dispose();
    mobileNoController.dispose();
    dobController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setTextFieldValue(widget.employee, false);
    if (widget.employee != null) {
      employeeCodeEditable = false;
    }
    super.initState();
  }

  setTextFieldValue(EmployeeModel? employeeModel, bool addingNew) {
    if (employeeModel != null) {
      emplyeeNameController.text = employeeModel.employeeName.toString();
      adressController.text = employeeModel.adress1.toString();
      mobileNoController.text = employeeModel.mobileNo.toString();
      dobController.text = employeeModel.dateOfBirth.toString();
      remarkController.text = employeeModel.remarks.toString();
      if (!addingNew) {
        employeeCodeController.text = employeeModel.employeeCode.toString();
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonBackground(
        title: "Add New Employee",
        actionWidget: const [],
        isBackBtnEnabled: true,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textFormTitle("Employee Code"),
                        CustomTextForm(
                            keyBoardType: TextInputType.number,
                            editable: employeeCodeEditable,
                            suffixIcon: !employeeCodeEditable
                                ? null
                                : searchingCodeId
                                    ? const SizedBox(
                                        height: 2,
                                        width: 8,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ))
                                    : null,
                            borderColor: color,
                            controller: employeeCodeController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter code";
                              }
                              if (int.tryParse(value) == null) {
                                return "Please enter valid number";
                              }
                              return null;
                            },
                            onchange: (String? value) async {
                              int? id = int.tryParse(value.toString()) == null
                                  ? null
                                  : int.parse(value.toString());
                              if (id != null) {
                                setState(() {
                                  searchingCodeId = true;
                                });
                                try {
                                  EmployeeModel? employee = await FirestoreDb
                                      .checkIfEmployeeIdPresent(id);
                                  if (employee != null) {
                                    ShowMsgUtils.showsnackBar(
                                        title:
                                            "$value Employee id is already present",
                                        color: Colors.red);
                                    setState(() {
                                      setTextFieldValue(employee, true);
                                      color = Colors.red;
                                    });
                                  } else {
                                    ShowMsgUtils.showsnackBar(
                                        title: "$value Id is available");
                                    setState(() {
                                      emplyeeNameController.text = "";
                                      adressController.text = "";
                                      mobileNoController.text = "";
                                      dobController.text = "";
                                      remarkController.text = "";
                                      color = Colors.green;
                                    });
                                  }

                                  setState(() {
                                    searchingCodeId = false;
                                  });
                                } catch (e) {
                                  ShowMsgUtils.showsnackBar(
                                      title:
                                          "Something went wrong while fetching user details");
                                  setState(() {
                                    searchingCodeId = false;
                                  });
                                }
                              }
                            },
                            hintText: "Employee code"),
                        textFormTitle("Employee name"),
                        CustomTextForm(
                            borderColor: color,
                            controller: emplyeeNameController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter name";
                              }
                              return null;
                            },
                            onchange: (String? value) {},
                            hintText: "Employee name"),
                        textFormTitle("Address 1 "),
                        CustomTextForm(
                            borderColor: color,
                            controller: adressController,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter address";
                              }
                              return null;
                            },
                            onchange: (String? value) {},
                            hintText: "Address"),
                        textFormTitle("Employee Mobile no."),
                        CustomTextForm(
                            borderColor: color,
                            maxLength: 10,
                            controller: mobileNoController,
                            keyBoardType: TextInputType.phone,
                            validator: (String? value) {
                              if (value == null || value.length != 10) {
                                return "Please enter valid mobile number";
                              }
                              return null;
                            },
                            onchange: (String? value) {},
                            hintText: "Mobile number"),
                        textFormTitle("Date of birth in dd/mm/yyyy"),
                        CustomTextForm(
                            borderColor: color,
                            controller: dobController,
                            keyBoardType: TextInputType.datetime,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter Date of birth";
                              }
                              var isValidDate = isDate(value, "dd/MM/yyyy");
                              if (!isValidDate) {
                                return "Please enter valid date";
                              }
                              return null;
                            },
                            onchange: (String? value) {},
                            hintText: "Date of birth in dd/mm/yyyy"),
                        textFormTitle("Remarks"),
                        CustomTextForm(
                            borderColor: color,
                            controller: remarkController,
                            maxLine: 3,
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter remarks";
                              }
                              return null;
                            },
                            onchange: (String? value) {},
                            hintText: "Remarks"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    var isValid =
                                        _form.currentState?.validate();
                                    if (isValid == false) {
                                      return;
                                    }
                                    if (int.tryParse(
                                            employeeCodeController.text) ==
                                        null) {
                                      ShowMsgUtils.showsnackBar(
                                          title: "Please enter int type Id");
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });

                                    EmployeeModel newEmployee = EmployeeModel(
                                        employeeCode: int.parse(
                                            employeeCodeController.text),
                                        adress1: adressController.text,
                                        dateOfBirth: dobController.text,
                                        employeeName:
                                            emplyeeNameController.text,
                                        mobileNo: mobileNoController.text,
                                        remarks: remarkController.text);
                                    employeeCodeEditable
                                        ? await FirestoreDb.addEmployee(
                                            newEmployee)
                                        : await FirestoreDb.updateEmployee(
                                            newEmployee);
                                    if (mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(employeeCodeEditable
                                      ? "Submit"
                                      : "Update")),
                            ),
                            if (!employeeCodeEditable)
                              Center(
                                child: OutlinedButton(
                                  onPressed: () async {
                                    EmployeeModel newEmployee = EmployeeModel(
                                        employeeCode: int.parse(
                                            employeeCodeController.text),
                                        adress1: adressController.text,
                                        dateOfBirth: dobController.text,
                                        employeeName:
                                            emplyeeNameController.text,
                                        mobileNo: mobileNoController.text,
                                        remarks: remarkController.text);

                                    var confirmed =
                                        await deleteConfirmationAlertDialog(
                                            context, newEmployee);
                                    if (confirmed) {
                                      try {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        FirestoreDb.deleteEmployee(
                                                newEmployee.employeeCode)
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      } catch (e) {
                                        ShowMsgUtils.showsnackBar(
                                            title:
                                                "Cannot delete employee something went wrong",
                                            color: Colors.red);
                                      }
                                    }
                                  },
                                  child: const Text("Delete"),
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFormTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Text(title),
    );
  }
}
