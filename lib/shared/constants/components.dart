import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sssssssshop_app/shared/cubit/shop_app_cubit.dart';
import 'package:sssssssshop_app/shared/styles/colors.dart';

void pushToNextScreen(context, wight) => Navigator.push(
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

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, Widget widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
);


Widget buildListProduct( model, context, {bool isOldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120.0,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image!),
              width: 120.0,
              height: 120.0,
            ),

            if(model.discount! != 0 && isOldPrice) Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              color: red,
              child: const Text('DISCOUNT',  style: TextStyle(color: white, fontSize: 10.0),),
            )
          ],
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
             const Spacer(),
              Row(
                children: [
                  Text('${model.price!}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12.0, color: defaultColor),
                  ),
                  const SizedBox(width: 5.0,),
                  if(model.discount! != 0 && isOldPrice) Text('${model.oldPrice!}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 10.0, color: grey, decoration: TextDecoration.lineThrough ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor: grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        }, icon: const Icon(
                      Icons.favorite_border,
                      size: 20.0,
                      color: white,
                    )),
                  )
                ],
              ),

            ],
          ),
        ),

      ],
    ),
  ),
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
        borderRadius: BorderRadius.circular(5.0),
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




Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType keyboardType,
  Function? onfiled,
  FormFieldValidator<String>? validator,
  required String label,
  required IconData prefix,
  IconData? suffix,
  suffixPressed,
  bool? obscureText = false,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText!,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: defaultColor),
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: defaultColor)),
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
          prefix, color: defaultColor,
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