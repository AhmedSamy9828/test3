import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_attar_windows/model/user_model.dart';

class FireStoreUser{
  final CollectionReference _userCollectionRef =
  FirebaseFirestore.instance.collection('Moderators');
  Future<void> addUserToFireStore(UserModel userModel) async {
    return await _userCollectionRef.doc(userModel.userId).set(userModel.toJson());
  }
}




//
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:el_attar_windows/model/user_model.dart';
// import 'package:firedart/firedart.dart';
// // import 'package:firedart/firestore/models.dart';
//
// class FireStoreUser{
//   final CollectionReference _userCollectionRef =
//   Firestore.instance.collection('Moderators');
//   Future<void> addUserToFireStore(UserModel userModel) async {
//     return await _userCollectionRef.document(userModel.userId).set(userModel.toJson());
//   }
// }
