import 'package:flutter/material.dart';

import 'models/keyboard/c_keyboard.dart';
import 'models/textfield_controller/rupiah_formatter_textfield.dart';

void main() {
  NumberKeyboard.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Keyboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CustomKeyboardDemo(),
    );
  }
}

class CustomKeyboardDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomKeyboardDemoState();
  }
}

class CustomKeyboardDemoState extends State<CustomKeyboardDemo> {
  RupiahFormatController format1 = RupiahFormatController();
  RupiahFormatController format2 = RupiahFormatController();
  @override
  Widget build(BuildContext context) {
    return KeyboardRootWidget(
        child: Builder(builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Custom Keyboard"),
          ),
          body: Container(
              padding: EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: [
                    TextField(
                      controller: format1,
                      decoration:
                          InputDecoration(labelText: "Alternative Keyboard"),
                      keyboardType: NumberKeyboard.inputType,
                    ),
                    TextField(
                      controller: format2,
                      decoration:
                          InputDecoration(labelText: "Default Keyboard"),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
        );
      }),
    );
  }
}
