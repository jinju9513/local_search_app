import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
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
                onTap: () {
                },
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
        body: GridView.builder(
          padding: EdgeInsets.all(20),
          itemCount: 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 3 / 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            ), 
          itemBuilder: (context,index){
            return GestureDetector(
              
              // child: Image.network(book.image)
              );
          })
      ),
    );
  }
}