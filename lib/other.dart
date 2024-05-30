import 'package:flutter/material.dart';
import 'currency_conversion.dart';
import 'time_conversion.dart';


class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Other')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CurrencyConversionPage()),
                );
              },
              child: Text('Currency Conversion'),
            ),
             ElevatedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => TimeConversionPage()),
                 );
               },
               child: Text('Time Conversion'),
            ),
          ],
        ),
      ),
    );
  }
}
