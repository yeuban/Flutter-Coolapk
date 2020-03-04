import 'dart:io';

import 'package:coolapk_flutter/util/image_url_size_parse.dart';
import 'package:coolapk_flutter/widget/data_list/data_list.dart';
import 'package:coolapk_flutter/widget/item_adapter/auto_item_adapter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:waterfall_flow/waterfall_flow.dart';

part './grid.template.dart';
part './normal.template.dart';
part './tab.template.dart';
part './coolpic.template.dart';
part './loadmore.mixin.dart';