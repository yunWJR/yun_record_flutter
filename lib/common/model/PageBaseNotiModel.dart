import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yun_record/common/alert/AlertHelper.dart';

/// General model used to help retrieve, parse & storage
/// information from a public REST API
enum Status { loading, error, loaded }

abstract class PageBaseNotiModel with ChangeNotifier {
  final List items;

  Status _status;

  BuildContext context;

  bool initLoadData = true;

  PageBaseNotiModel(BuildContext context, {this.initLoadData}) : items = [] {
    if (initLoadData == null) {
      initLoadData = true;
    }

    this.context = context;

    if (initLoadData) {
      startLoading();
      loadData(context);
    }
  }

  // Fetches data & returns it
  Future fetchData(String url, {Map<String, dynamic> parameters}) async {
    final response = await Dio().get(url, queryParameters: parameters);
    if (items.isNotEmpty) items.clear();

    return response.data;
  }

  // Overridable method, used to load the model's data
  Future loadData([BuildContext context]);

  // Reloads model's data
  Future refreshData() => loadData();

  // General getters for both lists
  dynamic getItem(int index) => items.isNotEmpty ? items[index] : null;

  int get getItemCount => items.length;

  // Status getters
  bool get isLoading => _status == Status.loading;

  bool get loadingFailed => _status == Status.error;

  // Methods which update the [_status] variable
  void startLoading() {
    if (_status != Status.loading) {
      _status = Status.loading;

      notifyListeners();
    }
  }

  void showErr(String error) {
    // hide loading

    AlertHelper.showErr(context, error);
  }

  void finishLoading() {
    if (_status != Status.loaded) {
      _status = Status.loaded;

      notifyListeners();
    }

//    Navigator.of(context).pop();
  }

  void receivedError() {
    _status = Status.error;
    notifyListeners();
  }

  // Checks internet connection & sets [_status] variable
  Future<bool> canLoadData() async {
//    var connectivityResult = await (Connectivity().checkConnectivity());
//    connectivityResult == ConnectivityResult.none ? receivedError() : startLoading();

    await Future.delayed(Duration(milliseconds: 10));

    startLoading();
    return isLoading;
  }
}
