import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mosafer1/model/all-request-services.dart';
import 'package:mosafer1/shared/Constats.dart';

class MessageItem extends StatelessWidget {
  final ThemeData appTheme;
  final bool isCurrentUser;
  final Message message;
  const MessageItem(
      {Key key, this.appTheme, this.isCurrentUser = true, this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(message.messageType);
    return Directionality(
      textDirection: message.isCurrentUser ? TextDirection.rtl : TextDirection.ltr,
      child: message.messageType == MessageType.Reset ?  Expanded(
        child: Card(
            color: Colors.blue[100],
            margin: const EdgeInsets.only(
                left: 10, right: 10, bottom: 20, top: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            elevation: 9,
            child: Padding(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.message.isNotEmpty ? Text(
                    message.message,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ) : SizedBox(),
                  Text(message.time),
                ],
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
            )),
      ) : Container(
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey[500])),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: 'assets/man.png',
                        image: message.user.photo),
                  ),
                ),
                Text(
                  message.user.name,
                  style: appTheme.textTheme.bodyText2,
                )
              ],
            ),
            Expanded(
              child: Card(
                  color: Colors.blue[100],
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 20, top: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 9,
                  child: Padding(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        message.messageType == MessageType.ImageMessage ?
                        Padding (
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: placeholder,
                                    image: message.messageImage,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder: (context, err, obj) =>
                                        Image.asset(placeholder),
                                  ),
                                ),
                                padding: const EdgeInsets.all(15),
                              )
                            :
                        (
                        message.messageType == MessageType.MapMessage
                        ? Padding(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(mapImg),
                              ),
                              padding: const EdgeInsets.all(15),
                            ) : SizedBox()
                        ),
                        message.message.isNotEmpty ? Text(
                          message.message,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ) : SizedBox(),
                        Text(message.time),
                        SeenIcon()
                      ],
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class SeenIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        Icon(
          Icons.check,
          color: Colors.blue,
        ),
        Padding(
          child: Icon(
            Icons.check,
            color: Colors.blue,
          ),
          padding: const EdgeInsets.only(left: 10),
        )
      ],
    );
  }
}