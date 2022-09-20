import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sssssssshop_app/models/home_model.dart';

void PushToNextScreen(context, wight) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => wight),
);

void showToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}



void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
);




Widget bottom({
  required double width,
  required double height,
  required Color color,
  required VoidCallback? onpressed,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: MaterialButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );




Widget defulteditTextx({
  required TextEditingController Controlar,
  required TextInputType keyboardType,
  Function? onfiled,
  // Function? onchanged ,
  FormFieldValidator<String>? validator,
  required String Lable,
  required IconData prefix,
  IconData? sufix,
  suffixPressed,
  bool? obscureText = false,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText!,
      controller: Controlar,
      keyboardType: keyboardType,
      // onChanged:(s)
      // {
      //   onchanged!(s);
      // } ,
      validator: validator,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.deepOrange),
        labelText: Lable,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
          color: Colors.deepOrange,
        ),
        suffixIcon: sufix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(sufix))
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.deepOrange)),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );


Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData? prefix,
  String? initialValue,
  TextInputType? keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData? suffix,
  suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyText1,
      initialValue: initialValue,
      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        hintText: label,
        border: UnderlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );