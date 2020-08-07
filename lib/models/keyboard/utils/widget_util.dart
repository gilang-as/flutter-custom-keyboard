part of c_keyboard;
class _WidgetUtil {
  bool _hasMeasured = false;
  double _width;
  double _height;

  void asyncPrepare(
      BuildContext context, bool isOnce, ValueChanged<Rect> onCallBack) {
    if (_hasMeasured) return;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      RenderBox box = context.findRenderObject();
      if (box != null && box.semanticBounds != null) {
        if (isOnce) _hasMeasured = true;
        double width = box.semanticBounds.width;
        double height = box.semanticBounds.height;
        if (_width != width || _height != height) {
          _width = width;
          _height = height;
          if (onCallBack != null) onCallBack(box.semanticBounds);
        }
      }
    });
  }

  void asyncPrepares(bool isOnce, ValueChanged<Rect> onCallBack) {
    if (_hasMeasured) return;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      if (isOnce) _hasMeasured = true;
      if (onCallBack != null) onCallBack(null);
    });
  }

  static Rect getWidgetBounds(BuildContext context) {
    RenderBox box = context.findRenderObject();
    return (box != null && box.semanticBounds != null)
        ? box.semanticBounds
        : Rect.zero;
  }

  static Offset getWidgetLocalToGlobal(BuildContext context) {
    RenderBox box = context.findRenderObject();
    return box == null ? Offset.zero : box.localToGlobal(Offset.zero);
  }
}