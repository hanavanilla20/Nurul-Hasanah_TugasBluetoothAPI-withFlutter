import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController{
  FlutterBlue bluetooth = FlutterBlue.instance;

  Future scanDevice() async{
    if(await Permission.bluetoothScan.request().isGranted){
      if(await Permission.bluetoothConnect.request().isGranted){
        bluetooth.startScan(timeout: Duration(seconds: 10));
        bluetooth.stopScan();
      }
    }
  }
  Stream<List<ScanResult>> get scanResults => bluetooth.scanResults;
}

