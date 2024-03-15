// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "home_screen": {
    "title": "Home Screen",
    "url_label": "Set valid API base URL in order to continue",
    "start_button": "Start counting process"
  },
  "process_screen": {
    "title": "Process Screen",
    "calc": {
      "success": "All calculations has been finished, you can send your results to server",
      "error": "Error in calculations",
      "progress": "Calculation in progress"
    },
    "send_button": "Send results to server"
  },
  "results_screen": {
    "title": "Results list screen",
    "error": "Error: wrong state"
  },
  "preview_screen": {
    "title": "Preview screen"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
