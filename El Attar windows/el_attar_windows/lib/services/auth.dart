import 'package:el_attar_windows/model/user_model.dart';
import 'package:el_attar_windows/services/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(
      String name,
      String phone,
      String nationalId,
      String email,
      String password,
      ) async {
    final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password )
        .then((user) async {
      await FireStoreUser().addUserToFireStore(
          UserModel(
            userId: user.user!.uid,
            name: name,
            phone: phone,
            nationalId: nationalId,
            email: email,
            password: password,
          )
      );
    }
    );
    return authResult;
  }


  Future<UserCredential?> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }


  Future<UserCredential?> deleteUser(String email, String password) async {
    User? user = _auth.currentUser;
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
    final authResult = await user!.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete();
      // .then((value) {  });
      // print('#################  DELETE #######################');
    });
    return authResult;
  }

}








// import 'package:el_attar_windows/model/user_model.dart';
// import 'package:el_attar_windows/services/firestore_user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class Auth {
//   final _auth = FirebaseAuth.instance;
//
//   Future<UserCredential?> signUp(
//       String name,
//       String phone,
//       String nationalId,
//       String email,
//       String password,
//       ) async {
//     final authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password )
//         .then((user) async {
//       await FireStoreUser().addUserToFireStore(
//           UserModel(
//             userId: user.user!.uid,
//             name: name,
//             phone: phone,
//             nationalId: nationalId,
//             email: email,
//             password: password,
//           )
//       );
//     }
//     );
//     return authResult;
//   }
//
//
//   Future<UserCredential?> signIn(String email, String password) async {
//     final authResult = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     return authResult;
//   }
//
//
//   Future<UserCredential?> deleteUser(String email, String password) async {
//     User? user = _auth.currentUser;
//     AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
//     final authResult = await user!.reauthenticateWithCredential(credential).then((value) {
//       value.user!.delete();
//       // .then((value) {  });
//       // print('#################  DELETE #######################');
//     });
//     return authResult;
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:el_attar_windows/model/user_model.dart';
// // // import 'package:el_attar_windows/model/user_model.dart';
// // import 'package:el_attar_windows/services/firestore_user.dart';
// // import 'package:el_attar_windows/services/preferences_Store.dart';
// // import 'package:firedart/auth/firebase_auth.dart';
// // import 'package:firedart/auth/user_gateway.dart';
// // // import 'package:el_attar_windows/firebase_auth.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// //
// // class Auth {
// //   final _auth = FirebaseAuth.instance;
// //   // var firebaseAuth = FirebaseAuth.initialize('apiKey',  PreferencesStore());
// //   // final _auth = FirebaseAuth.initialize('apiKey', tokenStore);
// //
// //   Future<User> signUp(
// //       String name,
// //       String phone,
// //       String nationalId,
// //       String email,
// //       String password,
// //       ) async {
// //     final authResult = await _auth.signUp(email, password)
// //         // .createUserWithEmailAndPassword(email: email, password: password )
// //         .then((user) async {
// //       await FireStoreUser().addUserToFireStore(
// //           UserModel(
// //             userId: user.id,
// //                 // .user!.uid,
// //             name: name,
// //             phone: phone,
// //             nationalId: nationalId,
// //             email: email,
// //             password: password,
// //           )
// //       );
// //     }
// //     );
// //     return authResult;
// //   }
// //
// //
// //   Future<User> signIn(String email, String password) async {
// //     final authResult = await _auth.signIn(email, password
// //     // ).signInWithEmailAndPassword(
// //     //     email: email, password: password
// //     );
// //     return authResult;
// //   }
// //
// //
// //   // Future<User?> deleteUser(String email, String password) async {
// //   //   User? user = _auth.currentUser;
// //   //   AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
// //   //   final authResult = await user!.reauthenticateWithCredential(credential).then((value) {
// //   //     value.user!.delete();
// //   //     // .then((value) {  });
// //   //     // print('#################  DELETE #######################');
// //   //   });
// //   //   return authResult;
// //   // }
// //
// // }
