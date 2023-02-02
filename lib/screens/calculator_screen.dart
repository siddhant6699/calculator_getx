import 'package:calculator_app_getx/utils/konstants.dart';
import 'package:calculator_app_getx/widgets/keyboard_button_widget.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController textFieldController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool historyViewVisiblity = false;

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
                onChanged: (value) {
                  setState(() {});
                },
                showCursor: true,
                readOnly: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                controller: textFieldController,
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
                            if (historyViewVisiblity == true) {
                              historyViewVisiblity = false;
                            } else {
                              historyViewVisiblity = true;
                            }
                            setState(() {});
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
                          child: GestureDetector(
                            onTap: () {
                              if (textFieldController.text.trim().isNotEmpty) {
                                textFieldController.text =
                                    textFieldController.text.substring(
                                        0, textFieldController.text.length - 1);
                              }
                              setState(() {});
                            },
                            child: Icon(
                              Icons.backspace_outlined,
                              size: 25,
                              color: textFieldController.text.trim().isEmpty
                                  ? defaultGreenColor.withOpacity(0.7)
                                  : defaultGreenColor,
                            ),
                          ),
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
                  Flexible(
                    flex: 3,
                    child: historyViewVisiblity == true
                        ? Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.49,
                                      child: Scrollbar(
                                        controller: scrollController,
                                        thumbVisibility: true,
                                        child: ListView.builder(
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          itemCount: 10,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: const [
                                                  Text(
                                                    '75+6',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  Text(
                                                    '=81',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            defaultGreenColor),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 15, 30, 15),
                                      decoration: BoxDecoration(
                                        color:
                                            defaultGreyColor.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Text(
                                        'Clear History',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
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
                                    if (index == 0) {
                                      textFieldController.text = '';
                                    } else if (index >= 3 && index <= 11) {
                                      textFieldController.text +=
                                          buttonNums[index];
                                    }
                                    setState(() {});
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
                  ),
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
}
