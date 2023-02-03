import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  TextEditingController editingController = TextEditingController();

  var firstNumber = '0'.obs;
  var mathResult = ''.obs;
  var tempText = ''.obs;
  var operator = ''.obs;

  updateTextController() {
    editingController.text = mathResult.value;
  }

  clearAll() {
    firstNumber.value = '';
    mathResult.value = '';
    operator.value = '';
    updateTextController();
  }

  changeNegativePositive() {
    if (mathResult.startsWith('-')) {
      mathResult.value = mathResult.value.replaceFirst('-', '');
    } else {
      mathResult.value = '-${mathResult.value}';
    }
    updateTextController();
  }

  inputNumber(String number) {
    if (mathResult.value == firstNumber.value) {
      firstNumber.value = mathResult.value;
      mathResult.value = '';
      mathResult.value = mathResult.value + number;
      updateTextController();
    } else {
      mathResult.value = mathResult.value + number;
      updateTextController();
    }
  }

  addDecimalPoint() {
    if (mathResult.contains('.')) return;
    if (mathResult.startsWith('0')) {
      return mathResult.value = '0.';
    } else {
      mathResult.value = '${mathResult.value}.';
    }
    updateTextController();
  }

  selectOperation(String operation) {
    if (operation == '%') {
      if (firstNumber.value == '') {
        firstNumber.value = '0';
      }
      if (firstNumber.value != '' && firstNumber.value != '0') {
        double num1 = double.parse(firstNumber.value);
        double num2 = double.parse(mathResult.value);
        var temp = (num2 / 100) * num1;
        switch (operator.value) {
          case '+':
            mathResult.value = '${num1 + temp}';
            updateTextController();
            break;

          case '-':
            mathResult.value = '${num1 - temp}';
            updateTextController();
            break;

          case 'x':
            mathResult.value = '${num1 * temp}';
            updateTextController();
            break;

          case '÷':
            mathResult.value = '${num1 / temp}';
            updateTextController();
            break;

          default:
            return;
        }
      } else {
        double num1 = double.parse(mathResult.value);
        mathResult.value = (num1 / 100).toString();
        updateTextController();
      }
      if (mathResult.value.endsWith('.0')) {
        mathResult.value =
            mathResult.value.substring(0, mathResult.value.length - 2);
        updateTextController();
      }
      return;
    }

    if (firstNumber.value != '' && firstNumber.value != '0') {
      calculateResult(false);
      operator.value = operation;
    } else {
      operator.value = operation;
      firstNumber.value = mathResult.value;
      mathResult.value = '';
      updateTextController();
    }
  }

  deletedLastEntry() {
    if (mathResult.value.replaceAll('-', '').length > 1) {
      mathResult.value = mathResult.substring(0, mathResult.value.length - 1);
    } else {
      mathResult.value = '';
    }
    updateTextController();
  }

  calculateResult(bool isFromButton) {
    if (firstNumber.value == '') {
      firstNumber.value = '0';
    }
    if (mathResult.value == '') {
      mathResult.value = '0';
    }

    double num1 = double.parse(firstNumber.value);
    double num2 = double.parse(mathResult.value);
    switch (operator.value) {
      case '+':
        mathResult.value = '${num1 + num2}';
        firstNumber.value = mathResult.value;
        updateTextController();
        break;

      case '-':
        mathResult.value = '${num1 - num2}';
        firstNumber.value = mathResult.value;
        updateTextController();
        break;

      case 'x':
        mathResult.value = '${num1 * num2}';
        firstNumber.value = mathResult.value;
        updateTextController();
        break;

      case '÷':
        mathResult.value = '${num1 / num2}';
        firstNumber.value = mathResult.value;
        updateTextController();
        break;

      default:
        return;
    }

    if (mathResult.value.endsWith('.0')) {
      mathResult.value =
          mathResult.value.substring(0, mathResult.value.length - 2);
      firstNumber.value = mathResult.value;
      updateTextController();
    }
    if (isFromButton == true) {
      firstNumber.value = '';
    }
  }
}
