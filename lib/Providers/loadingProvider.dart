import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  notLoading() {
    _isLoading = false;
    notifyListeners();
  }

  loading() {
    _isLoading = true;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
