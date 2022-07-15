import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/providers/agora_provider.dart';
import 'package:provider/provider.dart';

import '../providers/doctors_provider.dart';
import 'package:agora_uikit/agora_uikit.dart';

class DoctorCallScreen extends StatefulWidget {
  const DoctorCallScreen({Key? key}) : super(key: key);
  static const routeName = '/user-call-screen';

  @override
  State<DoctorCallScreen> createState() => _DoctorCallScreenState();
}

class _DoctorCallScreenState extends State<DoctorCallScreen> {
  late AgoraClient _client;
  var token;
  var name;
  @override
  void initState() {
    final agoraProvider = Provider.of<AgoraProvider>(context, listen: false);
    token = agoraProvider.getToken;
    name = agoraProvider.getTName;
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async {
    const appId = "cfdf49c6205745eba30ed0ebadc79407";
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "cfdf49c6205745eba30ed0ebadc79407",
        channelName: name,
        tempToken: token,
      ),
    );
    await _client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("video"),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client,
                layoutType: Layout.grid,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(
                client: _client,
                enabledButtons: const [
                  // BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleMic,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
