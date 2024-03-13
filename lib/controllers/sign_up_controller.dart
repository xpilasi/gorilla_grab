import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

//Create collections once the user is created
Future<void> createCollection() async {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final userEMail = FirebaseAuth.instance.currentUser!.email;
  final userDocument = db.collection('users').doc(userEMail);

  try {
    // Create all collections:
    
    CollectionReference collectionRef = userDocument.collection('profile');
    await collectionRef.add({
      'name': 'John',
      'lastName': 'Doe',
      'city': 'noMansLand',
      'country': 'noCountry',
      'email': FirebaseAuth.instance.currentUser!.email,
      'climbingSince': 2024,
      'nationality': 'lostPerson',
      
    });
    userDocument.collection('trainings');
    userDocument.collection('exercises');
    userDocument.collection('sessions');
    userDocument.collection('records');
    
    //Create profile initial data:

    
   

    print('All collections created successfully!');
  } catch (error) {
    print('Error creating collection: $error');
  }
}

}