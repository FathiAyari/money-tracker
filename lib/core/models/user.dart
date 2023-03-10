import 'package:moneymanager/core/models/transaction.dart';

class AppUser {
  String userName;
  String uid;
  String email;
  List<TransactionProcess>? transactions;

  AppUser({required this.uid, required this.userName, required this.email, this.transactions});
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json["uid"],
      userName: json["userName"],
      email: json["Email"],
    );
  }
// from object to json
  Map<String, dynamic> Tojson() {
    return {
      "uid": uid,
      "userName": userName,
      "Email": email,
    };
  }
}
