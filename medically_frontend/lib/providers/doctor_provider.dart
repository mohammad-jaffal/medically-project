import 'package:flutter/cupertino.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorProvider with ChangeNotifier {
  var _doctor;
  void setDoctor(Doctor doctor) {
    _doctor = doctor;
  }

  Doctor get getDoctor {
    return _doctor;
  }

  void setOnline(bool status) {
    _doctor.online = status;
    notifyListeners();
  }

  int get getDoctorId {
    return _doctor.id;
  }

  void updateBalance(var balance) {
    // print('adding ${0.8 * balance}');
    _doctor.balance = _doctor.balance + (0.8 * balance).toInt();
    print('adding ${_doctor.balance}');
    notifyListeners();
  }

  Future<void> updateImage(var base64String) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/change-image');
    var response = await http.post(url, body: {
      'id': '${_doctor.id}',
      'image': '$base64String',
    });
    _doctor.base64Image = base64String;

    notifyListeners();
  }
}
