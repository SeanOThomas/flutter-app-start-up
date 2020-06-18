import 'package:flutter/foundation.dart';

class BaseViewModel<T> with ChangeNotifier {

  T _state;
  T get state => _state;

  BaseViewModel(T viewState) {
    setState(viewState);
  }

  void setState(T viewState) {
    print("state change: $viewState");

    _state = viewState;
    notifyListeners();
    handleSideEffects(state);
  }

  @protected
  void handleSideEffects(T _state) {
    print("handle side effects for: $_state");
  }

  @protected
  void handleError(Object e) {
    print(e);
  }
}