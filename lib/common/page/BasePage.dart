import 'package:yun_record/common/model/query_model.dart';

import '../../index.dart';

class BasePage<T extends PageBaseNotiModel> extends StatelessWidget {
  final Widget body;

  T model;

//  final BuildContext context;

  BasePage({@required this.body, @required this.model});

  // 4.0.0 后，model 无效
  factory BasePage.slide({
    @required Widget body,
    @required T model,
  }) {
    return BasePage(
      body: body,
      model: model,
//      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    // 主动监听 model 改变
//    model = Provider.of<T>(context, listen: true);

    List<Widget> widgets = new List();

    widgets.add(this.body);

    widgets.add(Visibility(
      visible: model.isLoading,
      child: loadingWidget(model),
    ));

    return new Stack(children: widgets);
  }

  Widget loadingWidget(T model) {
    return new Container(
//          width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(100, 100, 100, 0.5),
      child: Center(
        child: const CircularProgressIndicator(
//              backgroundColor: Color.fromRGBO(100, 100, 100, 1),
            ),
      ),
    );
  }
}
