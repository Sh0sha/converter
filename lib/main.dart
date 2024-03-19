import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Конвертер для бедных'),
      ),
      body: ConverterList(),
    );
  }
}

class ConverterList extends StatelessWidget {
  final List<String> categories = [
    'Масса',
    'Валюта',
    'Температура',
    'Длина',
    'Площадь'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(categories[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ConversionScreen(category: categories[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ConversionScreen extends StatefulWidget {
  final String category;

  ConversionScreen({required this.category});

  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  List<String> weightUnits = ['Gram', 'Kilogram', 'Centner'];
  List<String> currencyUnits = ['RUB', 'CNY', 'INR'];
  List<String> temperatureUnits = ['Celsius', 'Kelvin', 'Fahrenheit'];
  List<String> lengthUnits = ['Meter', 'Elbow', 'Arshin'];
  List<String> areaUnits = ['Square Meter', 'Square Sto', 'Hectare'];
  String fromUnit = '';
  String toUnit = '';
  double inputValue = 0.0;
  double result = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.category == 'Масса') {
      fromUnit = weightUnits[0];
      toUnit = weightUnits[1];
    } else if (widget.category == 'Валюта') {
      fromUnit = currencyUnits[0];
      toUnit = currencyUnits[1];
    } else if (widget.category == 'Температура') {
      fromUnit = temperatureUnits[0];
      toUnit = temperatureUnits[1];
    } else if (widget.category == 'Длина') {
      fromUnit = lengthUnits[0];
      toUnit = lengthUnits[1];
    } else if (widget.category == 'Площадь') {
      fromUnit = areaUnits[0];
      toUnit = areaUnits[1];
    }
  }
  // ConversionScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: fromUnit,
              onChanged: (value) {
                setState(() {
                  fromUnit = value!;
                });
              },
              items: getCategoryUnits(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  inputValue = double.parse(value);
                });
              },
            ),
            DropdownButton<String>(
              value: toUnit,
              onChanged: (value) {
                setState(() {
                  toUnit = value!;
                });
              },
              items: getCategoryUnits(),
            ),
            ElevatedButton(
              onPressed: () {
                convert();
              },
              child: Text('Конвертировать'),

            ),
            Text('Результат: $result ${getUnitLabel()}'),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getCategoryUnits() {
    switch (widget.category) {
      case 'Масса':
        return weightUnits.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      case 'Валюта':
        return currencyUnits.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      case 'Температура':
        return temperatureUnits.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      case 'Длина':
        return lengthUnits.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      case 'Площадь':
        return areaUnits.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      default:
        return [];
    }
  }

  String getUnitLabel() {
    switch (widget.category) {
      case 'Масса':
        return toUnit;
      case 'Валюта':
        return '';
      case 'Температура':
        return toUnit;
      case 'Длина':
        return toUnit;
      case 'Площадь':
        return toUnit;
      default:
        return '';
    }
  }

  void convert() {
    setState(() {
      if (widget.category == 'Масса') {
        switch (fromUnit) {
          case 'Gram':
            result = convertGramsTo(toUnit, inputValue);
            break;
          case 'Kilogram':
            result = convertKilogramsTo(toUnit, inputValue);
            break;
          case 'Centner':
            result = convertCentnersTo(toUnit, inputValue);
            break;
        }
      } else if (widget.category == 'Валюта') {
        result = convertCurrency(fromUnit, toUnit, inputValue);
      } else if (widget.category == 'Температура') {
        switch (fromUnit) {
          case 'Celsius':
            result = convertCelsiusTo(toUnit, inputValue);
            break;
          case 'Kelvin':
            result = convertKelvinTo(toUnit, inputValue);
            break;
          case 'Fahrenheit':
            result = convertFahrenheitTo(toUnit, inputValue);
            break;
        }
      } else if (widget.category == 'Длина') {
        switch (fromUnit) {
          case 'Meter':
            result = convertMetersTo(toUnit, inputValue);
            break;
          case 'Elbow':
            result = convertElbowsTo(toUnit, inputValue);
            break;
          case 'Arshin':
            result = convertArshinsTo(toUnit, inputValue);
            break;
        }
      } else if (widget.category == 'Площадь') {
        switch (fromUnit) {
          case 'Square Meter':
            result = convertSquareMetersTo(toUnit, inputValue);
            break;
          case 'Square Sto':
            result = convertSquareSotkasTo(toUnit, inputValue);
            break;
          case 'Hectare':
            result = convertHectaresTo(toUnit, inputValue);
            break;
        }
      }
    });
  }

  double convertGramsTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Gram':
        return value;
      case 'Kilogram':
        return value / 1000;
      case 'Centner':
        return value / 100000;
      default:
        return 0.0;
    }
  }

  double convertKilogramsTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Gram':
        return value * 1000;
      case 'Kilogram':
        return value;
      case 'Centner':
        return value / 100;
      default:
        return 0.0;
    }
  }

  double convertCentnersTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Gram':
        return value * 100000;
      case 'Kilogram':
        return value * 100;
      case 'Centner':
        return value;
      default:
        return 0.0;
    }
  }

  double convertCurrency(
      String fromCurrency, String toCurrency, double amount) {
    Map<String, double> exchangeRates = {
      'RUB': 1.0,
      'CNY': 0.079,
      'INR': 0.91,
    };

    double fromRate = exchangeRates[fromCurrency] ?? 1.0;
    double toRate = exchangeRates[toCurrency] ?? 1.0;

    return (amount / fromRate) * toRate;
  }

  double convertCelsiusTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Celsius':
        return value;
      case 'Kelvin':
        return value + 273.15;
      case 'Fahrenheit':
        return (value * 9 / 5) + 32;
      default:
        return 0.0;
    }
  }

  double convertKelvinTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Celsius':
        return value - 273.15;
      case 'Kelvin':
        return value;
      case 'Fahrenheit':
        return (value - 273.15) * 9 / 5 + 32;
      default:
        return 0.0;
    }
  }

  double convertFahrenheitTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Celsius':
        return (value - 32) * 5 / 9;
      case 'Kelvin':
        return (value - 32) * 5 / 9 + 273.15;
      case 'Fahrenheit':
        return value;
      default:
        return 0.0;
    }
  }

  double convertMetersTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Meter':
        return value;
      case 'locot':
        return value / 0.7112;
      case 'Arshin':
        return value / 0.7112 * 2.1336;
      default:
        return 0.0;
    }
  }

  double convertElbowsTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Meter':
        return value * 0.7112;
      case 'locot':
        return value;
      case 'Arshin':
        return value * 2.1336;
      default:
        return 0.0;
    }
  }

  double convertArshinsTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Meter':
        return value * 0.7112 * 3;
      case 'locot':
        return value * 3;
      case 'Arshin':
        return value;
      default:
        return 0.0;
    }
  }

  double convertSquareMetersTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Square Meter':
        return value;
      case 'Square Sotka':
        return value / 100;
      case 'Hectare':
        return value / 10000;
      default:
        return 0.0;
    }
  }

  double convertSquareSotkasTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Square Meter':
        return value * 100;
      case 'Square Sotka':
        return value;
      case 'Hectare':
        return value / 100;
      default:
        return 0.0;
    }
  }

  double convertHectaresTo(String toUnit, double value) {
    switch (toUnit) {
      case 'Square Meter':
        return value * 10000;
      case 'Square Sotka':
        return value * 100;
      case 'Hectare':
        return value;
      default:
        return 0.0;
    }
  }
}
