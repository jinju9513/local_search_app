import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_search_app/ui/detail/detail_page.dart';
import 'package:local_search_app/ui/home/home_page_view_model.dart';
import 'package:local_search_app/ui/home/widgets/home_clean_text.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final items =ref.watch(locationProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 키보드 내려가게 하는
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.my_location),
              ),
            ),
          ],
          title: TextField(
            onSubmitted: (value) {
              ref.read(locationProvider.notifier).search(value); // 검색실행
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: '검색어를 입력해주세요',
              border: MaterialStateOutlineInputBorder.resolveWith((states) {
                if (states.contains(WidgetState.focused)) {
                  return OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  );
                }
                return OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                );
              }),
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () {
                final link = item.link;
                if (link != null && link.startsWith('http')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(link:link),
                    ),
                  );
                }else{
                  print('링크가 유효하지 않음: $link');
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cleanText(item.title),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text(cleanText(item.category),
                        style: TextStyle(color: Colors.grey[700])),
                    SizedBox(height: 4),
                    Text(cleanText(item.roadAddress),
                        style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
