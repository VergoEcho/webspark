import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:webspark/generated/locale_keys.g.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  static const String route = '/preview';

  @override
  Widget build(BuildContext context) {
    final (steps, path, fields) = ModalRoute.of(context)!.settings.arguments
        as (List<Map<String, String>>, String, List<String>);

    Color getColor(int x, int y) {
      if (fields[y][x] == 'X') return Colors.black;
      if (steps[0]['x'] == x.toString() && steps[0]['y'] == y.toString()) {
        return const Color(0xFF64FFDA);
      }

      if (steps[steps.length - 1]['x'] == x.toString() &&
          steps[steps.length - 1]['y'] == y.toString()) {
        return const Color(0xFF009688);
      }

      for (final step in steps) {
        if (step['x'] == x.toString() && step['y'] == y.toString()) {
          return const Color(0xFF4CAF50);
        }
      }

      return Colors.white;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.preview_screen_title.tr(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            for (int y = 0; y < fields.length; y++)
              Row(
                children: [
                  for (int x = 0; x < fields[0].length; x++)
                    Expanded(
                      child: Container(
                        height: 120,
                        color: getColor(x, y),
                        child: Center(child: Text('($x,$y)')),
                      ),
                    )
                ],
              ),
            Text(path),
          ],
        ),
      ),
    );
  }
}
