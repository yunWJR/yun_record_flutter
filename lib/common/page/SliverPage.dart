import 'package:yun_record/common/model/query_model.dart';

import '../../index.dart';

class BasePage<T extends QueryModel> extends StatelessWidget {
  final Widget body;

  final T model;

  BuildContext context;

  BasePage({@required this.body, @required this.model, this.context});

  factory BasePage.slide({
    @required Widget body,
    @required T model,
    BuildContext context,
  }) {
    return BasePage(
      body: body,
      model: model,
    );
  }

  @override
  Widget build(BuildContext context) {
    return bodyWidget(model);
  }

  Widget bodyWidget(T model) {
    print(model.isLoading);

    bool isLoading = model.isLoading;

    List<Widget> widgets = new List();

    widgets.add(this.body);

    widgets.add(Visibility(
      visible: isLoading,
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
