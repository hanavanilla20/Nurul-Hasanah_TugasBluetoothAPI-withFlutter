import 'package:bluetooth_app/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bluetooth_app',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLUETOOTH API FLUTTER"),
        centerTitle: true,
      ),
      body: GetBuilder<BluetoothController>(
        init: BluetoothController(),
        builder: (BluetoothController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context,snapshot){
                    if(snapshot.hasData) {
                      return ListView.builder(
                          itemBuilder: (context, index){
                            final data = snapshot.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                  title: Text(data.device.name),
                                  subtitle: Text(data.device.id.id),
                                  trailing: Text(data.rssi.toString())
                              ),
                            );
                          }
                      );
                    } else {
                      return Center(child: Text("No Device Found"),);
                    }
                  }
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: ()=>controller.scanDevice(), child: Text("SCAN")),
              ],
            ),
          );
        },
      )
    );
  }
}
