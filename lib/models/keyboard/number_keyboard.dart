part of c_keyboard;

class NumberKeyboard extends StatefulWidget {
  final KeyboardController controller;
  const NumberKeyboard({this.controller});
  static const CKTextInputType inputType =
      const CKTextInputType(name: 'CKNumberKeyboard');
  static double getHeight(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    return mediaQuery.size.width / 4 / 2 * 4;
  }

  static register() {
    CoolKeyboard.addKeyboard(
      NumberKeyboard.inputType,
      KeyboardConfig(
          builder: (context, controller, params) {
            return NumberKeyboard(controller: controller);
          },
          getHeight: NumberKeyboard.getHeight),
    );
  }

  @override
  _NumberKeyboardState createState() => _NumberKeyboardState();
}

class _NumberKeyboardState extends State<NumberKeyboard> {
  bool _buttonPressed = false;
  bool _loopActive = false;

  void _increaseCounterWhilePressed() async {
    if (_loopActive) return;
    _loopActive = true;
    while (_buttonPressed) {
      widget.controller.deleteOne();
      await Future.delayed(Duration(milliseconds: 100));
    }
    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Material(
      child: DefaultTextStyle(
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.black, fontSize: 23.0),
        child: Container(
          height: NumberKeyboard.getHeight(context),
          width: mediaQuery.size.width,
          decoration: BoxDecoration(
            color: Colors.white10,
          ),
          child: GridView.count(
              childAspectRatio: 2 / 1,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 0.5,
              padding: EdgeInsets.all(2),
              crossAxisCount: 4,
              children: <Widget>[
                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                deleteButton(),
                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                emptyButton(),
                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                emptyButton(),
                buildButton('.'),
                buildButton('0'),
                buildButton(','),
                doneButton(),
              ]),
        ),
      ),
    );
  }

  Widget buildButton(String title, {String value}) {
    if (value == null) {
      value = title;
    }
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(5.0),
          topRight: const Radius.circular(5.0),
          bottomLeft: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.all(2),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Text(title),
        ),
        onTap: () {
          widget.controller.addText(value);
        },
      ),
    );
  }

  Widget deleteButton() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(5.0),
          topRight: const Radius.circular(5.0),
          bottomLeft: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.all(2),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: Icon(Icons.label_outline),
        ),
        onTap: () {
          widget.controller.deleteOne();
        },
        onLongPressStart: (value) {
          _buttonPressed = true;
          _increaseCounterWhilePressed();
        },
        onLongPressEnd: (value) {
          _buttonPressed = false;
        },
      ),
    );
  }

  Widget emptyButton() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white70,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(5.0),
          topRight: const Radius.circular(5.0),
          bottomLeft: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.all(2),
      child: Container(),
    );
  }

  Widget doneButton() {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.blue,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(5.0),
          topRight: const Radius.circular(5.0),
          bottomLeft: const Radius.circular(5.0),
          bottomRight: const Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.all(2),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: IconTheme(
            data: new IconThemeData(color: Colors.white),
            child: Icon(Icons.expand_more),
          ),
        ),
        onTap: () {
          widget.controller.doneAction();
        },
      ),
    );
  }
}
