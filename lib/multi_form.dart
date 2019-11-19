import 'dart:convert';

import 'package:crypto_app_ui/sensor2.dart';
import 'package:flutter/material.dart';
import 'package:crypto_app_ui/empty_state.dart';
import 'package:crypto_app_ui/form.dart';
import 'package:http/http.dart' as http;

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: .0,
        leading: Icon(
          Icons.supervised_user_circle,
        ),
        title: Text('Registrar sensores'),
        actions: <Widget>[
          FlatButton(
            child: Text('Save'),
            textColor: Colors.white,
            onPressed: onSave,
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF727272),
              Color(0xFF282423),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: users.length <= 0
            ? Center(
                child: EmptyState(
                  title: 'Oops',
                  message: 'No hay sensores añadidos',
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, i) => users[i],
                ),
              ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: onAddForm,
        focusColor: Colors.black,
        backgroundColor: Colors.black,
        foregroundColor: Colors.black,
      ),
    );
  }

  ///on form user deleted
  void onDelete(Sensor2 _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    setState(() {
      var _user = Sensor2();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  ///on save forms
  void onSave() async {
//   var selectedTimeRTL = await showTimePicker(
//   context: context,
//   initialTime: TimeOfDay.now(),
//   builder: (BuildContext context, Widget child) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: child,
//     );
//   },
// );
// var  selectedDate = await  showDatePicker(
//   context: context,
//   initialDate: DateTime.now(),
//   firstDate: DateTime(2018),
//   lastDate: DateTime(2030),
//   builder: (BuildContext context, Widget child) {
//     return Theme(
//       data: ThemeData.dark(),
//       child: child,
//     );
//   },
// );
// await print(selectedTimeRTL);
// print(selectedTimeRTL.hour);
// await print(selectedDate);
    for (var user in users) {
      await upSensor(user.user.nombre, user.user.pinT,user.user.pinM,user.user.pinV,user.user.pinP );
      
    }
  }

  Future upSensor(nombre, pinT, pinM, pinV, pinP) async {
    print("temperatura");
    var cliente1 = new http.Client();
    try {
      final response = await cliente1
          .post("http://empresaslaraza.com/smartHouse/setSensors.php", body: {
        "nombre": nombre,
        "pinT": pinT.toString(),
        "pinM": pinM.toString(),
        "pinV": pinV.toString(),
        "pinP": pinP.toString(),
        
      }).timeout(Duration(seconds: 7));
      print(response.body);
    } catch (d) {
      print("hubo un error obteniendo los sensores");
      print(d.toString());
    } finally {
      cliente1.close();
      setState(() {});
    }
  }

  
}
