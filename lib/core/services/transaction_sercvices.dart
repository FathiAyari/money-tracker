import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneymanager/core/models/transaction.dart';

class TransactionServices {
  static Future<bool> addTransaction(TransactionProcess transaction) async {
    try {
      var postsCollection = FirebaseFirestore.instance.collection("transactions");
      await postsCollection.add(transaction.Tojson());
      return true;
    } catch (e) {
      return false;
    }
  }
}
