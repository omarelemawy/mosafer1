import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mosafer1/Fatorah/bloc/cubit.dart';
import 'package:mosafer1/Fatorah/bloc/state.dart';
import 'package:mosafer1/home/first_screen/chat_nav/bloc/state_chat.dart';
import 'package:mosafer1/shared/Utils.dart';
import 'package:mosafer1/shared/Widgets/FatoragShape.dart';
import 'package:mosafer1/shared/Widgets/SVGIcons.dart';
import 'package:mosafer1/shared/styles/thems.dart';
import 'dart:ui' as ui;

import 'AddServiceWidget.dart';

class FatorahPage extends StatelessWidget {
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    final FatorahCubit fatorahCubit = BlocProvider.of<FatorahCubit>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: TextButton(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              fatorahCubit.emit(InitialFatorahState());
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: SVGIcons.barIcon,
              onPressed: () {},
            ),
          ],
          title: Text(
            "طلب السعر",
            style: TextStyle(fontFamily: "beIN"),
          ),
        ),
        body: Directionality(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: size.width * 0.9,
                            minWidth: size.width * 0.9,
                            minHeight: size.height * 0.8),
                        child: CustomPaint(
                          child: Column(
                            children: [
                              Padding(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SVGIcons.hoursIcon,
                                    Padding(
                                        child: Text(
                                          "طلب",
                                          style: MyTheme.defaultAppTextTheme()
                                              .textTheme
                                              .headline1,
                                        ),
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10))
                                  ],
                                ),
                                padding: const EdgeInsets.only(top: 20),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Text(
                                  "  تاريخ الطلب  " +
                                      DateFormat.yMMMMEEEEd()
                                          .format(DateTime.now()),
                                  style: MyTheme.defaultAppTextTheme()
                                      .textTheme
                                      .headline2),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("تاريخ نهاية الخدمة",
                                      style: MyTheme.defaultAppTextTheme()
                                          .textTheme
                                          .headline2),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(DateFormat.yMMMMEEEEd()
                                        .format(DateTime.now())),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                              Utils.vSpace(15),
                              BlocConsumer<FatorahCubit, FatorahState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is InitialFatorahState ||
                                      state is MoreServicesFatorahState) {
                                    return Column(
                                      children: List<Widget>.generate(
                                          fatorahCubit.addServicesList.length,
                                          (index) => AddService(
                                                index: index,
                                              )),
                                    );
                                  }
                                  return Column(
                                    children: List<Widget>.generate(
                                        fatorahCubit.addServicesList.length,
                                        (index) => AddService(
                                              index: index,
                                            )),
                                  );
                                },
                              ),
                              Padding(
                                child: Row(
                                  children: [
                                    Text("مبلغ التامين تحصل علي ",
                                        style: MyTheme.defaultAppTextTheme()
                                            .textTheme
                                            .headline2),
                                    Spacer(),
                                    Text("55 ر.س",
                                        style: MyTheme.defaultAppTextTheme()
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Padding(
                                child: Row(
                                  children: [
                                    Text("رسوم خدمة الموقع",
                                        style: MyTheme.defaultAppTextTheme()
                                            .textTheme
                                            .headline2),
                                    Spacer(),
                                    Text("55 ر.س",
                                        style: MyTheme.defaultAppTextTheme()
                                            .textTheme
                                            .headline2),
                                  ],
                                ),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                              ),
                              Divider(
                                color: Colors.white,
                                thickness: 2,
                              ),
                              Utils.vSpace(15),
                              Padding(
                                child: BlocConsumer<FatorahCubit, FatorahState>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    if (state is NewTotalPriceState ||
                                        state is MoreServicesFatorahState) {
                                      return Row(
                                        children: [
                                          Text("المبلغ الاجمالي ",
                                              style:
                                                  MyTheme.defaultAppTextTheme()
                                                      .textTheme
                                                      .headline2),
                                          Spacer(),
                                          Text(
                                              "${fatorahCubit.totalPrice} " +
                                                  "ر.س ",
                                              style:
                                                  MyTheme.defaultAppTextTheme()
                                                      .textTheme
                                                      .headline2),
                                        ],
                                      );
                                    }
                                    return Row(
                                      children: [
                                        Text("المبلغ الاجمالي ",
                                            style: MyTheme.defaultAppTextTheme()
                                                .textTheme
                                                .headline2),
                                        Spacer(),
                                        Text("0.00" + "ر.س ",
                                            style: MyTheme.defaultAppTextTheme()
                                                .textTheme
                                                .headline2),
                                      ],
                                    );
                                  },
                                ),
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                              )
                            ],
                          ),
                          painter: FatorahCustomPainter(),
                          size: Size(size.width * 0.9, size.height * 0.8),
                        ),
                      ),
                      Align(
                        child: ElevatedButton(
                          onPressed: () {
                            fatorahCubit.emit(InitialFatorahState());
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(CircleBorder()),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.brown)),
                        ),
                        alignment: AlignmentDirectional.topStart,
                      )
                    ],
                  ),
                ),
                Utils.vSpace(20),
                Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: StatefulBuilder(
                      builder: (context, state) => CheckboxListTile(
                        onChanged: (val) {
                          state(() => _checked = !_checked);
                        },
                        title: Text(
                          "أتعهد  عند  طلب الإلغاء يكون  قبل  12 ساعة أو بالاتفاق مع  العميل  حتى لاتتحمل مسؤلية تعطل مصالح العميل",
                          textAlign: TextAlign.end,
                        ),
                        value: _checked,
                      ),
                    )),
                Utils.vSpace(20),
                BlocConsumer<FatorahCubit, FatorahState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: !(state is InitialFatorahState) &&
                              fatorahCubit.fatorahValidation()
                          ? () {
                        fatorahCubit.createNewFatorah(chatId: 1);
                        Navigator.pop(context,true);
                      }
                          : null,
                      child: Text("ارسل الفاتورة"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyTheme.mainAppColor),
                      ),
                    );
                  },
                ),
                Utils.vSpace(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "تنبيه",
                          style:
                              MyTheme.defaultAppTextTheme().textTheme.overline,
                        ),
                        Text(
                          "-  يجب كتابة ماهي الخدمة",
                        ),
                        Text(
                          "-  يجب تحدد سعر  الخدمة ",
                        ),
                        Text(
                          "-  يجب أضافة  الخدمة",
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          textDirection: ui.TextDirection.rtl,
        ));
  }
}
