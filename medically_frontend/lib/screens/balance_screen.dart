import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medically_frontend/widgets/bundle_card.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({Key? key}) : super(key: key);
  static const routeName = '/balance-screen';

  @override
  Widget build(BuildContext context) {
    List<Map> bundles = [
      {
        'amount': 5,
        'price': 5,
      },
      {
        'amount': 10,
        'price': 10,
      },
      {
        'amount': 15,
        'price': 15,
      },
      {
        'amount': 20,
        'price': 20,
      },
      {
        'amount': 50,
        'price': 50,
      },
      {
        'amount': 100,
        'price': 100,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Select bundle'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: bundles.length,
        itemBuilder: (ctx, i) => BundleCard(
          amount: bundles[i]['amount'],
          price: bundles[i]['price'],
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 5 / 1,
        ),
      ),
    );
  }
}
