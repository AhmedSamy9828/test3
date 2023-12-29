import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/manager/employees/add_an_employee.dart';
import 'package:elattar/screens/manager/employees/employee_profile.dart';
import 'package:elattar/screens/manager/employees/employee_work_file.dart';
import 'package:flutter/material.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key}) : super(key: key);
  static String id = 'Employees';

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  @override
  Widget build(BuildContext context) {
    var refFireStore = FirebaseFirestore.instance.collection('Moderators');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المُسوقين',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddAnEmployee.id);
          },
          icon: const Icon(
            Icons.person_add_alt_1,
            // color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: refFireStore.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {return const Center(child: Text('Something went wrong'));}
            if (snapshot.connectionState == ConnectionState.waiting) {return const Center(child: Text("Loading"));}
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, i) {
                  String moderatorId = snapshot.data!.docs[i].id;
                  String moderatorName = snapshot.data!.docs[i]['name'];
                  String moderatorPhone = snapshot.data!.docs[i]['phone'];
                  String moderatorNationId = snapshot.data!.docs[i]['nationalId'];
                  String moderatorEmail = snapshot.data!.docs[i]['email'];
                  String moderatorPassword = snapshot.data!.docs[i]['password'];
                  return InkWell(
                    onTap: (){},
                    child:SizedBox(
                      height: 100,
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeProfile(
                                          moderatorId: moderatorId,
                                          moderatorName: moderatorName,
                                          moderatorPhone: moderatorPhone,
                                          moderatorNationId: moderatorNationId,
                                          moderatorEmail: moderatorEmail,
                                          moderatorPassword: moderatorPassword,
                                        )
                                    )
                                );
                              },
                              child:   const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  height: 80,
                                  width:  100,
                                  child: Icon(Icons.person),
                                  // Image.asset(
                                  //   'image',
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EmployeeWorkFile(
                                          moderatorId: moderatorId,
                                          // moderatorName: moderatorName,
                                          // moderatorPhone: moderatorPhone,
                                          // moderatorNationId: moderatorNationId,
                                          // moderatorEmail: moderatorEmail,
                                          // moderatorPassword: moderatorPassword,
                                        )
                                    )
                                );
                              },
                              child: Column(
                                children: <Widget>[
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          moderatorName,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SizedBox(
                                      // height: 90,
                                      // width:  200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10),
                                        child: AutoSizeText(
                                          moderatorEmail,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                          ),
                                          minFontSize: 10,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
  widgetInkWell({image, name, sale, tap, tapWork, tapProfile}){
    return InkWell(
      onTap: tap,
      child:SizedBox(
        height: 100,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: tapProfile,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 80,
                    width:  100,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: tapWork,
                child: Column(
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        // height: 90,
                        // width:  200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AutoSizeText(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            minFontSize: 10,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        // height: 90,
                        // width:  200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AutoSizeText(
                            sale,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            minFontSize: 10,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
