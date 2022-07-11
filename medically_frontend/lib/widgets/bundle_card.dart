import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BundleCard extends StatelessWidget {
  const BundleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const InkWell(
      child: GridTile(
        child: Icon(Icons.monetization_on_rounded),
        footer: GridTileBar(title: Text('100')),
      ),
    );
  }
}
