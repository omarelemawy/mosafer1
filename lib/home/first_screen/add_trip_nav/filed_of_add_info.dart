import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FiledOfAddInfo extends StatelessWidget {
   TextEditingController dateController;
   TextEditingController placeController;
   FiledOfAddInfo(this.dateController,this.placeController);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 5,),
            Expanded(
              child: TextFormField(
                controller: placeController,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    labelText: "حدد المكان",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
              ),
            ),
            SizedBox(width: 5,),
            Image.asset("assets/Component1.png"),
            SizedBox(width: 5,),
            Expanded(
              child: TextFormField(
                onTap: (){
                  showDatePicker(context: context,
                    initialDate: DateTime.now().add(Duration(hours: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 10),
                     ).then((value) {
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    final String formatted = formatter.format(value);
                     dateController.text=formatted;
                  });
                },
                controller: dateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                    labelText: "حدد الوقت",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)
                    )
                ),
              ),
            ),
            SizedBox(width: 5,),
          ],
        ),
        SizedBox(height: 5,)
      ],
    );
  }
}
