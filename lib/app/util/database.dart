import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

void saveUser(
    {required String name,
    required String email,
    required String phone,
    String? photo}) async {
  DocumentReference userDB =
      FirebaseFirestore.instance.collection('Users').doc(email);

  await userDB.get().then((DocumentSnapshot doc) async {
    if (doc.exists) {
      return await userDB.update({
        'name': name,
        'email': email,
        'phone': phone,
        'photo': photo,
      });
    } else {
      return await userDB.set({
        'name': name,
        'email': email,
        'phone': phone,
        'photo': photo,
      });
    }
  });
}

Future<bool> savePet(
    {required String name,
    required String date,
    required String genre,
    required String description,
    required List<Uint8List> photos}) async {
  try {
    CollectionReference petDB = FirebaseFirestore.instance.collection('Pets');
    List photosRef = [];
    for (var photo in photos) {
      Reference ref = FirebaseStorage.instance
          .ref("Pets/${DateTime.now().microsecondsSinceEpoch}");

      await ref.putData(photo);
      var photoUrl = await ref.getDownloadURL();
      photosRef.add(photoUrl);
    }

    await petDB.add({
      "name": name,
      "email": FirebaseAuth.instance.currentUser!.email,
      "date": date,
      "genre": genre,
      "description": description,
      "photos": photosRef.join(","),
    });

    return true;
  } catch (e) {
    log(e.toString());
    return false;
  }
}

Future<DocumentSnapshot?> getUser([String? email]) async {
  DocumentReference userDB = FirebaseFirestore.instance
      .collection('Users')
      .doc(email ?? FirebaseAuth.instance.currentUser!.email);

  DocumentSnapshot userDoc = await userDB.get();
  if (userDoc.exists) {
    return userDoc;
  }
}

Future<List<QueryDocumentSnapshot>> getAdoptionPets() async {
  CollectionReference petDB = FirebaseFirestore.instance.collection('Pets');
  var list = await petDB
      .where("email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  return list.docs.toList();
}

Future<List<QueryDocumentSnapshot>> getMyPets() async {
  CollectionReference petDB = FirebaseFirestore.instance.collection('Pets');
  var list = await petDB
      .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
  return list.docs.toList();
}
