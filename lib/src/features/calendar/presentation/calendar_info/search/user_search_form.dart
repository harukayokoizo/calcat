import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/calendar/presentation/calendar_info/search/user_search_results.dart';

class UserSearch extends ConsumerStatefulWidget {
  final mailAddressController = TextEditingController();

  UserSearch({super.key});

  @override
  ConsumerState<UserSearch> createState() => UserSearchState();

}

class UserSearchState extends ConsumerState<UserSearch>{
  final mailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Focus(
        child: GestureDetector(
          child: SizedBox(
            width: deviceWidth,
            height: deviceHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: deviceWidth * 0.8,
                    child: TextFormField(
                      controller: mailAddressController,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: 'メールアドレス',
                        helperStyle: TextStyle(),
                        helperText: '編集権限を与えるユーザーのメールアドレスを入力してください。',
                        helperMaxLines: 2,
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 12, 20),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value){
                        setState(() {});
                      },
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
                      onPressed: mailAddressController.text.isEmpty? null : () async{
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserSearchResult(mailAddressController.text),
                          ),
                        );
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
      ),
    );
  }
}