import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/styles/thems.dart';

import 'bloc/cubit.dart';
typedef StringCallBack = Function(String);
class AddService extends StatelessWidget {
   String serviceName = "";
   String servicePrice = "";
   final int index;
   AddService({Key key, this.index}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    final FatorahCubit fatorahCubit = BlocProvider.of<FatorahCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Utils.hSpace(15),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              onChanged: (val){
                serviceName = val;
                fatorahCubit.addServiceData(index,serviceName,servicePrice);
              },
              decoration: InputDecoration.collapsed(
                hintText: "حدد الخدمة",
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Utils.hSpace(10),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val){
                      servicePrice = val;
                      fatorahCubit.addServiceData(index,serviceName,servicePrice);
                    },
                    onSubmitted: (val){
                      fatorahCubit.calculateTotalServicesPrice();
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration.collapsed(
                      hintText: "حدد السعر",
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Text("ر٫س")
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Utils.hSpace(10),
        ElevatedButton(onPressed: (){
          fatorahCubit.addMoreService();
          fatorahCubit.calculateTotalServicesPrice();
        }, child: Icon(Icons.add,color: MyTheme.mainAppColor,),style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(CircleBorder())
        ),)
      ],
    );
  }
}
