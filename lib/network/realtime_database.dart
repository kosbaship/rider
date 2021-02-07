

import 'package:firebase_database/firebase_database.dart';

class FirebaseRealTimeDatabaseService {
  static FirebaseDatabase databaseInstance;

  FirebaseRealTimeDatabaseService() {
    databaseInstance = FirebaseDatabase.instance;
  }

}

  // static Future<DocumentReference> storeOrders({totalPrice, shippingAddress, phone}) async {
  //   return await fireStoreInstance
  //       .collection(kOrderCollection).add({
  //     kUserID: FirebaseAuthService.getUserId(),
  //     kAddress: shippingAddress,
  //     kPhone: phone,
  //     kTotalPrice: totalPrice,
  //   });
  // }
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

