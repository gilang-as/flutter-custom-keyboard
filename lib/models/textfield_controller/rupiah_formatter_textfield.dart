import 'package:flutter/material.dart';

class RupiahFormatController extends TextEditingController {
  RupiahFormatController(
      {double initialValue = 0.0,
        this.decimalSeparator = ',',
        this.thousandSeparator = '.',
        this.rightSymbol = '',
        this.leftSymbol = '',
        this.precision = 0}) {
    _validateConfig();
    this.addListener(() {
      this.updateValue(this.numberValue);
      this.afterChange(this.text, this.numberValue);
    });
    this.updateValue(initialValue);
  }
  final String decimalSeparator;
  final String thousandSeparator;
  final String rightSymbol;
  final String leftSymbol;
  int precision;
  Function afterChange = (String maskedValue, double rawValue) {};
  double _lastValue = 0.0;

  void updatePrecision(int valuePrecision) {
    precision = valuePrecision;
  }

  void updateValue(double value) {
    double valueToUse = value;
    if (value.toStringAsFixed(0).length > 15) {
      valueToUse = _lastValue;
    } else {
      _lastValue = value;
    }
    String masked = this._applyMask(valueToUse);
    if (rightSymbol.length > 0) {
      masked += rightSymbol;
    }
    if (leftSymbol.length > 0) {
      masked = leftSymbol + masked;
    }
    if (masked != this.text) {
      this.text = masked;
      var cursorPosition = super.text.length - this.rightSymbol.length;
      this.selection = new TextSelection.fromPosition(new TextPosition(offset: cursorPosition));
    }
  }

  double get numberValue {
    List<String> parts = _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');
    if (parts.join() == ".") {
      return 0;
    }
    return double.parse(parts.join());
  }

  int get numberIntValue {
    List<String> parts = _getOnlyNumbers(this.text).split('').toList(growable: true);

    parts.insert(parts.length - precision, '.');
    if (parts.join() == ".") {
      return 0;
    }
    return double.parse(parts.join()).round();
  }

  _validateConfig() {
    bool rightSymbolHasNumbers = _getOnlyNumbers(this.rightSymbol).length > 0;

    if (rightSymbolHasNumbers) {
      throw new ArgumentError("sing ning tengen ojo gunakke ongko");
    }
  }

  String _getOnlyNumbers(String text) {
    String cleanedText = text;

    var onlyNumbersRegex = new RegExp(r'[^\d]');

    cleanedText = cleanedText.replaceAll(onlyNumbersRegex, '');

    return cleanedText;
  }

  String _applyMask(double value) {
    List<String> textRepresentation = value.toStringAsFixed(precision).replaceAll('.', '').split('').reversed.toList(growable: true);

    textRepresentation.insert(precision, decimalSeparator);

    for (var i = precision + 4; true; i = i + 4) {
      if (textRepresentation.length > i) {
        textRepresentation.insert(i, thousandSeparator);
      } else {
        break;
      }
    }

    if (value == 0 && precision <= 0) {
      return "";
    }
    if (decimalSeparator == ".") {
      return precision > 0 ? textRepresentation.reversed.join('') : textRepresentation.reversed.join('').split(".")[0];
    } else {
      return precision > 0 ? textRepresentation.reversed.join('') : textRepresentation.reversed.join('').split(",")[0];
    }
  }
}
