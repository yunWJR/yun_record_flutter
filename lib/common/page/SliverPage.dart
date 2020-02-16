import 'package:yun_record/common/model/query_model.dart';

import '../../index.dart';

class SliverPage<T extends QueryModel> extends StatelessWidget {
  final Widget body;

  const SliverPage({@required this.body});

  factory SliverPage.slide({
    @required Widget header,
  }) {
    return SliverPage(
      body: header,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, model, child) => bodyWidget(model),
    );
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
