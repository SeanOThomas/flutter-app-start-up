import 'package:drop_poet/common/base_view_mode.dart';
import 'package:drop_poet/common/view_state.dart';

class AddPoemViewModel extends BaseViewModel {

  String title;
  String place;
  String body;

  AddPoemViewModel() : super(Rest());

}