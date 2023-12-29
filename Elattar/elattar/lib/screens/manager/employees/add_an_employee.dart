// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddAnEmployee extends StatefulWidget {
  const AddAnEmployee({Key? key}) : super(key: key);
  static String id = 'AddAnEmployee';

  @override
  State<AddAnEmployee> createState() => _AddAnEmployeeState();
}

class _AddAnEmployeeState extends State<AddAnEmployee> {

  late String emailManager = '';
  late String passwordManager = '';

  ver() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot info = await FirebaseFirestore.instance.collection('Manager').doc(user!.uid).get();
    setState(() {
      emailManager = info['email'];
      passwordManager = info['password'];
    });
  }

  @override
  void initState() {
    ver();
    super.initState();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _auth = Auth();
  late Reference ref;
  late String name;
  late String phone;
  late String nationalId;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'إضافه مُسوق',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 40,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 5,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child:  Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل الإسم';
                          }
                          return null;
                        },
                        onSaved: (value){
                          name = value!;
                        },
                        autofillHints: const [AutofillHints.name],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الإسم',
                          labelText: 'إسم المُسوق',
                          prefixIcon: Icon(Icons.drive_file_rename_outline_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.phone,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل الرقم';
                          }
                          return null;
                        },
                        onSaved: (value){
                          phone = value!;
                        },
                        autofillHints: const [AutofillHints.telephoneNumber],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الرقم',
                          labelText: 'رقم المُسوق',
                          prefixIcon: Icon(Icons.phone),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل الرقم القومي';
                          }
                          return null;
                        },
                        onSaved: (value){
                          nationalId = value!;
                        },
                        autofillHints: const [AutofillHints.creditCardNumber],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'الرقم القومي',
                          labelText: 'الرقم القومي للمُسوق',
                          prefixIcon: Icon(Icons.numbers_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل البريد الإلكتروني';
                          }
                          return null;
                        },
                        onSaved: (value){
                          email = value!;
                        },
                        autofillHints: const [AutofillHints.creditCardNumber],
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'البريد الإلكتروني',
                          labelText: 'البريد الإلكتروني للمُسوق',
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child:TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'أدخل رقم سري';
                          }
                          return null;
                        },
                        onSaved: (value){
                          password = value!;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '*********',
                          labelText: 'الرقم السري',
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                    ),
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
                              if (_globalKey.currentState!.validate())
                              {
                                _globalKey.currentState!.save();
                                showLoading(context);
                                final auth = Auth();
                                try {
                                  await FirebaseAuth.instance.signOut();
                                  await _auth.signUp(name,phone,nationalId,email, password,);
                                  await FirebaseAuth.instance.signOut();
                                  await auth.signIn(emailManager, passwordManager);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();

                                  // Navigator.pushNamedAndRemoveUntil(context, Login.id, (route) => false);
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
                              } else {}
                            },
                            // color: Colors.blue,
                            child: const Text(
                              ' تسجيل المُسوق ',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 30),
                  ]
              ),
            ),
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
