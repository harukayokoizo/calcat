import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/search_provider.dart';
import '../../data/calendar_repositories.dart';

class SearchForm extends StatefulWidget{
  final bool search;
  @override
  const SearchForm(this.search, {super.key});

  @override
  State<SearchForm> createState() => SearchFormState();
}

class SearchFormState extends State<SearchForm>{
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Consumer(
      builder: (context, ref, _) {
        return Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: (value){
                    ref.read(searchSwitch.notifier).switchState(value);
                  },
                  child: TextFormField(
                    //initialValue: initialTitle,
                    controller: _controller,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _controller.clear();
                            });
                          },
                          icon: Icon(Icons.clear),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        hintText: '検索',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(30), right: Radius.circular(30))
                        )
                    ),
                    onChanged: (value){},
                    onFieldSubmitted: (value){
                      ref.read(calendarRepositories).searchCalendar(value).then((value){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => EventDetail(eventDoc, repositories),
                        //   ),
                        // );
                      });
                    },
                  ),
                ),
              ),
              if(widget.search)
              TextButton(
                  onPressed: (){
                    ref.read(searchSwitch.notifier).switchState(false);
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text(
                    'キャンセル',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  )
              ),
            ],
          ),
        );
      }
    );
  }
}