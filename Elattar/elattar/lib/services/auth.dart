import 'package:elattar/model/user_model.dart';
import 'package:elattar/services/firestore_user.dart';
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
