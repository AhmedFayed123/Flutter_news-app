import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view.dart';

Widget buildArticleItem(article, context) =>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

      padding: const EdgeInsets.all(20.0),

      child: Row(

        children:

        [

          Container(

            width: 120.0,

            height: 120.0,

            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10.0,),

              image: DecorationImage(

                image: NetworkImage('${article['urlToImage']}'),

                fit: BoxFit.cover,

              ),

            ),

          ),

          SizedBox(

            width: 20.0,

          ),

          Expanded(

            child: Container(

              height: 120.0,

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.start,

                children:

                [

                  Expanded(

                    child: Text(

                      '${article['title']}',

                      style: Theme.of(context).textTheme.bodyMedium,

                      maxLines: 3,

                      overflow: TextOverflow.ellipsis,

                    ),

                  ),

                  Text(

                    '${article['publishedAt']}',

                    style: TextStyle(

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

            ),

          ),

          SizedBox(

            width: 15.0,

          ),

        ],

      ),

  ),
);
Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget articleBuilder(list,context,{isSearch=false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length ,),
  fallback: (context) =>isSearch? Container(): Center(child: CircularProgressIndicator()),
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
Widget defaultTextInput({
  bool isObscureText = false,
  required TextEditingController fromController,
  Function(String)? onFieldSubmit,
  Function(String)? onChange,
  String? Function(String?)? validationCallBack,
  required TextInputType keyboardType,
  String label = "Text Field",
  required String hint,
  IconData prefixIcon = Icons.edit,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  GestureTapCallback? onTap,
}) =>
    TextFormField(
      obscureText: isObscureText,
      controller: fromController,
      onFieldSubmitted: onFieldSubmit,
      onChanged: onChange,
      keyboardType: keyboardType,
      validator: validationCallBack,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: label,
          labelText: hint,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
              : null,
          border: const OutlineInputBorder()),
    );