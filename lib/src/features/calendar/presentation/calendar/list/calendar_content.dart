import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/calendar_document.dart';
import '../calendar.dart';

class CalendarContent extends StatelessWidget{
  CalendarDocument calendarDoc;

  CalendarContent(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10.0, right: 20.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PublicCalendarPage(calendarDoc),
            ),
          );
        },
        child: Container(
          height: 100,
          width: deviceWidth,
          decoration: BoxDecoration(
            //color: Colors.blue,
            border: const Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFFD8D8D8)),
                right: BorderSide(width: 1.0, color: Color(0xFFD8D8D8))
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              calendarIcon(calendarDoc.calendar!.image),
              calendarSummary(calendarDoc.calendar!.title!, calendarDoc.calendar!.description),
            ],
          ),
        ),
      ),
    );
  }

}

Widget calendarIcon(String? image){
  Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
  if(image != null) {
    imagePath = Image.network(image);
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

Widget calendarSummary(String title, String? description){
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Text(title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if(description != null)
          Flexible(
            flex: 2,
            child: Text(description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    ),
  );
}














