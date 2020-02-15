import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../funs.dart';

/// General model used to help retrieve, parse & storage
/// information from a public REST API
enum Status { loading, error, loaded }

abstract class QueryModel with ChangeNotifier {
  // Lists of both models info & its photos
  final List items, photos;

  // Model's status regarding data loading capabilities
  Status _status;

  BuildContext context;

  QueryModel([BuildContext context])
      : items = [],
        photos = [] {
//    this.context =context;

    startLoading();
    loadData(context);
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

  String getPhoto(int index) => photos.isNotEmpty ? photos[index] : null;

  int get getItemCount => items.length;

  int get getPhotosCount => photos.length;

  // Status getters
  bool get isLoading => _status == Status.loading;

  bool get loadingFailed => _status == Status.error;

  // Methods which update the [_status] variable
  void startLoading() {
    _status = Status.loading;

    if (context != null) {
      showLoading(context);
    }
  }

  void finishLoading() {
    _status = Status.loaded;
    notifyListeners();

    Navigator.of(context).pop();
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
