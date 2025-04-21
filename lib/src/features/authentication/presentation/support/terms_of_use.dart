import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsOfUse extends StatelessWidget{
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('利用規約'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleHeading('CalCat 利用規約'),
              ArticleContent('この利用規約（以下、「本規約」といいます。）は、個人運営者（以下、「当方」といいます。）が提供するスマートフォンアプリ「CalCat」（以下、「本アプリ」といいます。）の利用条件を定めるものです。本アプリを利用することにより、ユーザーは本規約に同意したものとみなされます。'),
              ArticleHeading('第1条（適用）'),
              ArticleContent('本規約は、ユーザーと当方との間の本アプリの利用に関わる一切の関係に適用されます。'),
              ArticleHeading('第2条（利用登録）'),
              ArticleContent('本アプリの基本機能は、ユーザー登録を行わずに利用可能です。\n一部機能（例：カレンダーの公開）については、メールアドレスの登録が必要となります。'),
              ArticleHeading('第3条（禁止事項）'),
              ArticleContent('ユーザーは、以下の行為をしてはなりません。'),
              ArticleContent('・法令または公序良俗に違反する行為'),
              ArticleContent('・他人の情報を不正に取得・使用する行為'),
              ArticleContent('・アプリの運営を妨害する行為'),
              ArticleHeading('第4条（サービスの提供の中断等）'),
              ArticleContent('当方は、以下の場合に事前通知なしに本アプリの全部または一部を停止・中断することがあります。'),
              ArticleHeading('第5条（免責事項）'),
              ArticleContent('当方は、本アプリの利用により生じた損害について、一切の責任を負いません。'),
            ],
          ),
        ),
      )
    );
  }
}

Widget ArticleHeading(String head){
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
    child: Text(
      head,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget ArticleContent(String content){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      content,
    ),
  );
}