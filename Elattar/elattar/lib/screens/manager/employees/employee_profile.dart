import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmployeeProfile extends StatefulWidget {
  const EmployeeProfile({Key? key,
    required this.moderatorId,
    required this.moderatorName,
    required this.moderatorPhone,
    required this.moderatorNationId,
    required this.moderatorEmail,
    required this.moderatorPassword,
  }) : super(key: key);
  static String id = 'EmployeeProfile';

  final String moderatorId;
  final String moderatorName;
  final String moderatorPhone;
  final String moderatorNationId;
  final String moderatorEmail;
  final String moderatorPassword;

  @override
  State<EmployeeProfile> createState() => _EmployeeProfileState();
}
// ignore: prefer_typing_uninitialized_variables
var imageurl;
class _EmployeeProfileState extends State<EmployeeProfile> {

  late String email = '';
  late String password = '';
  late String moderatorId = widget.moderatorId;

  ver() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot info = await FirebaseFirestore.instance.collection('Manager').doc(user!.uid).get();
    setState(() {
      email= info['email'];
      password= info['password'];
    });
  }

  @override
  void initState() {
    ver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الصفحه الشخصيه',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          alignment: Alignment.center,
          height: screenHeight * .9,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: const Text(
                    'إسم المُسوق',
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(name ?? 'إسم المستخدم'),
                  subtitle: Text(
                    widget.moderatorName,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: const Text(
                    'رقم المُسوق',
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(name ?? 'إسم المستخدم'),
                  subtitle: Text(
                    widget.moderatorPhone,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: const Text(
                    'الرقم القومي للمُسوق',
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(name ?? 'إسم المستخدم'),
                  subtitle: Text(
                    widget.moderatorNationId,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: const Text(
                    'البريد الإلكتروني للمُسوق',
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(name ?? 'إسم المستخدم'),
                  subtitle: Text(
                    widget.moderatorEmail,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  title: const Text(
                    'الرقم السري للمُسوق',
                    style: TextStyle(color: Colors.black),
                  ),
                  // subtitle: Text(name ?? 'إسم المستخدم'),
                  subtitle: Text(
                    widget.moderatorPassword,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    // ignore: deprecated_member_use
                    builder: (context) => ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: getColor(Colors.blue, Colors.red)
                      ),
                      onPressed: () async {
                        {
                          showLoading(context);
                          final auth = Auth();
                          try {
                            await FirebaseAuth.instance.signOut();
                            await auth.signIn(widget.moderatorEmail, widget.moderatorPassword);
                            await Auth().deleteUser(widget.moderatorEmail, widget.moderatorPassword);
                            await auth.signIn(email, password);
                            await FirebaseFirestore.instance.collection('Moderators').doc(widget.moderatorId).delete();

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }on FirebaseAuthException catch (e) {
                            Navigator.of(context).pop();
                            AwesomeDialog(
                                context : this.context,
                                title: 'الحاله',
                                body:  e.message != null ? Text(e.code)
                                    : const Text('حدث خطأ ما: بالرجاء المحاوله لاحقاً'),
                                dialogType: DialogType.warning)
                                .show();
                          }
                        }
                      },
                      // color: Colors.blue,
                      child: const Text(
                        ' حذف المُسوق ',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  MaterialStateProperty<Color> getColor(Color color, Color colorPressed){
    getColor(Set<MaterialState> state){
      if(state.contains(MaterialState.pressed)){
        return colorPressed;
      } else {
        return color;
      }
    }
    return MaterialStateProperty.resolveWith(getColor);
  }
  showLoading(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              title: Text('من فضلك أنتظري قليلاً'),
              content: SizedBox(
                  height: 50,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              )
          );
        }
    );
  }
}
