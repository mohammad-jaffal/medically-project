import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoctorReviewsScreen extends StatefulWidget {
  const DoctorReviewsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorReviewsScreen> createState() => _DoctorReviewsScreenState();
}

class _DoctorReviewsScreenState extends State<DoctorReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('doc reviews'),
    );
  }
}
