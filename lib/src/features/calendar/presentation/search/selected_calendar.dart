import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/domain/calendar_document.dart';
import '../../application/favorite_provider.dart';
import '../../application/search_provider.dart';
import '../../data/calendar_user_repositories.dart';
import '../calendar_info/detail/description_widget.dart';
import '../calendar_info/detail/icon_widget.dart';
import '../calendar_info/detail/link_widget.dart';
import '../calendar_info/detail/title_widget.dart';

class SelectedCalendar extends ConsumerWidget{
  final CalendarDocument calendarDoc;
  const SelectedCalendar(this.calendarDoc, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final safeArea = MediaQuery.of(context).padding.top;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
      child: Material(
        color: const Color(0xFFF5F5F5),
        child: Stack(
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  expandedHeight: deviceHeight / 3.0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: const Text('test'),
                      background: CalendarIconWidget(calendarDoc.calendar!)
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Column(children: [
                        CalendarTitleWidget(calendarDoc.calendar!),
                        CalendarDescriptionWidget(calendarDoc.calendar!),
                        CalendarLinkWidget(calendarDoc.calendar!),
                      ],)
                    ]
                    ))
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: safeArea),
              child: IconButton(
                icon: const CircularIcon(
                  icon: Icons.clear,
                  backgroundColor: Colors.grey,
                  iconColor: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 20,
                child: SizedBox(
                  width: deviceWidth,
                  child: followButton(calendarDoc.docId!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget followButton(String docId){
  return Padding(
    padding: const EdgeInsets.only(bottom: 30, left: 40, right: 40, top: 20),
    child: Consumer(
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
                      backgroundColor: Colors.purple,
                      fixedSize: const Size(0,45),
                  ),
                  child: const Text(
                    'フォローする',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
                      backgroundColor: Colors.purple,
                      fixedSize: const Size(0,45),
                  ),
                  child: const Text(
                    'フォロー解除',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
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
    ),
  );
}