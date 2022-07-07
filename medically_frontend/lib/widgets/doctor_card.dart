import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/models/doctor.dart';
import 'dart:convert';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;

  const DoctorCard(
    this.doctor,
  );

  @override
  Widget build(BuildContext context) {
    var _bytesImage = Base64Decoder().convert(doctor.base64Image);

    return InkWell(
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            // color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    _bytesImage,
                    width: 70,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                // padding: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(doctor.name),
                    Text('domain ${doctor.domainId}'),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 50,
                width: 50,
              )
            ],
          ),
          // child: Text(doctor.name),
        ),
      ),
    );
  }
}
