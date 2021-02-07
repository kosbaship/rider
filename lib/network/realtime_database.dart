

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider/models/user.dart';
import 'package:rider/network/firebase_auth.dart';
import 'package:rider/shared/constants.dart';

class FirebaseRealTimeDatabaseService {
  static FirebaseDatabase databaseInstance;

  FirebaseRealTimeDatabaseService() {
    databaseInstance = FirebaseDatabase.instance;
  }
static Future<void> storeUsers({
  @required User user
}) async {
  return await databaseInstance.reference()
      .child(kUsersNode)
      .child(FirebaseAuthService.getCurrentUserId()).set({
        kUsersID: user.userID,
        kUsersName: user.userName,
        kUsersEmail: user.userEmail,
        kUsersPhone: user.userPhone,
        kUsersPassword: user.userPassword
      });
}
}


  // static Future<QuerySnapshot> getProducts() async {
  //   return await fireStoreInstance.collection(kProductsCollection).get();
  // }
  // static Future<void> deleteProduct({documentId}) async {
  //   return await fireStoreInstance
  //       .collection(kProductsCollection)
  //       .doc(documentId)
  //       .delete();
  // }
  // static Future<void> editProduct({productData, documentId}) async {
  //   return await fireStoreInstance
  //       .collection(kProductsCollection)
  //       .doc(documentId)
  //       .update(productData);
  // }

