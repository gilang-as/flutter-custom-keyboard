part of c_keyboard;

double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

void setDesignWHD(double w, double h, {double density: 3.0}) {
  _designW = w;
  _designH = h;
  _designD = density;
}

class _ScreenUtil {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;
  double _textScaleFactor = 0.0;
  MediaQueryData _mediaQueryData;

  static final _ScreenUtil _singleton = _ScreenUtil();

  static _ScreenUtil getInstance() {
    _singleton._init();
    return _singleton;
  }


  _init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _screenDensity = mediaQuery.devicePixelRatio;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = mediaQuery.padding.bottom;
      _textScaleFactor = mediaQuery.textScaleFactor;
      _appBarHeight = kToolbarHeight;
    }
  }

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get appBarHeight => _appBarHeight;

  double get screenDensity => _screenDensity;

  double get statusBarHeight => _statusBarHeight;

  double get bottomBarHeight => _bottomBarHeight;

  MediaQueryData get mediaQueryData => _mediaQueryData;

  static double getScreenW(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  static double getScreenH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  static double getScreenDensity(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio;
  }

  static double getStatusBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }

  static double getBottomBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.bottom;
  }

  static MediaQueryData getMediaQueryData(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery;
  }

  static double getScaleW(BuildContext context, double size) {
    if (context == null || getScreenW(context) == 0.0) return size;
    return size * getScreenW(context) / _designW;
  }

  static double getScaleH(BuildContext context, double size) {
    if (context == null || getScreenH(context) == 0.0) return size;
    return size * getScreenH(context) / _designH;
  }

  static double getScaleSp(BuildContext context, double fontSize,
      {bool sySystem: true}) {
    if (context == null || getScreenW(context) == 0.0) return fontSize;
    return (sySystem ? MediaQuery
        .of(context)
        .textScaleFactor : 1.0) * fontSize * getScreenW(context) / _designW;
  }

  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }

  double getWidth(double size) {
    return _screenWidth == 0.0 ? size : (size * _screenWidth / _designW);
  }

  double getHeight(double size) {
    return _screenHeight == 0.0 ? size : (size * _screenHeight / _designH);
  }

  double getWidthPx(double sizePx) {
    return _screenWidth == 0.0 ? (sizePx / _designD) :
    (sizePx * _screenWidth / (_designW * _designD));
  }

  double getHeightPx(double sizePx) {
    return _screenHeight == 0.0 ? (sizePx / _designD) :
    (sizePx * _screenHeight / (_designH * _designD));
  }

  double getSp(double fontSize, {bool sySystem: true}) {
    if (_screenWidth == 0.0) return fontSize;
    return (sySystem ? _textScaleFactor : 1.0) *
        fontSize *
        _screenWidth /
        _designW;
  }
}
