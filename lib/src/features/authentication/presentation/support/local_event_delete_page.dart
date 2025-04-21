import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/support/terms_of_use.dart';

import '../../../event/data/event_local_repositories.dart';

class LocalEventDeletePage extends ConsumerStatefulWidget{
  const LocalEventDeletePage({super.key});

  @override
  LocalEventDeletePageState createState() => LocalEventDeletePageState();
}

class LocalEventDeletePageState extends ConsumerState<LocalEventDeletePage>{
  final passTextController = TextEditingController();
  final mailTextController = TextEditingController();
  final focusNode = FocusNode();
  bool loading = false;
  @override

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: const Text('データ削除', style: TextStyle(fontSize: 18),),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'こちらのリンクからデータを削除すると、「MyCalendar」タブに保存されているイベントはすべて削除されます。削除は元に戻せませんのでご注意ください。',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('データ削除'),
                            content: const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('本当のアカウントを削除しますか？',),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text(
                                    "キャンセル",
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context, false);
                                  }
                              ),
                              TextButton(
                                  child: const Text(
                                    "削除",
                                  ),
                                  onPressed: (){
                                    setState(() {
                                      loading = true;
                                    });
                                    Navigator.pop(context, true);
                                  }
                              ),
                            ],
                          );
                        },
                      ).then((delete){
                        if(delete){
                          ref.read(eventLocalRepositories).deleteAllEvent().then((value){
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context, true);
                          }).catchError((error){
                          });
                        }
                      });
                    },
                    child: const Text(
                      'データを削除',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
        if(loading)
          Container(
            height: deviceHeight,
            width: deviceWidth,
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}