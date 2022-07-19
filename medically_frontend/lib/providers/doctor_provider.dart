import 'package:flutter/cupertino.dart';
import 'package:medically_frontend/models/doctor.dart';

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
}
