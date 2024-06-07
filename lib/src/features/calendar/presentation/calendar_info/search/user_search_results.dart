import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/data/user_repositories.dart';

class UserSearchResult extends ConsumerStatefulWidget {
  const UserSearchResult(this.mailAddress, {super.key});
  final String mailAddress;

  @override
  ConsumerState<UserSearchResult> createState() => UserSearchResultState();

}

class UserSearchResultState extends ConsumerState<UserSearchResult>{
  String? uid;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final getUser = ref.watch(userRepositories).getUser(widget.mailAddress);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<String?>(
        future: getUser,
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if(snapshot.hasData){
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
                    // trailing: FutureBuilder(
                    //     future: getUser,
                    //     builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    //       if(snapshot.hasData){
                    //         return TextButton(
                    //           onPressed: () {  },
                    //           child: Text('追加'),
                    //         );
                    //       }
                    //   }
                    // ),
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

