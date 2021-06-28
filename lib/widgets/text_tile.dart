import 'package:flutter/material.dart';
import 'package:realtime_ocr/vehicle/vehicle_page.dart';

class TextTileWidget extends StatelessWidget {
  final String text;
  final String expiry_date;
  final bool is_valid;

  TextTileWidget(this.text, this.expiry_date, this.is_valid);

  @override
  Widget build(BuildContext context) {
    if(is_valid == null) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.38,
      );
    }
    return Card(
      color: is_valid ? Colors.green[300] : Colors.red[500],
      child: new ListTile(
        leading: const Icon(Icons.time_to_leave,color: Colors.black,),
        title: Text(text, style: TextStyle(fontSize: 18, color: Colors.black)),
        subtitle: is_valid ? Text("VALID: $expiry_date", style: TextStyle(fontSize: 14, color: Colors.black),)
            : Text("EXPIRED: $expiry_date", style: TextStyle(fontSize: 14, color: Colors.black)),
        trailing: const Icon(Icons.arrow_forward, color: Colors.black,),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclePage(ve_reg_num: text)));
        }
      ),
    );
  }
}