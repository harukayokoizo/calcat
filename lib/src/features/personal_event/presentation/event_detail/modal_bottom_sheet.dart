import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget{
  const ModalBottomSheet({super.key});

  @override

  Widget build(BuildContext context) {
    int index;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 250,
      alignment: Alignment.center,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:30.0),
        child: Column(
          children: [
            Material(
              color: Colors.white,
              child: InkWell(
                hoverColor: const Color.fromRGBO(0, 0, 0, 1),
                highlightColor: const Color.fromRGBO(0, 0, 0, 0.4),
                onTap: (){
                  index = 0;
                  Navigator.pop(
                    context,
                    index,
                  );
                },
                child: SizedBox(
                  width: deviceWidth,
                  height: 60,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 10.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          '削除',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: GestureDetector(
                ///画面遷移ボタン
                onTap: () async{
                  index = 1;
                  Navigator.pop(
                    context,
                    index,
                  );
                },

                ///ボタンの配置場所を決める
                child: Container(
                  //margin: const EdgeInsets.only(top: 10, bottom: 10),

                  ///paddingで水平方向と垂直方向を指定する
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 12),

                  ///コンテナの見た目の装飾
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      width: 2.0,
                    ),

                    ///boxの角の丸みを指定する
                    borderRadius: BorderRadius.circular(30),
                    //color: const Color(0xFF0AD269)
                  ),

                  ///boxの中にテキストを入れる
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}