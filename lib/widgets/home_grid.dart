import 'package:flutter/material.dart';
import '../LPR/LPR_scanner.dart';
import '../QR/qr_scanner.dart';
import '../ValidatedCarsPage.dart';
import '../operation/operation_page.dart';
import '../GLOBALS.dart';



class HomeGrid extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        Card(
          color: Colors.blue,
          child: InkWell(
            highlightColor: Colors.orange,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ValidatedCarPage()));
            },
            child: Container(
              width: 300,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, size: 80, color: Colors.white70,),
                  Padding(padding: EdgeInsets.only(bottom: 10),),
                  Text("Validated Cars", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                ],
              ),
            ),
          ),
        ),//Validated Car
        Card(
          color: Colors.lightBlue,
          child: InkWell(
            highlightColor: Colors.deepOrangeAccent,
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => OperationPage()));
            },
            child: Container(
              width: 300,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.group, size: 80,  color: Colors.white70,),
                  Padding(padding: EdgeInsets.only(bottom: 10),),
                  Text("Operations", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,  color: Colors.white),)
                ],
              ),
            ),
          ),
        ),//Operation
        Card(
          color: Colors.lightBlue,
          child: InkWell(
            highlightColor: Colors.deepOrange,
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPreviewScanner()));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 80, color: Colors.white70,),
                Padding(padding: EdgeInsets.only(bottom: 10),),
                Text("Scan License Plate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
              ],
            ),
          ),
        ),//LPR
        Card(
          color: Colors.blue,
          child: InkWell(
            highlightColor: Colors.orange,
            splashColor: Colors.blue.withAlpha(30),
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanner()));
            },
            child: Container(
              width: 300,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.crop_free, size: 80, color: Colors.white70,),
                  Padding(padding: EdgeInsets.only(bottom: 10),),
                  Text("Scan Digital Proof", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                ],
              ),
            ),
          ),
        ),//QR
      ],
    );
  }
}
