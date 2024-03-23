import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gorilla_grab/controllers/sign_up_controller.dart';

class GoogleSignInController extends GetxController{

final SignUpController signUpController = Get.put(SignUpController());

Future<UserCredential> signInWithGoogle() async {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  //Create the user and collections
  signUpController.createCollection();

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

}