import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/event_provider.dart';
import '../../../domain/event.dart';

class UrlForm extends ConsumerWidget{
  final Event event;
  final FocusNode focusNode;
  const UrlForm(this.event, this.focusNode, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    String? initialTitle = event.url ?? '';
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextFormField(
          initialValue: initialTitle,
          //controller: titleController,
          focusNode: focusNode,
          decoration: const InputDecoration(
              hintText: 'URL',
              border: InputBorder.none
          ),
          onChanged: (value){
            ref.read(eventFormStateProvider(event).notifier).changeUrl(value);
          },
        ),
      ),
    );
  }
}