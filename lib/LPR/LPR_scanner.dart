// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realtime_ocr/services/firestore.dart';
import 'package:realtime_ocr/services/database.dart';
import 'package:realtime_ocr/GLOBALS.dart';

import 'detector_painters.dart';
import 'scanner_utils.dart';

class CameraPreviewScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraPreviewScannerState();
}

class _CameraPreviewScannerState extends State<CameraPreviewScanner> {
  String scan_result = "";
  CameraController _camera;
  Detector _currentDetector = Detector.text;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;

  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description = await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      ResolutionPreset.veryHigh,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _recognizer.processImage,
        imageRotation: description.sensorOrientation,
      ).then(
            (dynamic results) {
          if (_currentDetector == null) return;
          setState(() {
            scan_result = LicensePlateRegex(results.text);
          });
          Future.delayed(const Duration(milliseconds: 500), () async{

            if(scan_result != null){
              Map params = {"ve_reg_num": scan_result};
              Map vehicle_data = await fetch(params);
              if(vehicle_data != null && vehicle_data.isNotEmpty){
                FirestoreService().addUserValidationResult(vehicle_data["ve_reg_num"], vehicle_data["rt_expiry_dt"], vehicle_data["rt_is_valid"]);
                FirestoreService().addValidationResult(vehicle_data["ve_reg_num"], vehicle_data["rt_expiry_dt"], vehicle_data["rt_is_valid"]);
              }
            }
            print(scan_result);
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CameraPreview(_camera),
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: scan_result == null
                ? Text("")
                : Text(scan_result, style: TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold))
            ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LPR'),
        backgroundColor: Color(0xff2b2b8e),
      ),
      body: _buildImage(),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _recognizer.close();
    });
    _currentDetector = null;
    super.dispose();
  }
}