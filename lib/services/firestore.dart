import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


class FirestoreService {

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future updateUserData(String uid, String email, String name, String  id_num, String officer_rank) async {
    return await Firestore.instance.collection("User").document(uid).setData({
      'name': name,
      'id_num': id_num,
      'officer_rank': officer_rank,
      'email':email,
      'joined_operation': []
    });
  }


  Future<String> getUserName() async{
    final FirebaseUser user = await auth.currentUser();
    var name = await Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["name"]);
    return name;
  }

  //create new operation
  Future<void> createOperation(String date, String location) async {

    var op_id = await Firestore.instance.collection("System").document("operation")
        .get().then((value) => value.data["operation_counter"]);

    //print(op_id);

    String op_doc_id = "operation_" + op_id.toString();

    await Firestore.instance
        .collection("Operation")
        .document(op_doc_id)
        .setData({
          'op_id': op_id.toString(),
          'date': date,
          'location': location,
          //'results': validation_results
        });
    final FirebaseUser user = await auth.currentUser();
    await Firestore.instance.collection("User").document(user.uid)
        .updateData({"joined_operation": FieldValue.arrayUnion([op_id.toString()])});

    await Firestore.instance.collection("System").document("operation")
        .updateData({"operation_counter": FieldValue.increment(1)});
  }

  Future<void> joinOperation(String op_id) async {

    var total_op = await Firestore.instance.collection("System").document("operation")
        .get().then((value) => value.data["operation_counter"]);
    if(int.parse(op_id) >= total_op) {
      print("ERROR: Operation does not exist!");
      return;
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String today_date = formatter.format(now);
    var op_date = await Firestore.instance.collection("Operation").document("operation_" + op_id)
        .get().then((value) => value.data["date"]);
    if(op_date != today_date){
      print("ERROR: Operation has not started or has ended.");
      return;
    }

    final FirebaseUser user = await auth.currentUser();
    await Firestore.instance.collection("User").document(user.uid)
        .updateData({"joined_operation": FieldValue.arrayUnion([op_id])});
    print("SUCCESS: Operation joined.");
  }

  Future<List<dynamic>> getJoinedOp() async{
    final FirebaseUser user = await auth.currentUser();
    return Firestore.instance.collection("User").document(user.uid)
        .get().then((value) => value.data["joined_operation"]);
  }

  //CALLED AFTER VALIDATION
  Future<void> addUserValidationResult(String ve_reg_num, String rt_expiry_dt, bool rt_is_valid) async{
    if(ve_reg_num == null){
      print("--------------SCAN IS NULL!!!-------------");
      return;
    }
    final FirebaseUser user = await auth.currentUser();
    await Firestore.instance.collection("User").document(user.uid)
        .collection("Validation Result")
        .document(ve_reg_num)
        .setData({
      "ve_reg_num": ve_reg_num,
      "rt_expiry_dt": rt_expiry_dt,
      "rt_is_valid": rt_is_valid,
    });
  }

  Future<void> addValidationResult(String ve_reg_num, String rt_expiry_dt, bool rt_is_valid) async{
    if(ve_reg_num == null){
      print("--------------SCAN IS NULL!!!-------------");
      return;
    }

    final FirebaseUser user = await auth.currentUser();
    var joined_op = await Firestore.instance.collection("User")
        .document(user.uid).get().then((value) => value.data["joined_operation"]);

    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    String today_date = formatter.format(now);

    for(String op in joined_op){
      String op_date = await Firestore.instance.collection("Operation")
          .document("operation_" + op).get().then((value) => value.data["date"]);
      if(op_date == today_date){
        await Firestore.instance
            .collection("Operation")
            .document("operation_" + op)
            .collection("Validation Result")
            .document(ve_reg_num)
            .setData({
          "ve_reg_num": ve_reg_num,
          "rt_expiry_dt": rt_expiry_dt,
          "rt_is_valid": rt_is_valid,
        });
      }
    }





  }

}