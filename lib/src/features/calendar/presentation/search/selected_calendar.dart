import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import '../../application/favorite_provider.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_user_repositories.dart';

class SelectedCalendar extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const SelectedCalendar(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              width: deviceWidth,
              child: Row(
                children: [
                  calendarIconBig(calendarDoc.calendar!.image),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: SizedBox(
                      height: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: calendarTitle(calendarDoc.calendar!.title!)),
                          followButton(calendarDoc.docId!)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(calendarDoc.calendar!.description != null)
            calendarDescription(calendarDoc.calendar!.description!),
        ],
      ),
    );
  }
}

Widget calendarIconBig(String? image){
  Image imagePath = Image.asset('images/no_image.png',fit: BoxFit.cover,);
  if(image != null) {
    imagePath = Image.network(image);
  }
  return Container(
    height: 140,
    width: 140,
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

Widget calendarTitle(String title){
  return Text(title,
    textAlign: TextAlign.start,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 30,
      //fontWeight: FontWeight.bold,
    ),
  );
}

Widget followButton(String docId){
  return Consumer(
    builder: (context, ref, _) {
      final follow = ref.watch(getFollowCalendar(docId));
      return follow.when(
          data: (value){
            if(!value){
              return TextButton(
                onPressed: (){
                  ref.read(calendarUserRepositories).createCalendarUser(docId);
                  ref.refresh(getFollowCalendar(docId).future);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple
                ),
                child: const Text(
                  'フォローする',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }else{
              return TextButton(
                onPressed: (){
                  ref.read(calendarUserRepositories).deleteFollowCalendar(docId);
                  ref.refresh(getFollowCalendar(docId).future);
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple
                ),
                child: const Text(
                  'フォロー解除',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
          },
          error: (err, stack) => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator())
      );
    }
  );
}

Widget calendarDescription(String description){
  return Text(
    description,
    textAlign: TextAlign.start,
    style: const TextStyle(
      color: Colors.black,
      fontSize: 30,
      //fontWeight: FontWeight.bold,
    ),
  );
}