import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/calendar_document.dart';
import 'calendar.dart';

class PublishedCalendarContent extends StatelessWidget{
  final CalendarDocument calendarDoc;

  const PublishedCalendarContent(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15.0, right: 20.0, bottom: 0.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PublicCalendarPage(calendarDoc, false),
            ),
          );
        },
        child: Container(
          height: 100,
          width: deviceWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            // border: const Border(
            //   top: BorderSide(width: 1.0, color: Color(0xFFCCCCCC)),
            //   bottom: BorderSide(width: 1.5, color: Color(0xFFCCCCCC)),
            //   right: BorderSide(width: 1.5, color: Color(0xFFCCCCCC)),
            // ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7), // 影の色
                spreadRadius: 1, // スプレッド半径
                blurRadius: 2, // ぼかし半径
                offset: const Offset(0, 1), // オフセット（x, y）
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: calendarIcon(calendarDoc.calendar!.image),
                  ),
                  if(calendarDoc.calendar!.publicPreference == 0)
                    SizedBox(
                      height: 100,
                      width: constraints.maxWidth - 100,
                      child: calendarSummary(calendarDoc.calendar!.title!, calendarDoc.calendar!.description!),
                    ),
                  if(calendarDoc.calendar!.publicPreference != 0)
                    SizedBox(
                      height: 100,
                      width: constraints.maxWidth - 100,
                      child: calendarSummaryWidthCount(calendarDoc.calendar!.title!, calendarDoc.calendar!.description!, calendarDoc.calendar!.followsCount!),
                    ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

}

Widget calendarIcon(String? image){
  Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
  if(image != null) {
    imagePath = Image.network(
      image,
      errorBuilder:(c,o,s) {
        return Container(color: Colors.grey);
      },
    );
  }
  return Container(
    height: 100,
    width: 100,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey,
    ),
    child: FittedBox(
        fit: BoxFit.cover,
        child: imagePath
    ),
  );
}

Widget calendarSummary(String title, String description){
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Text(title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget calendarSummaryWidthCount(String title, String description, int followsCount){
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: maxHeight * 0.3,
              child: Text(title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: maxHeight * 0.5,
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: maxHeight * 0.2,
              width: maxWidth,
              child: calendarFollowCount(followsCount),
            ),
          ],
        );
      }
    ),
  );
}

Widget calendarFollowCount(int followsCount){
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      RichText(
        text: TextSpan(
          children: [
            WidgetSpan(
              child: Icon(Icons.star, size: 16, color: Colors.yellow[800],),
            ),
            TextSpan(
              text: followsCount.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
    ],
  );
}














