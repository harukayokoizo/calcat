import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_calendar/src/features/authentication/presentation/support/privacy_policy.dart';
import 'package:share_calendar/src/features/authentication/presentation/support/terms_of_use.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../calendar/presentation/calendar_info/detail/icon_widget.dart';
import 'local_event_delete_page.dart';

class SupportList extends ConsumerWidget{
  const SupportList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    const supportList = [
      'プライバシーポリシー',
      '利用規約',
      // 'お問い合わせ',
      'AppStoreで評価する',
      'データ削除',
    ];
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("サポート"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
                List.generate(supportList.length, (index) {
                  return InkWell(
                    onTap: () async{
                      Widget page;
                      switch (index){
                        case 0:
                          page = const PrivacyPolicy();
                        case 1:
                          page = const TermsOfUse();
                        case 2:
                          page = SizedBox();
                        case 3:
                          page = const LocalEventDeletePage();
                        default:
                          page = SizedBox();
                      }
                      if(index != 2){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => page,
                          ),
                        );
                      }else{
                        final url = Uri.parse('https://apps.apple.com/jp/app/calcat/id6505086858');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        } else {
                          throw 'App Store を開けませんでした: $url';
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: index == 0 ? const BorderSide(
                            width: 0.5,
                            color: Color(0xFFD8D8D8),
                          ) : BorderSide.none,
                          bottom: const BorderSide(
                            width: 0.5,
                            color: Color(0xFFD8D8D8),
                          ),
                        ),
                      ),
                      child: ListTile(
                        title: Text(supportList[index]),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFD8D8D8),
                        ),
                      ),
                    ),
                  );
                }),
            ),
          ),
        ],
      ),
    );
  }
}