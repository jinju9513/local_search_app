import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'title': '스타벅스 강남점',
      'category': '카페',
      'roadAddress': '서울 강남구 테헤란로 123',
    },
    {
      'title': '이디야커피',
      'category': '커피숍',
      'roadAddress': '서울 서초구 서초대로 456',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //키보드 내려가게 하는
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {},
                //버튼의 터치영역은 44 디바이스 픽셀 이상으로 해줘야함!!(UX)
                child: Container(
                    width: 50,
                    height: 50,
                    //컨테이너에 배경색이 없으면 자녀위젯에만 터치 이벤트가 적용됨
                    color: Colors.transparent,
                    child: Icon(Icons.my_location))),
          ],
          title: TextField(
            maxLines: 1,
            decoration: InputDecoration(
                hintText: '검색어를 입력해주세요',
                border: MaterialStateOutlineInputBorder.resolveWith((states) {
                  print(states);
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
                })),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
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
                  Text(item['title'] ?? '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(item['category'] ?? '',
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 4),
                  Text(item['roadAddress'] ?? '',
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
