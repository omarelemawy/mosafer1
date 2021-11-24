import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/shared/Widgets/CustomExpandedFAB.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'dart:ui' as ui;

class ComplaintInfoPage extends StatefulWidget {
  @override
  _ComplaintInfoPageState createState() => _ComplaintInfoPageState();
}

class _ComplaintInfoPageState extends State<ComplaintInfoPage> {
  TextEditingController _subjectController = TextEditingController();
  @override
  void initState() {
    _subjectController.text = "الموضوع ....";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("شكوى"),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "عميل موثوق",
                              style: TextStyle(
                                  color: MyTheme.mainAppColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                            ),
                            Text(
                              "ناصر فهد",
                            ),
                            Text(
                              "رقم الطلب : " + "21",
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: MyTheme.mainAppBlueColor,
                            ),
                            Icon(
                              Icons.arrow_back_ios,
                              color: MyTheme.mainAppBlueColor,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "مسافر ميز",
                              style: TextStyle(
                                  color: MyTheme.mainAppColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                            ),
                            Text(
                              "موسى محمد خالد",
                            ),
                            Text(
                              "رقم الرحلة : " + "21",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: MyTheme.mainAppBlueColor,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Text(
                    DateFormat.yMMMd().format(DateTime.now()),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: false,
                    controller: _subjectController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 24, color: MyTheme.mainAppBlueColor),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: MyTheme.mainAppBlueColor)),
                        labelText: "الموضوع"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("الردود"),
                ),
                Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) => ComplaintReplyItem(
                              index: index,
                            )))
              ],
            ),
            //Chat
            Align(
              child:  Container(
                padding: const EdgeInsets.all(10),
                alignment: AlignmentDirectional.centerStart,
                width: size.width,
                height: size.height * 0.1,
                color: MyTheme.mainAppBlueColorBright,
              ),
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Directionality(
                textDirection: ui.TextDirection.ltr,
                child: Align(
                  child: Padding(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          child: CustomExpandedFab(
                            mainButtonBackgroundColor: Colors.white,
                            mainButtonElevation: 9,
                            mainButtonIcon: Icon(
                              Icons.attach_file,
                              color: Colors.blue[900],
                              size: 20,
                            ),
                            onSecondaryButtonClick: (val) async {
                              print(val);
                              switch (val) {
                                case 1:
                                  {
                                    break;
                                  }
                                case 2:
                                  {
                                    break;
                                  }
                                case 3:
                                  {
                                    break;
                                  }
                                case 4:
                                  {}
                              }
                            },
                            secondaryButtons: [
                              SecondaryExpandedButton(
                                id: 4,
                                icon: Icon(Icons.mic),
                              ),
                              SecondaryExpandedButton(
                                id: 3,
                                icon: Icon(Icons.location_on),
                              ),
                              SecondaryExpandedButton(
                                id: 2,
                                icon: Icon(Icons.photo),
                              ),
                              SecondaryExpandedButton(
                                id: 1,
                                icon: Icon(Icons.camera_alt),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.only(left: 8, right: 8),
                        ),
                        Expanded(
                          child: Container(
                            height: size.height * 0.12,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 15,
                                      spreadRadius: 2)
                                ]),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    child: TextField(
                                      decoration: InputDecoration.collapsed(
                                          hintText: "ابدا المحادثة"),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.send,
                                    color: MyTheme.mainAppBlueColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.only(bottom: 15),
                  ),
                  alignment: AlignmentDirectional.bottomEnd,
                )),
          ],
        ),
      ),
    );
  }
}

class ComplaintReplyItem extends StatelessWidget {
  final int index;
  final VoidCallback onPress;
  const ComplaintReplyItem({Key key, this.index, this.onPress})
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
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFXjhzMO9qkPIXzK2vqlvhOt8uwkRfXZkzH7xv6uHjRwTdYH9fPJIzV1tQcgyDsGjAJ-c&usqp=CAU'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ناصر فهد",
                          style: TextStyle(
                              color: MyTheme.mainAppBlueColorBright
                                  .withOpacity(0.8)),
                        ),
                        Text(
                          "هذه الشكوى غير صحية",
                          style: TextStyle(color: MyTheme.mainAppBlueColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
