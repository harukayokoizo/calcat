import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdateDialog extends ConsumerWidget{
  const AppUpdateDialog({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoAlertDialog(
      title: const Text('更新情報'),
      content: const Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Text('アプリの更新があります。最新版にアップデートしてご利用ください。',),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text(
              "アップデート",
            ),
            onPressed: () async{
              await launchURL();
            }
        ),
      ],
    );
  }
}

Future<void> launchURL() async {
  try {
    // const appId = 'io.metamask';
    // const androidUrl = 'market://details?id=$appId';
    const iosUrl = 'https://apps.apple.com/jp/app/calcat/id6505086858';
    // final targetUrl = Platform.isAndroid ? androidUrl : iosUrl;
    final bool appExist = await canLaunchUrl(Uri.parse(iosUrl));
    if (appExist) {
      await launchUrl(Uri.parse(iosUrl));
    }
  }catch (e){
    print(e.toString());
  }
}