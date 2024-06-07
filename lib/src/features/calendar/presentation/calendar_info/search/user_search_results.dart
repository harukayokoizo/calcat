import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/data/user_repositories.dart';

import '../../../application/calendar_list_provider.dart';
import '../../../data/calendar_repositories.dart';
import '../../../domain/calendar_document.dart';
import 'add_user_dialog.dart';

class UserSearchResult extends ConsumerStatefulWidget {
  final String mailAddress;
  final CalendarDocument calendarDoc;

  const UserSearchResult(this.mailAddress, this.calendarDoc, {super.key});

  @override
  ConsumerState<UserSearchResult> createState() => UserSearchResultState();

}

class UserSearchResultState extends ConsumerState<UserSearchResult>{

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final currentUser = FirebaseAuth.instance.currentUser;
    final getUser = ref.watch(userRepositories).getUser(widget.mailAddress);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<String?>(
        future: getUser,
        builder: (BuildContext context, AsyncSnapshot<String?> user) {
          if(user.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(user.hasData){
            final uid = user.data;
            return ListView(
              children:[
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(12, 10, 5, 10),
                    title: Text(widget.mailAddress),
                    leading: const Icon(Icons.account_circle),
                    trailing: FutureBuilder(
                        future: ref.read(calendarRepositories).getCalendarOwner(widget.calendarDoc.docId!, uid!),
                        builder: (BuildContext context, AsyncSnapshot<bool> calendar) {
                          if(calendar.hasData){
                            if(user.connectionState == ConnectionState.waiting){
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }else if(currentUser!.uid == uid){
                              return const SizedBox();
                            }else if(calendar.data!){
                              return TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DeleteCalendarOwnerDialog(widget.calendarDoc, uid);
                                    },
                                  ).then((value){
                                    if(value){
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Text('削除'),
                              );
                            }else{
                              return TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AddCalendarOwnerDialog(widget.calendarDoc, uid);
                                    },
                                  ).then((value){
                                    if(value){
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Text('追加'),
                              );
                            }
                          }else{
                            return const SizedBox();
                          }
                      }
                    ),
                  ),
                ),
              ]
            );
          }else {
            return const Center(
              child: Text(
                '検索結果はありません。',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

