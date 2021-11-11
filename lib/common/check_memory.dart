import 'package:flutter/painting.dart';

class CheckMemory {
  static void checkMemory() {
    ImageCache _imageCache = PaintingBinding.instance.imageCache;
    if (_imageCache.liveImageCount >= 70) {
      _imageCache.clear();
      _imageCache.clearLiveImages();
    }
  }
}
