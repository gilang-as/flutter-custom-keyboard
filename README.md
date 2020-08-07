# Flutter Custom Keyboard
The flutter keyboard alternative that defaults to having problems on Samsung devices

---

<p>
<img height="500" src="https://raw.githubusercontent.com/gilang-as/flutter-custom-keyboard/master/screenshot1.png">
<img height="500" src="https://raw.githubusercontent.com/gilang-as/flutter-custom-keyboard/master/screenshot2.png">
</p>

---
# Flutter Custom Keyboard

## Introduction
This keyboard was created because when using text field masking there was a problem on Samsung devices, therefore I created a virtual keyboard so that it runs well on Samsung phones

## Reference

### VirtualKeyboard 
Flutter widget to show virtual keyboards.
```dart
// Add NumberKeyboard.register(); in main project
void main() {
  NumberKeyboard.register();
  runApp(MyApp());
}
```
```dart
// Add KeyboardRootWidget() in root screen/widget to get screen resolution, and show keyboard
KeyboardRootWidget(
        child: YourWidget()
)
```
