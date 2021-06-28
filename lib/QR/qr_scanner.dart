
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:realtime_ocr/services/firestore.dart';
import 'package:realtime_ocr/services/database.dart';
import 'package:realtime_ocr/widgets/text_tile.dart';

class QRScanner extends StatefulWidget {

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {

  String scan_result = "PRESS SCAN";
  String expiry_date;
  bool is_valid;

  _scan() async {
    String result = await scanner.scan();
    Map params = {"ve_proof_id": result};
    Map vehicle_data = await fetch(params);
    print(vehicle_data);
    if(vehicle_data != null){
      setState(() {
        scan_result = vehicle_data["ve_reg_num"];
        expiry_date = vehicle_data["rt_expiry_dt"];
        is_valid = vehicle_data["rt_is_valid"];
        FirestoreService().addValidationResult(vehicle_data["ve_reg_num"], vehicle_data["rt_expiry_dt"], vehicle_data["rt_is_valid"]);
        FirestoreService().addUserValidationResult(vehicle_data["ve_reg_num"], vehicle_data["rt_expiry_dt"], vehicle_data["rt_is_valid"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new  Scaffold(
      appBar: new AppBar(
        title: new Text('Validate Road Tax'),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: new ListView(
        children: [
          TextTileWidget(scan_result, expiry_date, is_valid),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.08,
              child: RaisedButton(
                  color: Colors.blue,
                  onPressed: _scan,
                  child: new Text('SCAN', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),),
              ),
            ),
          ),
        ],
      )
    );
  }
}


