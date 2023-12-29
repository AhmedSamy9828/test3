import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elattar/screens/manager/home_manager.dart';
import 'package:elattar/screens/moderators/home_moderators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:elattar/firebase_options.dart';
import 'package:elattar/routes.dart';
import 'package:elattar/screens/login.dart';
import 'package:flutter/material.dart';

late bool isLogin;
late String typeUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  User? user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLogin = false;
  }else{
    isLogin = true;
    DocumentSnapshot manager = await FirebaseFirestore.instance.collection('Manager').doc(user.uid).get();
    DocumentSnapshot moderators = await FirebaseFirestore.instance.collection('Moderators').doc(user.uid).get();
    if (manager.exists) {
      typeUser = 'manager';
    }else{
      if (moderators.exists) {typeUser = 'moderators';}
    }
    // if(manager.exists == false && moderators.exists == false ){typeUser = 'null';}
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      debugShowCheckedModeBanner: false,

      initialRoute:
        isLogin == true /* && ver == true */ &&  typeUser == 'manager' ? HomeManager.id
      : isLogin == true /* && ver == true */ && typeUser == 'moderators' ? HomeModerators.id
      // : isLogin == true /* && ver == true */ && typeUser == 'null' ? HomeModerators.id
          : Login.id,
      // initialRoute: Login.id,
      routes: routes,
    );
  }

}
