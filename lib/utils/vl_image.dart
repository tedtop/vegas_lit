

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mime/mime.dart';

class VLImage {
  static Widget network(
    String url, {
    double height = 100,
    double width = 100,
    BoxFit fit = BoxFit.fill,
  }) {
    final mimeStr = lookupMimeType(url)!;
    final fileType = mimeStr.split('/');
    if (fileType.last == 'svg+xml') {
      return SvgPicture.network(
        url,
        fit: fit,
        height: height,
        width: width,
      );
    } else {
      return Image.network(
        url,
        fit: fit,
        height: height,
        width: width,
      );
    }
  }
}
