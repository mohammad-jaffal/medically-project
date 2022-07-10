import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorLogsScreen extends StatefulWidget {
  const DoctorLogsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorLogsScreen> createState() => _DoctorLogsScreenState();
}

class _DoctorLogsScreenState extends State<DoctorLogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('doc logs'),
    );
  }
}
