/*
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/InternetTools.dart';

typedef TransactionCallBack = Function(bool status, String msg, int yourId  );

class TransactionTools {

  static const String  tag = "TransactionHandler";


  static Future<int>  incrementInt(String collectionId, String documentId, String fieldId, TransactionCallBack callBack ) async {

    //check interent
    bool internet = await InternetTools.isConnected();
    if (internet == false) {
      callBack(false, "No Internet Connection!", -1);
      return -1;
    }

    //ref
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(collectionId)
        .doc(documentId);


    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
       // throw Exception("Document does not exist!");
        return createFirstNumber(collectionId, documentId, fieldId, callBack);
      }
      Log.k(tag,  "incrementInt() - runTransaction() - snapshot: " + snapshot.toString() );

      // Update the follower count based on the current count
      // Note: this could be done without a transaction
      // by updating the population using FieldValue.increment()

      //get map
      Map<String, dynamic>? map = snapshot.data() as Map<String, dynamic>?;
      Log.k(tag,  "incrementInt() - runTransaction() - map: " + map.toString() );

      //increment
      int previous = map![ fieldId];
      int incremented = previous + 1;
      Log.k(tag,  "incrementInt() - runTransaction() - previous: " + previous.toString()  + " /incremented: " + incremented.toString() );

      // Perform an update on the document
      transaction.update(documentReference, {fieldId: incremented});

      // Return the new count
      callBack(true, "", incremented) ;
      return incremented;
    }).catchError((error) {
      String msg = "Failed to update: $error";
      Log.k(tag, msg);
      callBack(false, msg, -1 ) ;
      
    });
    
   
  }

  static Future  createFirstNumber
      (String collectionId, String documentId, String fieldId, TransactionCallBack callBack ) async {

    Log.k(tag,  "createFirstNumber()  " );

    //ref
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection(collectionId)
        .doc(documentId);


    //backend
    /**
     * why to create "fieldId" = 0  not equal 1 ?
     *
     *   - answer: if i create by 1, the listener at previous method "incrementInt()" will see
     *    there is backend found at document, so will invoke again to incremnt by 2
     */
    Map<String, dynamic> map = Map();
    map[ fieldId] = 0;

    //set
    await documentReference.set( map, SetOptions(merge: true))
    .then((value)  {
      String msg = "success first id";
      Log.k(tag, msg);

      /**
       * why not need to call "callback" on success ?
       *   - answer: there is listener already create in preivoud method "incrementInt()"
       */
      // callBack(true, msg , 0 );
    }).onError((error, stackTrace) {
      String msg = "Create first id failed, error: " + error.toString();
      Log.k(tag, msg);
     callBack(false, msg, -1 );
    });
  }

}


*/