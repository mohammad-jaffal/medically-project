import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorsProvider with ChangeNotifier {
  var _doctors;

  var _domains;

  var _favorites;

  Future<void> fetchDoctors() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/get-doctors');
    var response = await http.get(url);
    // print(json.decode(response.body)['doctors']);
    _doctors = json
        .decode(response.body)['doctors']
        .map((e) => Doctor.fromJson(e))
        .toList();

    var domainsUrl = Uri.parse('http://10.0.2.2:8000/api/get-domains');
    var domainsResponse = await http.get(domainsUrl);

    _domains = json.decode(domainsResponse.body)['domains'];
    notifyListeners();
  }

  List getDoctors(var searchText, var domainId) {
    var _doctorsList = [];
    if (_doctors != null) {
      if (domainId == 0) {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i].name.contains(searchText)) {
            _doctorsList.add(_doctors[i]);
          }
        }
      } else {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i].name.contains(searchText) &&
              _doctors[i].domainId == domainId) {
            _doctorsList.add(_doctors[i]);
          }
        }
      }
    } else {
      return [];
    }

    return [..._doctorsList];
  }

  List get getDomains {
    return [..._domains];
  }

  Future<void> fetchFavorites(var userID) async {
    //  print('fetching');
    var url = Uri.parse('http://10.0.2.2:8000/api/user/get-favorites');
    var response = await http.post(url, body: {
      'user_id': '$userID',
    });
    // print(json.decode(response.body));
    _favorites = json.decode(response.body)['favorites'];
    // print(_favorites);
  }

  List getFavorites(var searchText) {
    var favs = [];
    var favoriteDoctors = [];

    for (var fav in _favorites) {
      favs.add(fav['doctor_id']);
    }
    // print(favs);

    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].name.contains(searchText) &&
          favs.contains(_doctors[i].id)) {
        favoriteDoctors.add(_doctors[i]);
      }
    }
    return [...favoriteDoctors];
  }

  Doctor getDoctorByID(var docID) {
    var _doc;
    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].id == docID) {
        _doc = _doctors[i];
      }
    }
    return _doc;
  }
}
