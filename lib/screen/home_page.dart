import 'package:cbo_employee/utils/show_msg_utils.dart';
import 'package:flutter/material.dart';

import '../model/employee_model.dart';
import '../service/firestore_db.dart';
import '../utils/const.dart';
import '../widget/custom_button.dart';
import 'common_bg.dart';
import 'employee_form.dart';

class HomePage extends StatelessWidget {
  static const routeName = "homePage";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      actionWidget: const [LogOutBtn()],
      title: "Welcome",
      isBackBtnEnabled: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Stack(
          children: [
            StreamBuilder(
              stream: FirestoreDb.employeesStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return (snapshot.data == null || snapshot.data!.isEmpty)
                      ? const Center(
                          child: Text("No Employee details found"),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            EmployeeModel employee = snapshot.data![index];
                            return ListTile(
                              onLongPress: () {
                                deleteConfirmationAlertDialog(
                                    context, employee);
                              },
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // navigator.push<void>(

                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            EmployeeFormScreen(
                                              employee: snapshot.data![index],
                                            )),
                                  );
                                },
                              ),
                              title: Text(employee.employeeName),
                            );
                          },
                        );
                }
                if (snapshot.hasError) {
                  ShowMsgUtils.showsnackBar(title: "Something went wrong");
                  return Text(
                      "Something went wrong please try again later.The error is ${snapshot.error} ");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const Text("Loading");
              },
            ),
            Positioned(
              right: 50,
              bottom: 50,
              child: FloatingActionButton(
                backgroundColor: AppConst.primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed("employeeFormScreen");
                },
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
