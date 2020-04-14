import 'dart:convert';

import 'package:flutter/services.dart';

checkBlackListKeywords(String str) async {
  final keywordsS = base64
      .decode(await rootBundle.loadString("assets/res/blacklist-keywords"));
}
