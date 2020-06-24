import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/view_state.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';


class SearchViewModel extends BaseViewModel {

  Geolocator _geoLocator = Geolocator();
  StreamSubscription<Position> _userLocationStream;
  Position _userLocation;

  SearchViewModel() : super(Starting());

  @override
  void handleSideEffects(_state) async {
    super.handleSideEffects(_state);
    if (_state is Starting) {
      try {
        _userLocation = await _geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        LocationOptions locOptions = LocationOptions(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        );
        _userLocationStream = _geoLocator.getPositionStream(locOptions).listen((Position pos) {
          _userLocation = pos;
          setState(Rest());
        });
      } on PlatformException catch (_) {
        setState(NoLocation());
      }
    }
  }
}