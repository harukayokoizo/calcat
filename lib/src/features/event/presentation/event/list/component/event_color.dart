import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../application/color_setting_provider.dart';

Widget eventColor(int color){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer(
      builder: (context, ref, _){
        final colors = ref.read(colorList);
        return Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(colors[color]),
          ),
        );
      },
    ),
  );
}