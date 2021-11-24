import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mosafer1/Complaint/ComplaintInfoPage.dart';
import 'package:mosafer1/MosaferProfile/MosaferProfilePage.dart';
import 'package:mosafer1/shared/styles/thems.dart';

class ComplaintesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("صفحة المسافر"),
        centerTitle: true,
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) => ComplaintItem(
                    index: index,
                    onPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ComplaintInfoPage()));
                    },
                    onUserPress: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> MosaferProfilePage())),
                  ))),
    );
  }
}

class ComplaintItem extends StatelessWidget {
  final int index;
  final VoidCallback onPress;
  final VoidCallback onUserPress;
  const ComplaintItem({Key key, this.index, this.onPress, this.onUserPress})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey, width: 1.5)),
      child: InkWell(
        onTap: onPress,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: onUserPress,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: FittedBox(
                          child: Text(
                            "مغلقة",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: FittedBox(
                          child: Text(
                            "مفتوحة",
                            style: TextStyle(color: MyTheme.mainAppBlueColor),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.brown, width: 1.5)),
                        width: 60,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                      )
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: Text("سجلت نقطة سلبية",
                        style: TextStyle(color: Colors.white)),
                    decoration: BoxDecoration(
                        color: HexColor('#C08B45'),
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: MyTheme.mainAppBlueColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "رقم الطلب  : " + "$index",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "شكوى مقدمة من  ناصر فهد",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
