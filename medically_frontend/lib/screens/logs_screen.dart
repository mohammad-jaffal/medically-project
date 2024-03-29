import 'package:flutter/material.dart';
import 'package:medically_frontend/widgets/call_card.dart';
import 'package:provider/provider.dart';
import '../providers/calls_provider.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final callsProvider = Provider.of<CallsProvider>(context);
    var calls = callsProvider.getCalls();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
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
                    itemBuilder: (ctx, i) => CallCard(calls[i]),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4 / 1,
                      mainAxisSpacing: 15,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
