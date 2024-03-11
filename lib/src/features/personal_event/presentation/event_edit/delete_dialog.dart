import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget{
  const DeleteDialog({super.key});

  @override

  Widget build(BuildContext context) {
    int count = 0;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      backgroundColor: const Color.fromRGBO(85, 85, 85, 1),
      content: const Text(
        "本当に削除してもよろしいでしょうか",
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      //actionsPadding: EdgeInsets.all(1.0),
      actions: <Widget>[
        // ボタン領域
        TextButton(
            child: const Text(
              "削除",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.red
              ),
            ),
            onPressed: ()async{
              //await ref.read(roomRepositoriesProvider).deleteRoom(room.roomId!);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
        ),
        TextButton(
            child: const Text(
              "キャンセル",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
              //ref.read(deleteDialogFlag.notifier).state = false;
            }
        ),
      ],
    );
  }
}