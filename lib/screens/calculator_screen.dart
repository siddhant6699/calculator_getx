// ignore_for_file: unrelated_type_equality_checks

import 'package:calculator_app_getx/controllers/calculator_controller.dart';
import 'package:calculator_app_getx/controllers/history_controller.dart';
import 'package:calculator_app_getx/utils/konstants.dart';
import 'package:calculator_app_getx/widgets/keyboard_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController textFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool historyViewVisiblity = false;

  final CalculatorController calculatorController =
      Get.put(CalculatorController());
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                cursorColor: defaultTextColor,
                style: const TextStyle(fontSize: 40),
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: calculatorController.editingController,
                textAlign: TextAlign.right,
                maxLines: 1,
                autofocus: true,
              ),
              Expanded(
                flex: 3,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // changing the visiblity to show or hide history
                            historyController.changeVisiblity();

                            if (historyController.visiblityBool != true) {
                              historyController.history.clear();
                            } else {
                              // initializing history controller to get history
                              historyController.getHistory();
                            }
                          },
                          child: const Icon(
                            Icons.access_time,
                            size: 25,
                          ),
                        ),
                        const Icon(
                          Icons.align_vertical_top,
                          size: 25,
                        ),
                        const Icon(
                          Icons.calculate_outlined,
                          size: 25,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Obx(() => GestureDetector(
                                onTap: () {
                                  calculatorController.deletedLastEntry();
                                },
                                child: Icon(
                                  Icons.backspace_outlined,
                                  size: 25,
                                  color: calculatorController
                                          .mathResult.value.isBlank!
                                      ? defaultGreenColor.withOpacity(0.3)
                                      : defaultGreenColor,
                                ),
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: const Color(0xff262626),
                  )),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    return Flexible(
                      flex: 3,
                      child: historyController.visiblityBool == true
                          ? historyContainerView(context)
                          : GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: buttonNums.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ButtonWidget(
                                    onTap: () {
                                      buttonClick(index);
                                    },
                                    buttonText: buttonNums[index],
                                    buttonTextColor: index == 0
                                        ? defaultRedColor
                                        : (index == 1 || index == 2)
                                            ? defaultGreenColor
                                            : null,
                                  ),
                                );
                              },
                            ),
                    );
                  }),
                  Flexible(
                    flex: 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: buttonOperators.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ButtonWidget(
                            onTap: () {
                              if (historyController.visiblityBool != true) {
                                if (index == 4) {
                                  calculatorController.calculateResult(true);
                                } else {
                                  calculatorController
                                      .selectOperation(buttonOperators[index]);
                                }
                              }
                            },
                            buttonText: buttonOperators[index],
                            buttonColor:
                                index == 4 ? defaultEqualToGreenColor : null,
                            buttonTextColor:
                                index == 4 ? null : defaultGreenColor,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyContainerView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            children: [
              Obx(() {
                return Container(
                  alignment: Alignment.bottomCenter,
                  height: MediaQuery.of(context).size.height * 0.49,
                  child: historyController.history.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'No History Found',
                            style: TextStyle(
                                color: defaultGreenColor, fontSize: 25),
                          ),
                        )
                      : Scrollbar(
                          controller: scrollController,
                          thumbVisibility: true,
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: historyController.history.length,
                            itemBuilder: (context, index) {
                              var expression = historyController.history[index]
                                      ['expression']
                                  .toString()
                                  .split('=');
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      expression[0],
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      '=${expression[1]}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: defaultGreenColor),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                );
              }),
              GestureDetector(
                onTap: () {
                  historyController.clearHistory();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  decoration: BoxDecoration(
                    color: defaultGreyColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Clear History',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void buttonClick(int index) {
    // handling button operations according to index
    if (index == 0) {
      calculatorController.clearAll();
    } else if (index == 2) {
      calculatorController.selectOperation(buttonNums[index]);
    } else if (index == 12) {
      calculatorController.changeNegativePositive();
    } else if (index == 13) {
      calculatorController.inputNumber(buttonNums[index]);
    } else if (index == 14) {
      calculatorController.addDecimalPoint();
    } else if (index >= 3 && index <= 11) {
      calculatorController.inputNumber(buttonNums[index]);
    }
  }
}
