import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double NN_FIELD_FONT_SIZE = 18;

class AddPoemField extends StatefulWidget {
  final String label;
  final String initial;
  final String errorMessage;
  final Function isValid;
  final Function onSave;
  final TextInputType textInputType;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final List<TextInputFormatter> inputFormatters;
  final String hintText;

  const AddPoemField(
      {this.label,
        this.initial,
        this.errorMessage,
        this.isValid,
        this.onSave,
        this.hintText,
        this.textInputType = TextInputType.text,
        this.currentFocus,
        this.nextFocus,
        this.inputFormatters,
        Key key})
      : super(key: key);

  @override
  _AddPoemFieldState createState() => _AddPoemFieldState();
}

class _AddPoemFieldState extends State<AddPoemField> {
  bool _isFocused = false;

  @override
  void initState() {
    widget.currentFocus.addListener(() {
      setState(() {
        _isFocused = !_isFocused;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      expands: false,
      initialValue: widget.initial,
      focusNode: widget.currentFocus,
      textInputAction: widget.nextFocus == null ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: widget.label,
        labelStyle:
        TextStyle(fontSize: NN_FIELD_FONT_SIZE, color: _isFocused ? Theme.of(context).primaryColorDark : null),
        hintText: widget.hintText,
      ),
      validator: (value) {
        if (widget.isValid(value)) {
          return null;
        }
        return widget.errorMessage;
      },
      onSaved: (value) => widget.onSave(value),
      onFieldSubmitted: (term) {
        widget.currentFocus.unfocus();
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
      },
      keyboardType: widget.textInputType,
      style: TextStyle(fontSize: NN_FIELD_FONT_SIZE),
      inputFormatters: widget.inputFormatters,
    );
  }
}
