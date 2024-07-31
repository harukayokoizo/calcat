import 'package:flutter/cupertino.dart';

class ActionSheet extends StatelessWidget{
  const ActionSheet({super.key});


  @override
  Widget build(BuildContext context){
    return CupertinoActionSheet(
      // title: Text('アクションを選択'),
      // message: Text('以下のオプションから選んでください。'),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text('特定の予定を編集'),
          onPressed: () {
            Navigator.pop(context, 1);
            // オプション1が選択されたときの処理
          },
        ),
        CupertinoActionSheetAction(
          child: Text('定期的な予定を編集'),
          onPressed: () {
            Navigator.pop(context, 2);
            // オプション2が選択されたときの処理
          },
        ),
        // 他のアクションボタン
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('キャンセル'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}