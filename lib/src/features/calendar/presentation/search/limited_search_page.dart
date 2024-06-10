import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/presentation/error_message_widget.dart';
import '../../application/search_provider.dart';
import '../../domain/calendar_document.dart';
import 'limited_search_results.dart';

class LimitedCalendar extends ConsumerWidget{
  const LimitedCalendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final List<CalendarDocument> searchResults = ref.watch(searchResultsProvider);
    final bool result = ref.watch(resultPage);
    print(result);
    if(result){
      return LimitedCalendarSearchResults(searchResults);
    }else{
      return LimitedCalendarSearch();
    }
  }
}

class LimitedCalendarSearch extends ConsumerWidget{
  final calendarTitleController = TextEditingController();
  final passwordController = TextEditingController();
  final focusNode = FocusNode();
  late String calendarTitle;
  late String password;
  late String errorMessage = '';
  LimitedCalendarSearch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('非公開カレンダーの検索'),),
      body: Focus(
        focusNode: focusNode,
        child: SizedBox(
          width: deviceWidth,
          height: deviceHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(errorMessage == '')
                const Spacer(flex: 1,),
              if(errorMessage != '')
                Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: ErrorMessageWidget(errorMessage)
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: deviceWidth * 0.8,
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: calendarTitleController,
                    decoration: const InputDecoration(
                      hintText: 'カレンダー名',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: deviceWidth * 0.8,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'パスワード',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 6,),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: deviceWidth * 0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async{
                      ref.read(searchResultsProvider.notifier).searchLimitedCalendar(calendarTitleController.text, passwordController.text)
                          .then((value){
                            ref.read(resultPage.notifier).resultPage(true);
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                      //side: BorderSide(color: Colors.black)
                    ),
                    child: const Text(
                      "検索する",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),

                  ),
                ),
              ),
              const Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }
}