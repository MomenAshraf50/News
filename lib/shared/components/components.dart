import 'package:flutter/material.dart';
import 'package:news/modules/web_view/web_view_screen.dart';

Widget buildNewsItems(list) => ListView.separated(
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          navigateTo(context, WebViewScreen(list[index]['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  image: DecorationImage(
                    image: list[index]['urlToImage'] != null
                        ? NetworkImage('${list[index]['urlToImage']}')
                        : const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/237/237014.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 80.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${list[index]['title']}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Text(
                        '${list[index]['publishedAt']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.deepOrange,
        ),
      ),
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
    );

void navigateTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
