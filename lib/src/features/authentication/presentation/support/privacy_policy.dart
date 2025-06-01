import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_calendar/src/features/authentication/presentation/support/terms_of_use.dart';

class PrivacyPolicy extends StatelessWidget{
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('プライバシーポリシー'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleHeading('CalCatプライバシーポリシー'),
              ArticleContent('当方は、ユーザーの個人情報の保護に最大限配慮し、以下のとおりプライバシーポリシー（以下、「本ポリシー」）を定めます。'),
              ArticleHeading('第1条（取得する情報）'),
              ArticleContent('・メールアドレス（カレンダー公開機能利用時のみ）'),
              ArticleContent('・イベント情報（カレンダー内容）'),
              ArticleContent('・写真（ユーザーがイベント画像として登録した場合）'),
              ArticleContent('・Firebaseを通じた端末識別情報、クラッシュ情報 等'),
              ArticleHeading('第2条（利用目的）'),
              ArticleContent('・アプリ提供・機能改善のため'),
              ArticleContent('・ユーザーがカレンダーを共有・公開するための認証'),
              ArticleContent('・広告・分析サービス（Firebase等）の利用のため'),
              ArticleHeading('第3条（第三者提供）'),
              ArticleContent('当方は、取得した個人情報を、法令に基づく場合を除き、第三者に提供いたしません。'),
              ArticleHeading('第4条（外部サービス連携）'),
              ArticleContent('本アプリは Firebase を利用しており、Googleのプライバシーポリシーが適用される部分があります。'),
              ArticleHeading('第5条（ユーザーによる操作）'),
              ArticleContent('ユーザーは、アプリ内で登録したカレンダーや写真を、いつでも削除・非公開にできます。'),
              // ArticleHeading('第6条（お問い合わせ）'),
              // ArticleContent('プライバシーに関するお問い合わせは、アプリ内の「お問い合わせ」からご連絡ください。'),
            ],
          ),
        ),
      )
    );
  }
}