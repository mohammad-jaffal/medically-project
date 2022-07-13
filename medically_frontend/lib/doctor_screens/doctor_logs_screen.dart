import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/widgets/doctor_call_card.dart';
import 'package:provider/provider.dart';

import '../providers/calls_provider.dart';
import '../providers/dark_theme_provider.dart';
import '../widgets/call_card.dart';

class DoctorLogsScreen extends StatefulWidget {
  const DoctorLogsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorLogsScreen> createState() => _DoctorLogsScreenState();
}

class _DoctorLogsScreenState extends State<DoctorLogsScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final callsProvider = Provider.of<CallsProvider>(context);
    var calls = callsProvider.getCalls();
    return Scaffold(
      appBar: AppBar(
        title: Text('Logs'),
      ),
      body: Column(
        children: [
          Flexible(
            child: calls.isEmpty
                ? const Center(child: Text('No Calls Found!'))
                : GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(10),
                    itemCount: calls.length,
                    itemBuilder: (ctx, i) => DoctorCallCard(calls[i]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 1,
                      // crossAxisSpacing: 10,
                      mainAxisSpacing: 15,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
