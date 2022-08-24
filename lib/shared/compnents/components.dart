import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/medules/web_view/webView.dart';

Widget bulidNewsItem(artical, context) => InkWell(
      onTap: (() {
        navigateTo(context, WebViewScreen(artical['url']));
      }),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${artical['urlToImage']}')),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${artical['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${artical['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget MyDividor() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey[600],
      ),
    );

Widget ArticalBulder(list) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => bulidNewsItem(list[index], context),
        separatorBuilder: (context, index) => MyDividor(),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()));

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
