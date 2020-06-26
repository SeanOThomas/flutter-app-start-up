import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/logger.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:drop_poet/user/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';


class SearchViewModel extends BaseViewModel {
  final String _TAG = "SearchViewModel";

  final UserModel userModel;

  Geolocator _geoLocator = Geolocator();
  StreamSubscription<Position> _userLocationStream;

  SearchViewModel(this.userModel) : super(Starting());

  @override
  void dispose() {
    Logger.log(_TAG, "dispose");
    _userLocationStream.cancel();
    super.dispose();
  }

  @override
  void handleSideEffects(_state) async {
    super.handleSideEffects(_state);
    if (_state is Starting) {
      if (userModel.currentLocation != null) {
        // await request poems
        setState(Rest());
      }
      try {
        LocationOptions locOptions = LocationOptions(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        );
        _userLocationStream = _geoLocator.getPositionStream(locOptions).listen((Position pos) {
          Logger.log(_TAG, "new user position : " + pos.latitude.toString());
          if (userModel.currentLocation == null) {
            // await request poems
          }
          userModel.currentLocation = pos;
          setState(Rest());
        });
      } on PlatformException catch (_) {
        setState(NoLocation());
      }
    }
  }
}