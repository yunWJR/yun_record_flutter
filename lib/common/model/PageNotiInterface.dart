import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'PageBaseNotiModel.dart';

abstract class PageNotiInterface<T extends PageBaseNotiModel> {
  // todo 不起作用
  T pT([BuildContext context, bool listen = false]) {
    return Provider.of<T>(context, listen: listen);
  }
}
