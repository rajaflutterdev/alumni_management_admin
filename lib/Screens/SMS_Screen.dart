
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:flutter_sms/flutter_sms.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../utils.dart';
class SMS_Screen extends StatefulWidget {
  const SMS_Screen({super.key});

  @override
  State<SMS_Screen> createState() => _SMS_ScreenState();
}

class _SMS_ScreenState extends State<SMS_Screen> {

  TextfieldTagsController controller = TextfieldTagsController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  static List<String> _pickLanguage = <String>[];
  String currentTab = 'ADD';


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height / 81.375, horizontal: width / 170.75),
      child: SingleChildScrollView(
        child: FadeInRight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 81.375, horizontal: width / 170.75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height / 81.375),
                      child: KText(
                        text: "SMS COMMUNICATION",
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: width / 82.538,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff030229),),
                      ),
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width / 1.39),
                    child: InkWell(
                        onTap: () {
                          if (currentTab.toUpperCase() == "VIEW") {
                            setState(() {
                              currentTab = "Add";
                            });
                          } else {
                            setState(() {
                              currentTab = 'View';
                            });
                          }
                        },
                        child: Container(
                          height: height / 18.6,
                          width: width / 10.9714,
                          decoration: BoxDecoration(
                            color: Constants().primaryAppColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(1, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: width / 227.66),
                            child: Center(
                              child: KText(
                                text: currentTab.toUpperCase() == "VIEW"
                                    ? "Send SMS"
                                    : "View SMS",
                                style: SafeGoogleFont(
                                  'Nunito',
                                  color: Colors.white,
                                  fontSize: width / 105.07,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
              currentTab.toUpperCase() == "ADD"
                  ? Container(
                height: size.height * 0.85,
                width: width / 1.28,
                margin: EdgeInsets.symmetric(
                    horizontal: width / 68.3, vertical: height / 32.55),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width / 68.3,
                            vertical: height / 81.375),
                        child: Row(
                          children: [
                            Icon(Icons.message),
                            SizedBox(width: width / 136.6),
                            KText(
                              text: "SMS",
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: width / 68.3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 68.3, vertical: height / 32.55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: "Single/Mulitiple Phone Numbers *",
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      color: Colors.black,
                                      fontSize: width / 105.07,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: height / 73.9),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Autocomplete<String>(
                                      optionsViewBuilder: (context, onSelected,
                                          options) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: width / 136.6,
                                              vertical: height / 162.75),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Material(
                                              elevation: 4.0,
                                              child: ConstrainedBox(
                                                constraints: const BoxConstraints(
                                                    maxHeight: 20),
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: options.length,
                                                  itemBuilder: (
                                                      BuildContext context,
                                                      int index) {
                                                    final dynamic option = options
                                                        .elementAt(index);
                                                    return TextButton(
                                                      onPressed: () {
                                                        onSelected(option);
                                                      },
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              vertical: height /
                                                                  43.4),
                                                          child: Text(
                                                            '#$option',
                                                            textAlign: TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                  255, 74, 137,
                                                                  92),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      optionsBuilder: (
                                          TextEditingValue textEditingValue) {
                                        if (textEditingValue.text == '') {
                                          return Iterable<String>.empty();
                                        }
                                        return _pickLanguage.where((
                                            String option) {
                                          return option.contains(
                                              textEditingValue.text
                                                  .toLowerCase());
                                        });
                                      },
                                      onSelected: (String selectedTag) {
                                        controller.addTag = selectedTag;
                                      },
                                      fieldViewBuilder: (context, ttec, tfn,
                                          onFieldSubmitted) {
                                        return TextFieldTags(
                                          textEditingController: ttec,
                                          focusNode: tfn,
                                          textfieldTagsController: controller,
                                          initialTags: [],
                                          textSeparators: [' ', ','],
                                          letterCase: LetterCase.normal,
                                          validator: (String tag) {
                                            if (tag == 'php') {
                                              return 'No, please just no';
                                            } else
                                            if (controller.getTags!.contains(
                                                tag)) {
                                              return 'you already entered that';
                                            }
                                            return null;
                                          },
                                          inputfieldBuilder:
                                              (context, tec, fn, error,
                                              onChanged, onSubmitted) {
                                            return ((context, sc, tags,
                                                onTagDelete) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width / 136.6),
                                                child: TextField(
                                                  controller: tec,
                                                  focusNode: fn,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    focusedBorder: InputBorder
                                                        .none,
                                                    helperStyle: TextStyle(
                                                      color: Constants()
                                                          .primaryAppColor,
                                                    ),
                                                    errorText: error,
                                                    prefixIconConstraints: BoxConstraints(
                                                        maxWidth: size.width *
                                                            0.74),
                                                    prefixIcon: tags.isNotEmpty
                                                        ? SingleChildScrollView(
                                                      controller: sc,
                                                      scrollDirection: Axis
                                                          .horizontal,
                                                      child: Row(
                                                          children: tags.map((
                                                              String tag) {
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(
                                                                  Radius
                                                                      .circular(
                                                                      20.0),
                                                                ),
                                                                color: Constants()
                                                                    .primaryAppColor,
                                                              ),
                                                              margin:
                                                              EdgeInsets.only(
                                                                  right: width /
                                                                      136.6),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: width /
                                                                      136.6,
                                                                  vertical: height /
                                                                      162.75),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  InkWell(
                                                                    child: Text(
                                                                      tag,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: width /
                                                                          341.5),
                                                                  InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .cancel,
                                                                        size: width /
                                                                            97.571,
                                                                        color: Colors
                                                                            .black
                                                                    ),
                                                                    onTap: () {
                                                                      onTagDelete(
                                                                          tag);
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }).toList()),
                                                    )
                                                        : null,
                                                  ),
                                                  onChanged: (text) {
                                                    if (text.length == 10) {
                                                      setState(() {
                                                        controller.addTag =
                                                            text;
                                                      });
                                                    }
                                                  },
                                                  onSubmitted: onSubmitted,
                                                ),
                                              );
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height / 21.7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KText(
                                  text: "Description",
                                  style: SafeGoogleFont(
                                    'Nunito',
                                    color: Colors.black,
                                    fontSize: width / 105.07,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: height / 73.9),
                                Container(
                                    height: 160,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffDDDEEE),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: TextFormField(
                                      style: TextStyle(
                                          fontSize: width / 113.83),
                                      controller: descriptionController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: width / 91.066,
                                              top: height / 162.75,
                                              bottom: height / 162.75)
                                      ),
                                      maxLines: null,
                                    )
                                ),
                              ],
                            ),
                            SizedBox(height: height / 6.1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    List<String>? tagss = await controller.getTags;
                                    if(tagss!.isNotEmpty) {
                                      sending_SMS(descriptionController.text,tagss);
                                      for(int i=0;i<tagss.length;i++){
                                        FirebaseFirestore.instance.collection("Sms").doc().set({
                                          "number":tagss[i],
                                          "description":descriptionController.text,
                                          "date":"${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                          "time":DateTime.now().millisecondsSinceEpoch,
                                        });
                                      }
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Mail Sended successfully!",
                                          width: size.width * 0.4,
                                          backgroundColor: Constants()
                                              .primaryAppColor
                                              .withOpacity(0.8));
                                      setState(() {
                                        controller.clearTags();
                                        descriptionController.text = "";
                                        currentTab = 'ADD';
                                      });
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  },
                                  child: Container(
                                      height: height / 18.475,
                                      width: width / 12.8,
                                      decoration: BoxDecoration(
                                        color: Color(0xffD60A0B),
                                        borderRadius:
                                        BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.send,
                                                color: Colors.white),
                                            SizedBox(width: width / 273.2),
                                            KText(
                                              text: "SEND",
                                              style: SafeGoogleFont(
                                                'Nunito',
                                                color: Colors.white,
                                                fontSize: width / 136.6,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : currentTab.toUpperCase() == "VIEW" ?
              SizedBox(
                height: size.height * 0.85,
                width: width / 1.28,
              )
              /*StreamBuilder(
                stream: DepartmentFireCrud.fetchDepartments(),
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Container();
                  } else if (snapshot.hasData) {
                    List<DepartmentModel> sms = [];
                    return Container(
                      width:width/1.241,
                      margin: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                      decoration: BoxDecoration(
                        color: Constants().primaryAppColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1, 2),
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: size.height * 0.1,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width/68.3, vertical: height/81.375),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  KText(
                                    text: "SMS (${sms.length})",
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize:width/68.3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.7 > 70 + sms.length * 60
                                ? 70 + sms.length * 60
                                : size.height * 0.7,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            padding: EdgeInsets.symmetric(horizontal: width/68.3, vertical: height/32.55),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width/34.15,
                                        child: KText(
                                          text: "No.",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/17.075,
                                        child: KText(
                                          text: "Time",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/113.83,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/136.60,
                                        child: KText(
                                          text: "Phone",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/113.83,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/136.60,
                                        child: KText(
                                          text: "Content",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/136.60,
                                        child: KText(
                                          text: "SMS ID",
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/9.106,
                                        child: KText(
                                          text: "SMS Network",
                                          style:SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/136.60,
                                        child: KText(
                                          text: "SMS Cost",
                                          style:SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/6.83,
                                        child: KText(
                                          text: "Current Balance",
                                          style:SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:width/9.106,
                                        child: KText(
                                          text: "Actions",
                                          style:SafeGoogleFont (
                                            'Nunito',
                                            fontSize:width/105.07,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height:height/65.1),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 0,
                                    itemBuilder: (ctx, i) {
                                      return Container(
                                        height: height/10.85,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(
                                              color: Color(0xfff1f1f1),
                                              width: 0.5,
                                            ),
                                            bottom: BorderSide(
                                              color: Color(0xfff1f1f1),
                                              width: 0.5,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width:width/17.075,
                                              child: KText(
                                                text: (i + 1).toString(),
                                                style:SafeGoogleFont (
                                            'Nunito',
                                                  fontSize:width/105.07,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:width/7.588,
                                              child: KText(
                                                text: "departments[i].name!",
                                                style:SafeGoogleFont (
                                            'Nunito',
                                                  fontSize:width/105.07,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:width/7.588,
                                              child: KText(
                                                text: "departments[i].leaderName!",
                                                style:SafeGoogleFont (
                                            'Nunito',
                                                  fontSize:width/105.07,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:width/8.035,
                                              child: KText(
                                                text: "departments[i].contactNumber!",
                                                style:SafeGoogleFont (
                                            'Nunito',
                                                  fontSize:width/105.07,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:width/6.83,
                                              child: KText(
                                                text: "departments[i].location!",
                                                style:SafeGoogleFont (
                                            'Nunito',
                                                  fontSize:width/105.07,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width:width/6.83,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height:height/26.04,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xff2baae4),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset: Offset(
                                                                  1, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:width/227.66),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .remove_red_eye,
                                                                  color: Colors
                                                                      .white,
                                                                  size:width/91.06,
                                                                ),
                                                                KText(
                                                                  text: "View",
                                                                  style: SafeGoogleFont (
                                                                    'Nunito',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:width/136.6,
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:width/273.2),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height:height/26.04,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xffff9700),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset: Offset(
                                                                  1, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:width/227.66),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                  size:width/91.06,
                                                                ),
                                                                KText(
                                                                  text: "Edit",
                                                                  style: SafeGoogleFont (
                                                                    'Nunito',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:width/136.6,
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:width/273.2),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height:height/26.04,
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xfff44236),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset: Offset(
                                                                  1, 2),
                                                              blurRadius: 3,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal:width/227.66),
                                                          child: Center(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceAround,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .cancel_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                  size:width/91.06,
                                                                ),
                                                                KText(
                                                                  text: "Delete",
                                                                  style:SafeGoogleFont (
                                                                    'Nunito',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:width/136.6,
                                                                    fontWeight: FontWeight
                                                                        .bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              )*/
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result = await sendSMS(message: msg, recipients: list_receipents)
        .catchError((err) {
      print(err);
    });
    print(send_result);
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants().primaryAppColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, color: Constants().primaryAppColor),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Please fill required fields !!',
                  style: TextStyle(color: Colors.black)),
            ),
            Spacer(),
            TextButton(
                onPressed: () => debugPrint("Undid"), child: Text("Undo"))
          ],
        )),
  );

/*
  void sendSMS(List<String> recipients, String message) async {
    try {
      String _result = await sendSMSmessage(
        message,
        recipients,
      );
      print('SMS Sent successfully! Result: $_result');
    } catch (error) {
      print('Error sending SMS: $error');
    }
  }*/
}