import 'package:calculator_app_getx/database_services/history_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  TextEditingController editingController = TextEditingController();

  var firstNumber = '0'.obs;
  var mathResult = ''.obs;
  var operator = ''.obs;

  updateTextController() {
    editingController.text = mathResult.value;
  }

  // clear all the fields
  clearAll() async {
    firstNumber.value = '';
    mathResult.value = '';
    operator.value = '';
    updateTextController();
  }

  // add +/- sign in text
  changeNegativePositive() {
    if (mathResult.startsWith('-')) {
      mathResult.value = mathResult.value.replaceFirst('-', '');
    } else {
      mathResult.value = '-${mathResult.value}';
    }
    updateTextController();
  }

  // add digts in text
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

  // insert . in text
  addDecimalPoint() {
    if (mathResult.contains('.')) return;
    if (mathResult.startsWith('0')) {
      return mathResult.value = '0.';
    } else {
      mathResult.value = '${mathResult.value}.';
    }
    updateTextController();
  }

  // perform operation according to operator
  selectOperation(String operation) {
    // logic to calculate percentage
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
      if (operator.value == operation) {
        calculateResult(false);
        operator.value = operation;
      } else {
        calculateResult(false);
        operator.value = operation;
      }
    } else {
      operator.value = operation;
      firstNumber.value = mathResult.value;
      mathResult.value = '';
      updateTextController();
    }
  }

  // delete last digit from text
  deletedLastEntry() {
    if (mathResult.value.replaceAll('-', '').length > 1) {
      mathResult.value = mathResult.substring(0, mathResult.value.length - 1);
    } else {
      mathResult.value = '';
    }
    updateTextController();
  }

  // logic to calculate
  calculateResult(bool isFromButton) {
    HistoryHelper historyHelper = HistoryHelper();
    var expression;
    // var index;
    if (firstNumber.value != '' && mathResult != '') {
      expression = '$firstNumber $operator $mathResult = ';
    }

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
    // var tempHistory = history[index];
    // history[index] = '$tempHistory $mathResult';

    if (firstNumber.value != '' && mathResult != '') {
      expression = expression + mathResult.toString();
      historyHelper.insertCalculation(expression);
    }

    operator.value = '';
    if (isFromButton == true) {
      firstNumber.value = '';
    }
  }
}
