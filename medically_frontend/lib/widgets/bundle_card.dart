import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class BundleCard extends StatelessWidget {
  const BundleCard({
    Key? key,
    required this.amount,
    required this.price,
  }) : super(key: key);
  final int amount;
  final int price;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$amount Coin',
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                print('buying $amount');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  themeState.getDarkTheme
                      ? const Color(0xFF00001a)
                      : const Color.fromARGB(255, 54, 135, 255),
                ),
              ),
              child: Text('$price \$'),
            ),
          ],
        ),
      ),
    );
  }
}
// themeState.getDarkTheme
//                                   ? Colors.white
//                                   : Colors.grey[600],