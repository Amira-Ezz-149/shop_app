import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sssssssshop_app/models/home_model.dart';

void PushToNextScreen(context, wight) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => wight),
);

void showToast({msg}) {
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




Widget defaultButton({
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
  required TextEditingController? controller,
  required TextInputType? type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: const OutlineInputBorder(),
      ),
    );