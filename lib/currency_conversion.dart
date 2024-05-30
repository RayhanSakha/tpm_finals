import 'package:flutter/material.dart';

class CurrencyConversionPage extends StatefulWidget {
  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';
  double _amount = 0;
  double _result = 0;

  final Map<String, double> _conversionRates = {
    'USD_IDR': 14300.0,
    'IDR_USD': 0.00007,
    'USD_JPY': 110.0,
    'JPY_USD': 0.0091,
    'IDR_JPY': 0.0077,
    'JPY_IDR': 130.0,
  };

  void _convert() {
    String conversionKey = '${_fromCurrency}_$_toCurrency';
    if (_conversionRates.containsKey(conversionKey)) {
      setState(() {
        _result = _amount * _conversionRates[conversionKey]!;
      });
    } else {
      setState(() {
        _result = _amount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency Conversion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value) ?? 0;
                });
              },
            ),
            DropdownButton<String>(
              value: _fromCurrency,
              items: ['USD', 'IDR', 'JPY'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _fromCurrency = value!;
                });
              },
            ),
            DropdownButton<String>(
              value: _toCurrency,
              items: ['USD', 'IDR', 'JPY'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _toCurrency = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
