import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoneymanagementapp/constants/color_constant.dart';
import 'package:fluttermoneymanagementapp/models/card_model.dart';
import 'package:fluttermoneymanagementapp/models/operation_model.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Current selected
  int current = 0;

  ///Handle Indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(top: 8),
            child: ListView(physics: ClampingScrollPhysics(), children: [
              //// Custom AppBar
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          print("Drawer Tapped!");
                        },
                        child: SvgPicture.asset('assets/svg/drawer_icon.svg')),
                    Container(
                      height: 59,
                      width: 59,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/user_image.png'))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),

              Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ([
                    Text(
                      'Good Morning',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kBlackColor),
                    ),
                    Text(
                      'Amanda Alex',
                      style: GoogleFonts.inter(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: kBlackColor),
                    ),
                  ]),
                ),
              ),
              Container(
                height: 199,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16, right: 6),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 199,
                        width: 344,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Color(cards[index].cardBackground),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                child: SvgPicture.asset(
                                    cards[index].cardElementBottom)),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                  cards[index].cardElementBottom),
                            ),
                            Positioned(
                              left: 49,
                              top: 48,
                              child: Text(
                                'Card Number',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 29,
                              top: 65,
                              child: Text(
                                cards[index].cardNumber,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            Positioned(
                                right: 21,
                                top: 35,
                                child: Image.asset(
                                  cards[index].cardType,
                                  width: 29,
                                  height: 27,
                                )),
                            Positioned(
                              left: 29,
                              bottom: 45,
                              child: Text(
                                'Card HOLDERNAME',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 29,
                              bottom: 21,
                              child: Text(
                                cards[index].user,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 202,
                              bottom: 45,
                              child: Text(
                                'EXPIRE DATE',
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: kWhiteColor),
                              ),
                            ),
                            Positioned(
                              left: 202,
                              bottom: 21,
                              child: Text(
                                cards[index].cardExpired,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kWhiteColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 16, bottom: 13, top: 29, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Operation',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: kBlackColor)),
                      Row(
                        children: map<Widget>(datas, (index, selected) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            height: 9,
                            width: 9,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: current == index
                                    ? kBlueColor
                                    : kTwentyBlueColor),
                          );
                        }),
                      ),
                    ],
                  )),
              Container(
                height: 123,
                child: ListView.builder(
                    itemCount: datas.length,
                    padding: EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                        },
                        child: OperationCard(
                          operation: datas[index].name,
                          selectedIcon: datas[index].selectedIcon,
                          unselectedIcon: datas[index].unselectedIcon,
                          isSelected: current == index,
                          context: this,
                        ),
                      );
                    }),
              )
            ])));
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selection;
  final String unselectedIcon;
  final String isSelected;
  String selectedIcon;
  _HomeScreenState context;

  OperationCard(
      {Key key,
      this.operation,
      this.selection,
      this.unselectedIcon,
      this.isSelected,
      String selectedIcon,
      _HomeScreenState context})
      : super(key: key);

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kTenBlackColor,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected != null ? kBlueColor : kWhiteColor),
      child: Column(
        children: [
          SvgPicture.asset(widget.isSelected != null
              ? widget.selectedIcon
              : widget.unselectedIcon),
          SizedBox(
            height: 9,
          ),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: widget.isSelected != null ? kWhiteColor : kBlueColor),
          )
        ],
      ),
    );
  }
}
