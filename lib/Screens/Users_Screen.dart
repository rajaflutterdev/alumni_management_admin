import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../Constant_.dart';
import '../Models/Language_Model.dart';
import '../Models/Response_Model.dart';
import '../StateModel.dart' as StatusModel;
import '../utils.dart';
import 'dart:html';
import 'dart:html' as html;


class Users_Screen extends StatefulWidget {
  const Users_Screen({super.key});

  @override
  State<Users_Screen> createState() => _Users_ScreenState();
}
const List<String> StateList = <String>[
  "Select State",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chhattisgarh",
  "Goa",
  'Gujarat',
  "Haryana",
  "Himachal Pradesh",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttarakhand",
  " Uttar Pradesh",
  "West Bengal",
];

const List<String> coutryList=<String>[
  'Select Country',
   "Afghanistan",
   "Albania"	,
  	"Algeria"	,
  	"Andorra"	,
  	"Angola"	,
  	"Antigua and Barbuda",
  	"Argentina",
  	"Armenia"	,
  	"Australia",
  	"Austria"	,
    "Azerbaijan",
    "Bahamas",
    "Bahrain"	,
    "Bangladesh",
    "Barbados"	,
    "Belarus"	,
    "Belgium"	,
    'Belize'	,
  	"Bhutan"	,
  	'Bolivia'	,
  	'Bosnia and Herzegovina',
  	'Botswana',
  	'Brazil',
  	'Brunei',
  	'Bulgaria',
    'Burkina Faso',
  	'Burundi',
  	"Côte d'Ivoire",
    'Cabo Verde	',
    'Cambodia',
  	'Cameroon	',
  	'Canada'	,
  	'Central African Republic'	,
  	'Chad'	,
  	'Chile'	,
  	'China'	,
  	'Colombia'	,
  	'Comoros',
  	'Congo (Congo-Brazzaville)	',
  	'Costa Rica	',
  	'Croatia	',
  	'Cuba	',
  	'Cyprus	',
   'Czechia (Czech Republic)',
  	'Democratic Republic of the Congo'	,
  	'Denmark'	,
  	'Djibouti'	,
  	'Dominica'	,
  	'Dominican Republic',
  	'Ecuador',
  	'Egypt'	,
  	'El Salvador',
  	'Equatorial Guinea',
  	'Eritrea	',
  	'Estonia	',
  	'Eswatini (Swaziland)	',
  	'Ethiopia	',
  	'Fiji	',
  	'Finland	',
  	'France	',
  	'Gabon	',
  	'Gambia	',
  	'Georgia'	,
  	'Germany'	,
  	'Ghana'	,
  	'Greece'	,
  	'Grenada'	,
  	'Guatemala'	,
  	'Guinea'	,
  	'Guinea-Bissau',
  	'Guyana'	,
  	'Haiti'	,
  	'Holy See	',
  	'Honduras'	,
  	'Hungary'	,
  	'Iceland'	,
  	'India'	,
  	'Indonesia'	,
  	'Iran'	,
  	'Iraq'	,
  	'Ireland'	,
  	'Israel'	,
  	'Italy'	,
  	'Jamaica'	,
  	'Japan'	,
  	'Jordan'	,
  	'Kazakhstan'	,
  	'Kenya',
  	'Kiribati'	,
  	'Kuwait'	,
  	'Kyrgyzstan'	,
  	'Laos'	,
  	'Latvia'	,
  	'Lebanon'	,
  	'Lesotho'	,
  	'Liberia'	,
  	'Libya'	,
  	'Liechtenstein'	,
  	'Lithuania',
  	'Luxembourg'	,
  	'Madagascar'	,
  	'Malawi'	,
  	'Malaysia'	,
  	'Maldives'	,
  	'Mali'	,
  	'Malta'	,
  	'Marshall Islands	',
  	'Mauritania',
  	'Mauritius',
  	'Mexico',
  	'Micronesia',
  	'Moldova',
  	'Monaco',
  	'Mongolia',
  	'Montenegro',
  	'Morocco'	,
  	'Mozambique',
  	'Myanmar (formerly Burma)',
  	'Namibia',
  	'Nauru'	,
  	'Nepal',
  	'Netherlands',
  	'New Zealand',
  	'Nicaragua',
  	'Niger',
  	'Nigeria',
  	'North Korea',
  	'North Macedonia',
  	'Norway',
  	'Oman',
  	'Pakistan',
  	'Palau',
  	'Palestine State',
  	'Panama',
  	'Papua New Guinea',
  	'Paraguay'	,
  	'Peru'	,
  	'Philippines'	,
  	'Poland'	,
  	'Portugal'	,
  	'Qatar'	,
  	'Romania'	,
  	'Russia'	,
  	'Rwanda'	,
  	'Saint Kitts and Nevis	',
  	'Saint Lucia	',
  	'Saint Vincent and the Grenadines	',
  	'Samoa'	,
  	'San Marino	',
  	'Sao Tome and Principe	',
  	'Saudi Arabia	',
  	'Senegal'	,
  	'Serbia'	,
  	'Seychelles	',
  	'Sierra Leone	',
  	'Singapore',
  	'Slovakia'	,
  	'Slovenia'	,
  	'Solomon Islands	',
  	'Somalia',
  	'South Africa',
  	'South Korea',
  	'South Sudan',
  	'Spain'	,
  	'Sri Lanka'	,
  	'Sudan'	,
  	'Suriname'	,
  	'Sweden'	,
  	'Switzerland'	,
  	'Syria'	,
  	'Tajikistan'	,
  	'Tanzania'	,
  	'Thailand'	,
  	'Timor-Leste'	,
  	'Togo'	,
  	'Tonga'	,
  	'Trinidad and Tobago'	,
  	'Tunisia'	,
  	'Turkey'	,
  	'Turkmenistan'	,
  	'Tuvalu'	,
  	'Uganda'	,
  	'Ukraine'	,
  	'United Arab Emirates',
  	'United Kingdom	',
  	'United States of America	',
  	'Uruguay	',
  	'Uzbekistan	',
  	'Vanuatu	',
  	'Venezuela	',
  	'Vietnam	',
  	'Yemen',
  	'Zambia'	,
  	'Zimbabwe',
];

const List<String> MaritalStatusList=[
  'Marital Status',
    'Yes',
    'No'
];

class _Users_ScreenState extends State<Users_Screen> {

  bool viewUser_details=false;
  GlobalKey floatingKey = LabeledGlobalKey("Floating");
  bool isFloatingOpen = false;
  OverlayEntry ?floating;
  String viewDocid="";
  bool filtervalue=false;
  bool UserEdit=false;

final _formkey=GlobalKey<FormState>();

final RegExp _inputPattern = RegExp(r'^\d{4}\s\d{4}\s\d{4}$');
  File? Url;
  var Uploaddocument;
  var Editimg;
  String imgUrl="";

  GlobalKey popmenukey = GlobalKey();
TextEditingController firstNamecon=TextEditingController();
TextEditingController middleNamecon=TextEditingController();
TextEditingController lastNamecon=TextEditingController();
TextEditingController dateofBirthcon=TextEditingController();
TextEditingController gendercon=TextEditingController();
TextEditingController alterEmailIdcon=TextEditingController();
TextEditingController aadhaarNumbercon=TextEditingController();
TextEditingController phoneNumbercon=TextEditingController();
TextEditingController mobileNumbercon=TextEditingController();
TextEditingController emailIDcon=TextEditingController();
TextEditingController adreesscon=TextEditingController();
TextEditingController citycon=TextEditingController(text:"Select City");
TextEditingController pinCodecon=TextEditingController();
TextEditingController statecon=TextEditingController( text: "Select State");
TextEditingController countrycon=TextEditingController(text:"Select Country");
TextEditingController yearPassedcon=TextEditingController();
TextEditingController subjectStremdcon=TextEditingController();
TextEditingController classcon=TextEditingController();
TextEditingController rollnocon=TextEditingController();
TextEditingController lastvisitcon=TextEditingController();
TextEditingController housecon=TextEditingController();
TextEditingController statusmessagecon=TextEditingController();
TextEditingController educationquvalificationcon=TextEditingController();
TextEditingController additionalquvalificationcon=TextEditingController();
TextEditingController occupationcon=TextEditingController();
TextEditingController designationcon=TextEditingController();
TextEditingController company_concerncon=TextEditingController();
TextEditingController maritalStatuscon=TextEditingController(text:"Marital Status");
TextEditingController spouseNamecon=TextEditingController();
TextEditingController anniversaryDatecon=TextEditingController();
TextEditingController no_of_childreancon=TextEditingController();


  List usereditlist=[
    "View",
    "Edit",
    "Delete",

    // menuItem(
    //     Name: "Edit",
    //   widgets: Icon(Icons.edit)
    // ),
    // menuItem(
    //     Name: "Delete",
    //     widgets: Icon(Icons.delete)
    // ),

  ];



  @override
  Widget build(BuildContext context) {
    final double width=MediaQuery.of(context).size.width;
    final double height=MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    double baseWidth = 1920;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return
      UserEdit!=false?
      FadeInRight(
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1574*fem,
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  horizontal: width/170.75,
                  vertical: height/81.375
                ),
                child: Form(
                  key: _formkey,
                  child: SizedBox(
                    width: 1550*fem,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ///Alumni text
                            SizedBox(height:height/26.04),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Edit Users Details',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 24*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff030229),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:height/26.04),


                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:410,
                                  child: Row(
                                    children: [
                                      Container(
                                        height:100,
                                        width:100,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Color(0xffDDDEEE),
                                            image:
                                            Uploaddocument!=null?
                                            DecorationImage(
                                              fit:BoxFit.cover,
                                              image: MemoryImage(
                                                Uint8List.fromList(
                                                  base64Decode(Uploaddocument!
                                                      .split(',')
                                                      .last),
                                                ),
                                              ),
                                            ):
                                            Editimg!=null?
                                            DecorationImage(
                                                    fit:BoxFit.cover,
                                                image: NetworkImage(Editimg)):
                                            DecorationImage(
                                                    fit:BoxFit.cover,
                                                image: AssetImage(Constants().avator))
                                        ),

                                      ),
                                      SizedBox(width:15),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text:  "Upload Student Photo (150px X 150px)",
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 17*ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          SizedBox(height:5),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  addImage(size);
                                                },
                                                child: Container(
                                                  height:30,
                                                  width:80,
                                                 decoration: BoxDecoration(
                                                   color: Color(0xffDDDEEE),
                                                   border: Border.all(color: Color(0xff000000))
                                                 ),
                                                  child: Center(
                                                    child:
                                                    KText(
                                                      text:  "Choose File",
                                                      style: SafeGoogleFont (
                                                        'Nunito',
                                                        fontSize: 17*ffem,
                                                        fontWeight: FontWeight.w600,
                                                        height: 1.3625*ffem/fem,
                                                        color: Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width:5),
                                              KText(
                                                text:  Uploaddocument==null?"No file chosen":"File is Selected",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 17*ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],

                                      )

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 680,
                                height:250,
                                  child:Column(
                                    children: [

                                      ///first name and last name
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'First Name *',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                  height:35,
                                                    width:190,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xffDDDEEE),
                                                    borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  child:TextFormField(
                                                    controller:firstNamecon,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                                    ],
                                                    maxLength: 45,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      counterText: "",
                                                    ),
                                                    validator: (value){
                                                      if( value!.isEmpty){
                                                        return 'Field is required';
                                                      }
                                                      
                                                    },
                                                    onChanged: (val){
                                                      _formkey.currentState!.validate();
                                                    },
                                                  )
                                                )
                                              ],

                                            ),
                                          ),

                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Middle Name ',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:190,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:middleNamecon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Last Name *',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:190,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:lastNamecon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                                      ],
                                                      maxLength:45,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        counterText: "",
                                                      ),
                                                      validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                      onChanged: (val){
                                                        _formkey.currentState!.validate();
                                                      },
                                                    )
                                                )
                                              ],

                                            ),
                                          ),
                                        ],

                                      ),

                                      SizedBox(height:10),

                                      ///date of birth and

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [

                                          ///d date of birth
                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Date Of Birth *',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:300,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:dateofBirthcon,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                      readOnly: true,
                                                      onTap: () async {
                                                        DateTime? pickedDate = await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime(1950),
                                                            //DateTime.now() - not to allow to choose before today.
                                                            lastDate: DateTime(2100));

                                                        if (pickedDate != null) {
                                                          //pickedDate output format => 2021-03-10 00:00:00.000
                                                          String formattedDate =
                                                          DateFormat('dd/MM/yyyy')
                                                              .format(pickedDate);
                                                          //formatted date output using intl package =>  2021-03-16
                                                          setState(() {
                                                            dateofBirthcon.text = formattedDate; //set output date to TextField value.
                                                          });
                                                        } else {}
                                                        _formkey.currentState!.validate();
                                                      },

                                                    ),

                                                )
                                              ],

                                            ),
                                          ),


                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Gender ',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:300,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:gendercon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                        ],

                                      ),
                                      SizedBox(height:10),


                                      ///adhaaar card and emailid
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [


                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Alternate Email Id ',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:300,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:alterEmailIdcon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z@0-9]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                    )
                                                )
                                              ],

                                            ),
                                          ),


                                          SizedBox(
                                            height:60,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Aadhaar Number ',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:300,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:aadhaarNumbercon,
                                                      maxLength: 14,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.digitsOnly,
                                                        TextInputFormatter.withFunction((oldValue, newValue) {
                                                          final newString = newValue.text;

                                                          if (_inputPattern.hasMatch(newString)) {
                                                            return oldValue;
                                                          }

                                                          var formattedValue =
                                                          newString.replaceAllMapped(RegExp(r'\d{4}'), (match) {
                                                            return '${match.group(0)} ';
                                                          });

                                                          // Remove any trailing space
                                                          if (formattedValue.endsWith(' ')) {
                                                            formattedValue = formattedValue.substring(0, formattedValue.length - 1);
                                                          }

                                                          return TextEditingValue(
                                                            text: formattedValue,
                                                            selection: TextSelection.collapsed(offset: formattedValue.length),
                                                          );
                                                        }),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        counterText: "",
                                                      ),

                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                        ],

                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),


                            ///contact info
                            Row(
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Contact Details',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 25*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:4,right:4,top:4,bottom:4),
                              child: Container(
                                height:1,
                                width: 1065,
                                color: Colors.grey.shade300,),
                            ),
                            SizedBox(height:20),
                            Row(
                              children: [
                                SizedBox(
                                  width:640,
                                  height:220,

                                  child:Padding(
                                    padding:  EdgeInsets.all(6.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ///phone number
                                        SizedBox(
                                          height:60,
                                          child:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Phone Number',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height:6),
                                              Container(
                                                  height:35,
                                                  width:400,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffDDDEEE),
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  child:TextFormField(
                                                    controller:phoneNumbercon,
                                                    maxLength: 10,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                    ],
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                        counterText: ""
                                                    ),
                                                    validator: (value) {
                                                       if(value!.isNotEmpty){
                                                        if(value.length!=10){
                                                          return 'Enter the Phone no correctly';
                                                        }
                                                      }
                                                    },
                                                  )
                                              )
                                            ],

                                          ),
                                        ),
                                        /// mobile number
                                        SizedBox(
                                          height:60,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Mobile Number',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height:6),
                                              Container(
                                                  height:35,
                                                  width:400,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffDDDEEE),
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  child:TextFormField(
                                                    controller:mobileNumbercon,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                    ],
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    validator: (value) {
                                                       if(value!.isNotEmpty){
                                                        if(value.length!=10){
                                                          return 'Enter the Mobile no correctly';
                                                        }
                                                      }
                                                    },
                                                  )
                                              )
                                            ],

                                          ),
                                        ),

                                        /// Email iD
                                        SizedBox(
                                          height:60,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              KText(
                                                text: 'Email ID',
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff000000),
                                                ),
                                              ),
                                              SizedBox(height:6),
                                              Container(
                                                  height:35,
                                                  width:400,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xffDDDEEE),
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  child:TextFormField(
                                                    controller:emailIDcon,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z@0-9]")),
                                                    ],
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  )
                                              )
                                            ],

                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                ),
                                SizedBox(
                                  width: 440,
                                  height:220,

                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Address',
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 20*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        SizedBox(height:6),
                                        Container(
                                            height:180,
                                            width: 430,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDDEEE),
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child:TextFormField(
                                              controller:adreesscon,
                                              maxLines: null,
                                              expands: true,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                                              ],
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),

                                            )
                                        )
                                      ],

                                    ),
                                  ),

                                )
                              ],
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left:5),
                              child: Row(

                                children: [
                                  ///State Dropdown
                                  SizedBox(
                                    height:60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'State *',
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 20*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        SizedBox(height:6),
                                        Container(
                                            height:35,
                                            width:240,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDDEEE),
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField2<String>(
                                                isExpanded: true,
                                                isDense: true,
                                                hint: Text(
                                                  'Select State',
                                                  style: SafeGoogleFont(
                                                      'Nunito',
                                                    fontSize: 20*ffem,
                                                  ),
                                                ),
                                                items: StateList.map((String item) =>
                                                    DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style:  SafeGoogleFont(
                                                      'Nunito',
                                                      fontSize: 20*ffem,
                                                    ),
                                                  ),
                                                ))
                                                    .toList(),
                                                value: statecon.text,
                                                validator: (value) {
                                                    if(value=="Select State"){
                                                      return 'Please Select the State';
                                                    }
                                                  },
                                                onChanged: (String? value) {
                                                  getCity(value.toString());
                                                  setState(() {
                                                    statecon.text = value!;
                                                  });
                                                  _formkey.currentState!.validate();

                                                },
                                                buttonStyleData:  ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                                  height: height/18.9,
                                                  width: width/2.571,
                                                ),
                                                menuItemStyleData:  MenuItemStyleData(
                                                  height: height/18.9,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none
                                                ),
                                              ),
                                            ),
                                        )
                                      ],

                                    ),
                                  ),
                                  SizedBox(width:33),


                                  ///city
                                  SizedBox(
                                    height:60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'City *',
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 20*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        SizedBox(height:6),
                                        Container(
                                            height:35,
                                            width:240,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDDEEE),
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField2<String>(
                                                isExpanded: true,
                                                isDense: true,
                                                hint: Text(
                                                  'Select City',
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                  ),
                                                ),
                                                items: _cities.map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style:  SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 20*ffem,
                                                        ),
                                                      ),
                                                    )).toList(),
                                                value: citycon.text,
                                                validator: (value) {
                                                  if(value=="Select City"){
                                                    return 'Please Select the City';
                                                  }
                                                },
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    citycon.text = value!;
                                                  });
                                                  _formkey.currentState!.validate();
                                                },
                                                buttonStyleData:  ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                                  height: height/18.9,
                                                  width: width/2.571,
                                                ),
                                                menuItemStyleData:  MenuItemStyleData(
                                                  height: height/18.9,
                                                ),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none
                                                ),
                                              ),
                                            ),
                                        )
                                      ],

                                    ),
                                  ),
                                  SizedBox(width:35),

                                  ///Pin Code
                                  SizedBox(
                                    height:60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Pin Code *',
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 20*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        SizedBox(height:6),
                                        Container(
                                            height:35,
                                            width:240,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDDEEE),
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child:TextFormField(
                                              controller:pinCodecon,
                                              maxLength: 9,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                ],
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                  counterText: "",
                                              ),
                                              validator: (value)
                                              {
                                               if(  value!.isEmpty){
                                                 return  'Field is required';
                                               }
                                               else if( value!.isNotEmpty){
                                                 if(  value!.length<6){
                                                   return  'Pin code Minimum 6 Characters';
                                                 }
                                               }
                                              },
                                              onChanged: (val){
                                                _formkey.currentState!.validate();
                                              },
                                            )
                                        )
                                      ],

                                    ),
                                  ),
                                  SizedBox(width:35),


                                  ///Country Dropdown
                                  SizedBox(
                                    height:60,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: 'Country *',
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 20*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                        SizedBox(height:6),
                                        Container(
                                            height:35,
                                            width:240,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffDDDEEE),
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                            child:
                                            DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField2<String>(
                                                isExpanded: true,
                                                isDense: true,
                                                hint: Text(
                                                  'Select Country',
                                                  style: SafeGoogleFont(
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                  ),
                                                ),
                                                items: coutryList.map((String item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style:  SafeGoogleFont(
                                                          'Nunito',
                                                          fontSize: 20*ffem,
                                                        ),
                                                      ),
                                                    ))
                                                    .toList(),
                                                value: countrycon.text,
                                                validator: (value) {
                                                  if(value=="Select Country"){
                                                    return 'Please Select the Country';
                                                  }
                                                },
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    countrycon.text = value!;
                                                  });
                                                  _formkey.currentState!.validate();

                                                },
                                                buttonStyleData:  ButtonStyleData(
                                                  padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                                  height: height/18.9,
                                                  width: width/2.571,
                                                ),
                                                menuItemStyleData:  MenuItemStyleData(
                                                  height: height/18.9,
                                                ),
                                                decoration: InputDecoration(
                                                    border: InputBorder.none
                                                ),
                                              ),
                                            ),
                                        )
                                      ],

                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///alumni details
                            SizedBox(height:20),
                            Row(
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Alumni Details',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 25*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:4,right:4,top:4,bottom:4),
                              child: Container(
                                height:1,
                                width: 1065,
                                color: Colors.grey.shade300,),
                            ),
                            SizedBox(height:20),

                            Row(

                              children: [

                                SizedBox(
                                  height:200,
                                  width:700,

                                  child:
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ///subject stream and containers
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Year Passed *',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:yearPassedcon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                      onChanged: (val){
                                                        _formkey.currentState!.validate();
                                                      },
                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Subject/Stream',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:subjectStremdcon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                     // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                    )
                                                )
                                              ],

                                            ),
                                          ),
                                        ],
                                      ),

                                      ///class anb roll no container

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Class *',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:classcon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                      onChanged: (val){
                                                        _formkey.currentState!.validate();
                                                      },
                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Roll No',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:rollnocon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                    )
                                                )
                                              ],

                                            ),
                                          ),
                                        ],
                                      ),

                                            ///house and last visit container
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'House',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:housecon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                    //  validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                    )
                                                )
                                              ],

                                            ),
                                          ),

                                          SizedBox(
                                            height:60,
                                            child:
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                KText(
                                                  text: 'Your Last Visit',
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 20*ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                                SizedBox(height:6),
                                                Container(
                                                    height:35,
                                                    width:330,
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffDDDEEE),
                                                        borderRadius: BorderRadius.circular(3)
                                                    ),
                                                    child:TextFormField(
                                                      controller:lastvisitcon,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]")),
                                                      ],
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                     // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                    )
                                                )
                                              ],

                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                 
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left:25),
                                  child: SizedBox(
                                    height:200,width:370,

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          KText(
                                            text: 'My Status Message *',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 20*ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          SizedBox(height:6),
                                          Container(
                                              height:170,
                                              width:345,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xffDDDEEE),
                                                  borderRadius: BorderRadius.circular(3)
                                              ),
                                              child:TextFormField(
                                                controller:statusmessagecon,
                                                maxLines: null,
                                                expands: true,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                                ],
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                onChanged: (val){
                                                  _formkey.currentState!.validate();
                                                },
                                              )
                                          )
                                        ],

                                      ),
                                  ),
                                ),
                              ],
                            ),

                              ///alumi edscation aualifications
                              SizedBox(height:20),
                            Row(
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Alumni Qualifications',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 25*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:4,right:4,top:4,bottom:4),
                              child: Container(
                                height:1,
                                width: 1065,
                                color: Colors.grey.shade300,),
                            ),
                            SizedBox(height:20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  KText(
                                    text: 'Educational Qualification',
                                    style: SafeGoogleFont (
                                      'Nunito',
                                      fontSize: 20*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3625*ffem/fem,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                  SizedBox(height:6),
                                  Container(
                                      height:70,
                                      width:510,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffDDDEEE),
                                          borderRadius: BorderRadius.circular(3)
                                      ),
                                      child:TextFormField(
                                        controller:educationquvalificationcon,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                        ],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      )
                                  )
                                ],

                                ),
                                SizedBox(width:50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    KText(
                                      text: 'Additional Qualification',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 20*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                    SizedBox(height:6),
                                    Container(
                                        height:70,
                                        width:510,
                                        decoration: BoxDecoration(
                                            color: const Color(0xffDDDEEE),
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child:TextFormField(
                                          controller:additionalquvalificationcon,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                          ],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        )
                                    )
                                  ],

                                ),

                              ],
                            ),


                            SizedBox(height:20),
                            Row(
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Professional Details',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 25*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:4,right:4,top:4,bottom:4),
                              child: Container(
                                height:1,
                                width: 1065,
                                color: Colors.grey.shade300,),
                            ),
                            SizedBox(height:20),

                            Row(

                              children: [

                                SizedBox(
                                  height:60,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Occupations',
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height:6),
                                      Container(
                                          height:35,
                                          width:330,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffDDDEEE),
                                              borderRadius: BorderRadius.circular(3)
                                          ),
                                          child:TextFormField(
                                            controller:occupationcon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                           // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                          )
                                      )
                                    ],

                                  ),
                                ),
                                SizedBox(width:40),

                                SizedBox(
                                  height:60,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Designation',
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height:6),
                                      Container(
                                          height:35,
                                          width:330,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffDDDEEE),
                                              borderRadius: BorderRadius.circular(3)
                                          ),
                                          child:TextFormField(
                                            controller:designationcon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                          )
                                      )
                                    ],

                                  ),
                                ),
                                SizedBox(width:40),
                                
                                SizedBox(
                                  height:60,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: "Company/Concern's Name",
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height:6),
                                      Container(
                                          height:35,
                                          width:330,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffDDDEEE),
                                              borderRadius: BorderRadius.circular(3)
                                          ),
                                          child:TextFormField(
                                            controller:company_concerncon,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                            ],
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                           // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                          )
                                      )
                                    ],

                                  ),
                                ),
                              ],
                            ),
                              
                              ///Material Status 
                              SizedBox(height:20),
                            Row(
                              children: [
                                SizedBox(width:5),
                                KText(
                                  text: 'Marital Information',
                                  style: SafeGoogleFont (
                                    'Nunito',
                                    fontSize: 25*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.3625*ffem/fem,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:4,right:4,top:4,bottom:4),
                              child: Container(
                                height:1,
                                width: 1065,
                                color: Colors.grey.shade300,),
                            ),
                            SizedBox(height:20),
                               Row(

                              children: [

                                SizedBox(
                                  height:60,
                                  child:
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      KText(
                                        text: 'Are You Married',
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 20*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                      SizedBox(height:6),
                                      Container(
                                          height:35,
                                          width:230,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffDDDEEE),
                                              borderRadius: BorderRadius.circular(3)
                                          ),
                                          child:
                                          DropdownButtonHideUnderline(
                                            child: DropdownButtonFormField2<String>(
                                              isExpanded: true,
                                              isDense: true,
                                              hint: Text(
                                                'Marital Status',
                                                style: SafeGoogleFont(
                                                  'Nunito',
                                                  fontSize: 20*ffem,
                                                ),
                                              ),
                                              items: MaritalStatusList.map((String item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style:  SafeGoogleFont(
                                                        'Nunito',
                                                        fontSize: 20*ffem,
                                                      ),
                                                    ),
                                                  ))
                                                  .toList(),
                                              value: maritalStatuscon.text,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  maritalStatuscon.text = value!;
                                                });
                                              },
                                              buttonStyleData:  ButtonStyleData(
                                                padding: EdgeInsets.symmetric(horizontal: width/22.5),
                                                height: height/18.9,
                                                width: width/2.571,
                                              ),
                                              menuItemStyleData:  MenuItemStyleData(
                                                height: height/18.9,
                                              ),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none
                                              ),
                                            ),
                                          ),
                                      )
                                    ],

                                  ),
                                ),
                                SizedBox(width:40),

                                maritalStatuscon.text=="Yes"?
                                SizedBox(
                                   child:Row(
                                       children:[
                                         SizedBox(
                                           height:60,
                                           child:
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               KText(
                                                 text: 'Spouse Name',
                                                 style: SafeGoogleFont (
                                                   'Nunito',
                                                   fontSize: 20*ffem,
                                                   fontWeight: FontWeight.w700,
                                                   height: 1.3625*ffem/fem,
                                                   color: Color(0xff000000),
                                                 ),
                                               ),
                                               SizedBox(height:6),
                                               Container(
                                                   height:35,
                                                   width:240,
                                                   decoration: BoxDecoration(
                                                       color: const Color(0xffDDDEEE),
                                                       borderRadius: BorderRadius.circular(3)
                                                   ),
                                                   child:TextFormField(
                                                     controller:spouseNamecon,
                                                     inputFormatters: [
                                                       FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                                     ],
                                                     decoration: InputDecoration(
                                                       border: InputBorder.none,
                                                     ),
                                                     //validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                   )
                                               )
                                             ],

                                           ),
                                         ),
                                         SizedBox(width:40),

                                         SizedBox(
                                           height:60,
                                           child:
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               KText(
                                                 text: "Anniversary Date ",
                                                 style: SafeGoogleFont (
                                                   'Nunito',
                                                   fontSize: 20*ffem,
                                                   fontWeight: FontWeight.w700,
                                                   height: 1.3625*ffem/fem,
                                                   color: Color(0xff000000),
                                                 ),
                                               ),
                                               SizedBox(height:6),
                                               Container(
                                                   height:35,
                                                   width:240,
                                                   decoration: BoxDecoration(
                                                       color: const Color(0xffDDDEEE),
                                                       borderRadius: BorderRadius.circular(3)
                                                   ),
                                                   child:TextFormField(
                                                     readOnly: true,
                                                     controller:anniversaryDatecon,
                                                     decoration: InputDecoration(
                                                       border: InputBorder.none,
                                                     ),
                                                     onTap: () async {
                                                       DateTime? pickedDate = await showDatePicker(
                                                           context: context,
                                                           initialDate: DateTime.now(),
                                                           firstDate: DateTime(1950),
                                                           //DateTime.now() - not to allow to choose before today.
                                                           lastDate: DateTime(2100));

                                                       if (pickedDate != null) {
                                                         //pickedDate output format => 2021-03-10 00:00:00.000
                                                         String formattedDate =
                                                         DateFormat('dd/MM/yyyy')
                                                             .format(pickedDate);
                                                         //formatted date output using intl package =>  2021-03-16
                                                         setState(() {
                                                           anniversaryDatecon.text = formattedDate; //set output date to TextField value.
                                                         });
                                                       } else {}
                                                     },
                                                     // validator: (value) => value!.isEmpty ? 'Field is required' : null,
                                                   )
                                               )
                                             ],

                                           ),
                                         ),

                                         SizedBox(width:40),

                                         SizedBox(
                                           height:60,
                                           child:
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               KText(
                                                 text: "No. Of Chindren",
                                                 style: SafeGoogleFont (
                                                   'Nunito',
                                                   fontSize: 20*ffem,
                                                   fontWeight: FontWeight.w700,
                                                   height: 1.3625*ffem/fem,
                                                   color: Color(0xff000000),
                                                 ),
                                               ),
                                               SizedBox(height:6),
                                               Container(
                                                   height:35,
                                                   width:240,
                                                   decoration: BoxDecoration(
                                                       color: const Color(0xffDDDEEE),
                                                       borderRadius: BorderRadius.circular(3)
                                                   ),
                                                   child:TextFormField(
                                                     controller:no_of_childreancon,
                                                     maxLength: 2,
                                                     inputFormatters: [
                                                       FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                                     ],
                                                     decoration: InputDecoration(
                                                       border: InputBorder.none,
                                                       counterText:"",
                                                     ),
                                                   )
                                               )
                                             ],

                                           ),
                                         ),
                                       ]
                                   )
                               ):SizedBox(),
                              ],
                            ),
                               SizedBox(height:30),
                            
                            ///buttons update reset and back

                             Row(
                               mainAxisAlignment:MainAxisAlignment.end,
                               children: [
                                 SizedBox(width:670,),


                                 ///save button
                                 GestureDetector(
                                     onTap:(){
                                       if(_formkey.currentState!.validate()){}
                                     },
                                   child: Container(
                                       height:40,
                                     width:120,
                                     decoration:BoxDecoration(
                                      color: Color(0xffD60A0B),
                                       borderRadius: BorderRadius.circular(4),
                                     ),
                                       child:Center(
                                           child:KText(
                                             text:'Save',
                                             style: SafeGoogleFont (
                                               'Nunito',
                                               fontSize: 19*ffem,
                                               fontWeight: FontWeight.w400,
                                               height: 1.3625*ffem/fem,
                                               color: Color(0xffFFFFFF),
                                             ),
                                           ),
                                     )
                                   ),
                                 ),
                                 SizedBox(width:20,),

                                 ///Reset Button
                                 GestureDetector(
                                   onTap:(){
                                     controllersclearfunc();
                                   },
                                   child: Container(
                                       height:40,
                                       width:120,
                                       decoration:BoxDecoration(
                                         color: Color(0xff00A0E3),
                                         borderRadius: BorderRadius.circular(4),
                                       ),
                                       child:Center(
                                         child:KText(
                                           text:'Reset',
                                           style: SafeGoogleFont (
                                             'Nunito',
                                             fontSize: 19*ffem,
                                             fontWeight: FontWeight.w400,
                                             height: 1.3625*ffem/fem,
                                             color: Color(0xffFFFFFF),
                                           ),
                                         ),
                                       )
                                   ),
                                 ),
                                 SizedBox(width:20,),


                                 ///back Button
                                 GestureDetector(
                                   onTap:(){
                                     setState((){
                                       UserEdit==false;
                                     });
                                   },
                                   child: Container(
                                       height:40,
                                       width:120,
                                       decoration:BoxDecoration(
                                         color: Colors.green,
                                         borderRadius: BorderRadius.circular(4),
                                       ),
                                       child:Center(
                                         child:KText(
                                           text:'Back',
                                           style: SafeGoogleFont (
                                             'Nunito',
                                             fontSize: 19*ffem,
                                             fontWeight: FontWeight.w400,
                                             height: 1.3625*ffem/fem,
                                             color: Color(0xffFFFFFF),
                                           ),
                                         ),
                                       )
                                   ),
                                 ),

                               ],
                             ),
                            SizedBox(height:30),


                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ):
      FadeInRight(
        child: Container(
          width: 1574*fem,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: width/170.75,
                  vertical: height/81.375
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width:width/1.6457,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        ///Alumni text
                        SizedBox(height:height/26.04),
                        Row(
                          children: [
                            SizedBox(
                              width:width/1.6457,
                              height: 54.96*fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // alumnilistFYu (8:2323)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 775.46*fem, 6.11*fem),
                                    child:
                                    KText(
                                      text: 'Alumni List',
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 24*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      print("Clikeddddddd");

                                    },
                                    child: Container(
                                      // bgmXF (8:2325)
                                      padding: EdgeInsets.fromLTRB(26.07*fem, 17.04*fem, 56.96*fem, 12.72*fem),
                                      height: double.infinity,
                                      decoration: BoxDecoration (
                                        color: Color(0xff605bff),
                                        borderRadius: BorderRadius.circular(10*fem),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // plusUAm (8:2329)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 21.04*fem, 4.32*fem),
                                            width: 13.04*fem,
                                            height: 13.04*fem,
                                            child: Image.asset(
                                              'assets/images/plus.png',
                                              width: 13.04*fem,
                                              height: 13.04*fem,
                                            ),
                                          ),
                                          KText(
                                            // addalumniytD (8:2328)
                                            text:'Add Alumni',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 18*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:height/26.04),
                        ///stream titles text
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 39.11*fem, 19.56*fem),
                              width: 1119.87*fem,
                              height: 55.22*fem,

                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(

                                    width:width/8.0,
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // namekWM (8:2306)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.75*fem, 0*fem),
                                          child: KText(
                                            text:'Name',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 15*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              filtervalue=!filtervalue;
                                            });
                                          },
                                          child: Transform.rotate(
                                            angle:filtervalue?200:0,
                                            child: Opacity(
                                              // arrowdown2TvZ (8:2307)
                                              opacity: 0.7,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                                width: 7.82*fem,
                                                height: 6.52*fem,
                                                child: Image.asset(
                                                  'assets/images/arrow-down-2.png',
                                                  width: 7.82*fem,
                                                  height: 6.52*fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(


                                    width:width/7.5,
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // emailfv9 (8:2312)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.15*fem, 0*fem),
                                          child: KText(
                                            text: 'Email',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 15*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              filtervalue=!filtervalue;
                                            });
                                          },
                                          child: Transform.rotate(
                                            angle:filtervalue?200:0,
                                            child: Opacity(
                                              // arrowdown2TvZ (8:2307)
                                              opacity: 0.7,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                                width: 7.82*fem,
                                                height: 6.52*fem,
                                                child: Image.asset(
                                                  'assets/images/arrow-down-2.png',
                                                  width: 7.82*fem,
                                                  height: 6.52*fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(

                                    width:width/11.1066,
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // phonenumberntH (8:2316)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 18.33*fem, 0*fem),
                                          child: KText(
                                            text: 'Phone number',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 15*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              filtervalue=!filtervalue;
                                            });
                                          },
                                          child: Transform.rotate(
                                            angle:filtervalue?200:0,
                                            child: Opacity(
                                              // arrowdown2TvZ (8:2307)
                                              opacity: 0.7,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                                width: 7.82*fem,
                                                height: 6.52*fem,
                                                child: Image.asset(
                                                  'assets/images/arrow-down-2.png',
                                                  width: 7.82*fem,
                                                  height: 6.52*fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:width/11.2,
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width:width/54.64),
                                        Container(
                                          // gender8qf (8:2320)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.18*fem, 0*fem),
                                          child: KText(
                                            text:'Gender',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 15*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            setState(() {
                                              filtervalue=!filtervalue;
                                            });
                                          },
                                          child: Transform.rotate(
                                            angle:filtervalue?200:0,
                                            child: Opacity(
                                              // arrowdown2TvZ (8:2307)
                                              opacity: 0.7,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                                width: 7.82*fem,
                                                height: 6.52*fem,
                                                child: Image.asset(
                                                  'assets/images/arrow-down-2.png',
                                                  width: 7.82*fem,
                                                  height: 6.52*fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width:width/11.8,
                                    height: double.infinity,

                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(width:width/54.64),
                                        Container(
                                          // gender8qf (8:2320)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.18*fem, 0*fem),
                                          child: KText(
                                            text:'Status',
                                            style: SafeGoogleFont (
                                              'Nunito',
                                              fontSize: 15*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3625*ffem/fem,
                                              color: Color(0xff030229),
                                            ),
                                          ),
                                        ),
                                        Opacity(
                                          // arrowdown5rFs (8:2318)
                                          opacity: 0.0,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                            width: 7.82*fem,
                                            height: 6.52*fem,
                                            child: Image.asset(
                                              'assets/images/arrow-down-5.png',
                                              width: 7.82*fem,
                                              height: 6.52*fem,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width:width/40.32),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:height/65.1),
                        StreamBuilder(
                          stream:
                          FirebaseFirestore.instance.collection("Users").orderBy("Name",descending: filtervalue).snapshots(),
                          builder: (context, snapshot) {

                            if(!snapshot.hasData){
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            if(snapshot.hasData==null){
                              return const Center(child: CircularProgressIndicator(),);
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics:const  NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {

                                var _userdata=snapshot.data!.docs[index];

                                return   Container(
                                  padding: EdgeInsets.fromLTRB(26.07*fem, 19.56*fem, 35.11*fem, 19.56*fem),
                                  width: 1119.87*fem,
                                  height: 78.22*fem,
                                  decoration: BoxDecoration (
                                    color: Color(0xffffffff),
                                    borderRadius: BorderRadius.circular(10*fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width:width/8.0,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                              width: 39.11*fem,
                                              height: double.infinity,
                                              decoration: BoxDecoration (
                                                color: Color(0xfff6d0d0),
                                                borderRadius: BorderRadius.circular(19.5553703308*fem),
                                              ),
                                              child: Center(
                                                // imgFVB (8:2248)
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  height: 39.11*fem,
                                                  child: Container(
                                                    decoration: BoxDecoration (
                                                      borderRadius: BorderRadius.circular(19.5553703308*fem),
                                                      image: DecorationImage (
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage (
                                                            _userdata['UserImg'].toString()
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(

                                              margin: EdgeInsets.fromLTRB(0*fem, 4.14*fem, 129.49*fem, 0*fem),
                                              child: KText(
                                                text: _userdata['Name'],
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 18*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                  color: Color(0xff030229),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        width:width/7.5,
                                        child: KText(
                                          text: _userdata['Email'],
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 18*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff030229),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width:width/11.1066,
                                        child: KText(
                                          text:_userdata['Phone'].toString(),
                                          style: SafeGoogleFont (
                                            'Nunito',
                                            fontSize: 18*ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3625*ffem/fem,
                                            color: Color(0xff030229),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width:width/11.2,

                                        child: Padding(
                                          padding:  EdgeInsets.only(left:width/54.64,right: width/54.64),
                                          child: Container(
                                            width:width/34.15,
                                            height: double.infinity,
                                            decoration: BoxDecoration (
                                              color:_userdata['Gender']=="Male"?
                                              Color(0x195b92ff):
                                              Color(0xffFEF3F0),
                                              borderRadius: BorderRadius.circular(33*fem),
                                            ),
                                            child: Center(
                                              child: KText(
                                                text:   _userdata['Gender'],
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                  color: _userdata['Gender']=="Male"?
                                                  Color(0xff5b92ff):Color(0xffFE8F6B),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width:width/11.8,
                                        child:
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width:width/54.64),
                                            Container(
                                              // gender8qf (8:2320)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 15.18*fem, 0*fem),
                                              child:
                                              KText(
                                                text:   _userdata['verifyed']==true?"Verify":"Not Verify",
                                                style: SafeGoogleFont (
                                                  'Nunito',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.3625*ffem/fem,
                                                ),
                                              ),
                                            ),
                                            Opacity(
                                              // arrowdown5rFs (8:2318)
                                              opacity: 0.0,
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(0*fem, 1.6*fem, 0*fem, 0*fem),
                                                width: 7.82*fem,
                                                height: 6.52*fem,
                                                child: Image.asset(
                                                  'assets/images/arrow-down-5.png',
                                                  width: 7.82*fem,
                                                  height: 6.52*fem,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: (){
                                          // setState(() {
                                          //   viewDocid=_userdata.id;
                                          //   viewUser_details=!viewUser_details;
                                          // });
                                          Popupmenu(context,_userdata.id);
                                          print(viewUser_details);
                                        },
                                        child: Container(
                                          key: popmenukey,
                                          width:width/38.32,
                                          height:height/26.04,
                                          color:Colors.yellow,
                                          child: Container(
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0.65*fem),
                                              width: 18.25*fem,
                                              height: 15.56*fem,
                                              decoration: BoxDecoration(
                                                  color:Color(0xff605bff),
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Center(child: KText(
                                                text:  viewUser_details?"Close":
                                                "View" , style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3625*ffem/fem,
                                                color: Color(0xffFFFFFF),
                                              ),),)
                                            // Image.asset(
                                            //   'assets/images/menu-fRb.png',
                                            //   width: 18.25*fem,
                                            //   height: 4.56*fem,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },);
                          },),
                      ],
                    ),
                  ),
                  viewUser_details==true?
                  SlideInRight(
                    duration: Duration(milliseconds: 500),
                    from:viewUser_details==true? 500:-100,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(31.29*fem, 80.83*fem, 32.59*fem, 412.32*fem),
                      width: 353.71*fem,
                      height: 1163.32*fem,
                      decoration: BoxDecoration (
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(10*fem),
                      ),
                      child:
                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection("Users").doc(viewDocid).get(),
                        builder: (context, snapshot) {

                          if(!snapshot.hasData){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          if(snapshot.hasData==null){
                            return const Center(child: CircularProgressIndicator(),);
                          }

                          var getdata=snapshot.data;

                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 51.65*fem),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // imgbgtZX (8:2072)
                                      margin: EdgeInsets.fromLTRB(99.94*fem, 0*fem, 99.64*fem, 20.91*fem),
                                      width: width/4.5533,
                                      height: 91.26*fem,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF7F7F8),
                                          borderRadius: BorderRadius.circular(100)
                                      ),

                                      child: Image.network(getdata!['UserImg']),
                                    ),
                                    Container(
                                      // prakashdeoP8u (8:2071)
                                      margin: EdgeInsets.fromLTRB(6.02*fem, 0*fem, 0*fem, 8*fem),
                                      child: KText(
                                        text:  getdata['Name'],
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 22*ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff030229),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // uiuxdesignergth (8:2069)
                                      margin: EdgeInsets.fromLTRB(8.02*fem, 0*fem, 0*fem, 47.55*fem),
                                      child: KText(
                                        text:  getdata['Occupation'],
                                        style: SafeGoogleFont (
                                          'Nunito',
                                          fontSize: 14*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3625*ffem/fem,
                                          color: Color(0xff030229),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // linezuP (8:2066)
                                      width: 329.83*fem,
                                      height: 0.5*fem,
                                      child: Image.asset(
                                        'assets/images/line-s1T.png',
                                        width: 329.83*fem,
                                        height: 0.5*fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // contactinfoXuK (8:2109)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 24.77*fem, 68.12*fem),
                                width: 302.46*fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // autogroupndnkSWV (T1gj4sRR27hYZoCNm3ndnK)
                                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 26.07*fem),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // contactinfomYm (8:2134)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 40.18*fem),
                                            child: KText(
                                              text: 'Contact Info',
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 18*ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 1.3625*ffem/fem,
                                                color: Color(0xff030229),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 302.46*fem,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Opacity(
                                                  // messagezwK (8:2129)
                                                  opacity: 0.3,
                                                  child: Container(
                                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                                    width: 20.86*fem,
                                                    height: 19.56*fem,
                                                    child: Image.asset(
                                                      'assets/images/message.png',
                                                      width: 20.86*fem,
                                                      height: 19.56*fem,
                                                    ),
                                                  ),
                                                ),
                                                KText(
                                                  text:   getdata['Email'],
                                                  style: SafeGoogleFont (
                                                    'Nunito',
                                                    fontSize: 16*ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3625*ffem/fem,
                                                    color: Color(0xff030229),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(
                                      width: 302.46*fem,
                                      height: 23.47*fem,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Opacity(
                                            // call9r9 (8:2124)
                                            opacity: 0.3,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 14.34*fem, 0*fem),
                                              width: 20.86*fem,
                                              height: 20.86*fem,
                                              child: Image.asset(
                                                'assets/images/call.png',
                                                width: 20.86*fem,
                                                height: 20.86*fem,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // SqF (8:2123)
                                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1.47*fem),
                                            child: KText(
                                              text:  getdata['Phone'],
                                              style: SafeGoogleFont (
                                                'Nunito',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.3625*ffem/fem,
                                                color: Color(0xff030229),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height:height/43.4),

                                    SizedBox(
                                      width: 342.46*fem,
                                      height: 50.68*fem,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Opacity(
                                            // locationUmw (8:2114)
                                            opacity: 0.3,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(0*fem, 5.21*fem, 16.95*fem, 0*fem),
                                              width: 18.25*fem,
                                              height: 22.16*fem,
                                              child: Image.asset(
                                                'assets/images/location.png',
                                                width: 18.25*fem,
                                                height: 22.16*fem,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // textP8D (8:2111)
                                            height: double.infinity,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  // hogcamproadLJM (8:2112)
                                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 6.68*fem),
                                                  child: KText(
                                                    text:   getdata['Address'],
                                                    style: SafeGoogleFont (
                                                      'Nunito',
                                                      fontSize: 16*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.3625*ffem/fem,
                                                      color: Color(0xff030229),
                                                    ),
                                                  ),
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
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  // group649mPf (10:82)
                                  margin: EdgeInsets.fromLTRB(64.43*fem, 0*fem, 64.41*fem, 19*fem),
                                  width: 362.46*fem,
                                  height: 30*fem,
                                  decoration: BoxDecoration (
                                    borderRadius: BorderRadius.circular(22.5*fem),
                                    color: Color(0xff26c0e2),
                                  ),
                                  child:
                                  Center(
                                    child: KText(
                                      text: 'Download Images',
                                      //  textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 16*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              GestureDetector(
                                onTap:(){},
                                child: Container(
                                  // group6502iu (10:85)
                                  margin: EdgeInsets.fromLTRB(50.43*fem, 0*fem, 52.41*fem, 0*fem),
                                  width: double.infinity,
                                  height: 30*fem,
                                  decoration: BoxDecoration (
                                    color: Color(0xffffd56b),
                                    borderRadius: BorderRadius.circular(22.5*fem),
                                  ),
                                  child: Center(
                                    child: KText(
                                      text: 'Download Documents',
                                      //  textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Nunito',
                                        fontSize: 16*ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3625*ffem/fem,
                                        color: Color(0xff030229),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ):
                  SizedBox(
                    width: 353.71*fem,
                    height: 1163.32*fem,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }


///select the city functions----------------------
  List<String> _cities = ["Select City"];

  Future getResponse() async {
    var res = await rootBundle.loadString('packages/country_state_city_picker/lib/assets/country.json');
    return jsonDecode(res);
  }

  Future getCity(state) async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == "🇮🇳    India")
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == state);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        if (!mounted) return;
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          for (var citynames in citiesname) {
            _cities.add(citynames.toString());
          }
        });
      });
    });
    print("Get cityssss");
    print(_cities);
    return _cities;
  }
  
  ///clear controller functions--------------------------------

  controllersclearfunc(){
   setState((){
     firstNamecon.clear();
     middleNamecon.clear();
     lastNamecon.clear();
     dateofBirthcon.clear();
     gendercon.clear();
     alterEmailIdcon.clear();
     aadhaarNumbercon.clear();
     phoneNumbercon.clear();
     mobileNumbercon.clear();
     emailIDcon.clear();
     adreesscon.clear();
     citycon.text="Select City";
     pinCodecon.clear();
     statecon.text="Select State";
     countrycon.text="Select Country";
     yearPassedcon.clear();
     subjectStremdcon.clear();
     classcon.clear();
     rollnocon.clear();
     lastvisitcon.clear();
     housecon.clear();
     statusmessagecon.clear();
     educationquvalificationcon.clear();
     additionalquvalificationcon.clear();
     occupationcon.clear();
     designationcon.clear();
     company_concerncon.clear();
     maritalStatuscon.text="Marital Status";
     spouseNamecon.clear();
     anniversaryDatecon.clear();
     no_of_childreancon.clear();
   });
}

///choose the image fundtions------------------------

  addImage(Size size) {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        setState(() {
          Url=file;
          Uploaddocument=reader.result;
        });

      });
    });
  }



  imageupload() async {
    var snapshot = await FirebaseStorage.instance.ref().child('Images').child("${Url!.name}").putBlob(Url);
    String downloadUrl = await snapshot.ref.getDownloadURL();
      imgUrl=downloadUrl;
  }


  Popupmenu(BuildContext context,_userid) async {
    print("Popupmenu open-----------------------------------------------------------");
    double _width = MediaQuery.of(context).size.width;
    final render = popmenukey.currentContext!.findRenderObject() as RenderBox;
    await showMenu(
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
          render.localToGlobal(Offset.zero).dx,
          render.localToGlobal(Offset.zero).dy + 50,
          double.infinity,
          double.infinity),
      items: usereditlist.map((item) => PopupMenuItem<String>(
        onTap: () async {

          if(item=="View"){
            setState((){
              viewUser_details=!viewUser_details;
              viewDocid=_userid;
            });
          }
          else if(item=="Edit"){
            setState((){
              UserEdit=!UserEdit;
            });
            fetchdate(_userid);
          }
          else if(item=="Delete"){

          }

        },
        value: item,
        child: Text(
          item,
          style:  TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ))
          .toList(),
    );
  }


  fetchdate(id)async{
    var document=await FirebaseFirestore.instance.collection("Users").doc(id).get();
    Map<String,dynamic>?value=document.data();
    setState((){

      firstNamecon.text=value!['Name'];
      adreesscon.text=value['Address'];
      emailIDcon.text=value['Email'];
      gendercon.text=value['Gender'];
      occupationcon.text=value['Occupation'];
      phoneNumbercon.text=value['Phone'];
      Editimg=value['UserImg'];

    });
  }



}

class Location {
  String name;
  String district;
  String region;
  String state;

  Location(this.name, this.district, this.region, this.state);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        json['Name'], json['District'], json['Region'], json['State']);
  }


}


class menuItem{

  Widget? widgets;
  String? Name;
  menuItem({this.widgets, this.Name});

}
