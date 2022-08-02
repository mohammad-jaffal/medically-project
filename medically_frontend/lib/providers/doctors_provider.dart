import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorsProvider with ChangeNotifier {
  var _doctors;

  var _domains;

  List _favoriteIDs = [];

  // fetches all doctors from database
  Future<void> fetchDoctors() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/get-doctors');
    var response = await http.get(url);
    _doctors = json
        .decode(response.body)['doctors']
        .map((e) => Doctor.fromJson(e))
        .toList();

    var domainsUrl = Uri.parse('http://10.0.2.2:8000/api/get-domains');
    var domainsResponse = await http.get(domainsUrl);

    _domains = json.decode(domainsResponse.body)['domains'];
    notifyListeners();
  }

  // return doctors based on domain and search text
  List getDoctors(var searchText, var domainId) {
    var _doctorsList = [];
    if (_doctors != null) {
      if (domainId == 0) {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i]
              .name
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            _doctorsList.add(_doctors[i]);
          }
        }
      } else {
        for (var i = 0; i < _doctors.length; i++) {
          if (_doctors[i]
                  .name
                  .toLowerCase()
                  .contains(searchText.toLowerCase()) &&
              _doctors[i].domainId == domainId) {
            _doctorsList.add(_doctors[i]);
          }
        }
      }
    } else {
      return [];
    }
    if (_doctorsList.length == 0) {
      print('empty');
    }
    return [..._doctorsList];
  }

  // returns list of all domains
  List get getDomains {
    return [..._domains];
  }

  // returns domain name by id
  String getDomainName(var domain_id) {
    var name;
    for (var i = 0; i < _domains.length; i++) {
      if (_domains[i]['id'] == domain_id) {
        name = _domains[i]['domain_name'];
      }
    }
    return name;
  }

  // fetches all favorite doctors by user id
  Future<void> fetchFavorites(var userID) async {
    var url = Uri.parse('http://10.0.2.2:8000/api/user/get-favorites');
    var response = await http.post(url, body: {
      'user_id': '$userID',
    });
    var favorites = json.decode(response.body)['favorites'];
    for (var fav in favorites) {
      _favoriteIDs.add(fav['doctor_id']);
    }
  }

  // returns list with favorate doctors, and allowing user to filter search text
  List getFavorites(var searchText) {
    var favoriteDoctors = [];

    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].name.contains(searchText) &&
          _favoriteIDs.contains(_doctors[i].id)) {
        favoriteDoctors.add(_doctors[i]);
      }
    }
    return [...favoriteDoctors];
  }

  // returns doctor object based on doctor id
  Doctor getDoctorByID(var docID) {
    var _doc;
    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].id == docID) {
        _doc = _doctors[i];
      }
    }
    return _doc;
  }

  // returnds id list of favorate doctors
  List get getFavIds {
    return [..._favoriteIDs];
  }

  // adds a favorite doctor locally and to database
  Future<void> addFavorite(var userID, var doctorID) async {
    for (var doctor in _doctors) {
      if (doctor.id == doctorID) {
        _favoriteIDs.add(doctorID);
        var url = Uri.parse('http://10.0.2.2:8000/api/user/add-favorite');
        var response = await http.post(url, body: {
          'user_id': '$userID',
          'doctor_id': '$doctorID',
        });
        notifyListeners();
      }
    }
  }

  // removes a favorite doctor locally and from database
  Future<void> removeFavorite(var userID, var doctorID) async {
    for (var doctor in _doctors) {
      if (doctor.id == doctorID) {
        _favoriteIDs.remove(doctorID);
        var url = Uri.parse('http://10.0.2.2:8000/api/user/remove-favorite');
        var response = await http.post(url, body: {
          'user_id': '$userID',
          'doctor_id': '$doctorID',
        });
        notifyListeners();
      }
    }
  }

  // updates a doctors rating locally
  void updateDoctorRating(var doctorID, var rating) {
    for (var i = 0; i < _doctors.length; i++) {
      if (_doctors[i].id == doctorID) {
        _doctors[i].rating = double.parse(rating);
      }
    }
    notifyListeners();
  }
}
