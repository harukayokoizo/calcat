import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'delete_account_page.dart';

enum MenuItem { deleteTodo, }

class DeletePopupMenu extends StatelessWidget {
  const DeletePopupMenu({super.key});

  @override
  Widget build(BuildContext context){
    return PopupMenuButton <MenuItem>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem <MenuItem>(
          value: MenuItem.deleteTodo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'アカウントを削除する',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
      onSelected: (MenuItem item) async{
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DeleteAccountPage(),
          ),
        ).then((delete){
          if(delete){
            Navigator.pop(context, true);
          }
        });
      },
      position: PopupMenuPosition.under,
      padding: const EdgeInsets.all(16.0),
      child: const Icon(Icons.settings),
    );
  }
}
