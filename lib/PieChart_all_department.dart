
import 'package:alumni_management_admin/Screens/Job_Reports.dart';
import 'package:alumni_management_admin/utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Alldepartment extends StatefulWidget {
  List? derpartMentList;
  List<workingPerson> ?departviseWorkingList;
  int ?TotalAlumniUsers;
  Alldepartment({this.derpartMentList,this.departviseWorkingList,this.TotalAlumniUsers});

  @override
  State<Alldepartment> createState() => _AlldepartmentState();
}

class _AlldepartmentState extends State<Alldepartment> {

  int touchedIndex= -1;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height/2.17,
      width: width/2.483,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(
            width: width/5.253846153846154,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {

                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),

          SizedBox(
            width: width/5.939130434782609,
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:widget.derpartMentList!.length,
                    itemBuilder: (context, index) {
                      return  Indicator(
                        color: colorHexCodes[index],
                        text: widget.derpartMentList![index].toString(),
                        isSquare: true,
                      );
                    },),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

var departmentColor;
var indicatorColor;
   List<String> hexColorCodes = [
    '#FF5733', '#33FF57', '#5733FF', '#FFFF33', '#FFFF36',
  ];

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];
   List colors=[
     Colors.red,
     Colors.blue,
     Colors.green,
     Colors.yellow,
     Colors.orange,
     Colors.purple,
     Colors.pink,
     Colors.brown,
     Colors.grey,
     Colors.cyan,
     Colors.teal,
     Colors.indigo,
     Colors.amber,
     Colors.lime,
     Colors.lightBlue,
     Colors.lightGreen,
     Colors.deepOrange,
     Colors.deepPurple,
     Colors.blueGrey,
     Colors.redAccent,
     Colors.blueAccent,
     Colors.greenAccent,
     Colors.yellowAccent,
   ];

  List colorHexCodes = [
    const Color(0xffFF0000),// red
    const Color(0xff0000FF), // blue
    const Color(0xffFFC200), // amber // green
    const Color(0xffFFA500), // orange
    const Color(0xff800080), // purple
    const Color(0xffFFC0CB).withOpacity(0.7), // pink
    const Color(0xffA52A2A), // brown
    const Color(0xff808080).withOpacity(0.8), // grey
    const Color(0xff008080), // teal
    const Color(0xff4B0082), // indigo
    const Color(0xff00FF00).withOpacity(0.6), // lime
    const Color(0xffADD8E6), // lightBlue
    const Color(0xff90EE90), // lightGreen
    const Color(0xffFF4500), // deepOrange
    const Color(0xff800080), // deepPurple
    const Color(0xff607D8B), // blueGrey
    const Color(0xffFF1744), // redAccent
    const Color(0xff2196F3), // blueAccent
    const Color(0xff4CAF50), // greenAccent
    const Color(0xffFFEB3B), // yellowAccent
  ];


  Color color(int index) {
    Set<Color> usedColors = <Color>{};
    indicatorColor = hexColorCodes[index % hexColorCodes.length];
    Color color = Color(int.parse(indicatorColor.replaceAll("#", "0xFF")));

    while (usedColors.contains(color)) {
      indicatorColor = hexColorCodes[(index + 1) % hexColorCodes.length];
      color = Color(int.parse(indicatorColor.replaceAll("#", "0xFF")));
    }

    usedColors.add(color);
    if (color.computeLuminance() < 0.5) {
      color = color.withOpacity(0.7);
    }
    return color;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.derpartMentList!.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;

      Map<String, int> departmentCountMap = {};
      for (int j = 0; j < widget.departviseWorkingList!.length; j++) {
        if (widget.departviseWorkingList![j].department!.contains(widget.derpartMentList![i])) {
          if (widget.departviseWorkingList![j].workingStatus == "Yes") {
              final currentDepartment = widget.derpartMentList![i];
              departmentCountMap[currentDepartment] = (departmentCountMap[currentDepartment] ?? 0) + 1;
          }
        }
      }

      final department = widget.derpartMentList![i];
      final countForDepartment = departmentCountMap[department] ?? 0;

      // Generate a list of hexadecimal color codes


      // Get the color for the current department
       departmentColor = hexColorCodes[i % hexColorCodes.length];



      return PieChartSectionData(
        color: colorHexCodes[i],
        value: (countForDepartment) / int.parse(widget.TotalAlumniUsers.toString()),
        title: '${((countForDepartment) / int.parse(widget.TotalAlumniUsers.toString()) * 100).toStringAsFixed(2)} %',
        radius: radius,
        titleStyle: SafeGoogleFont('Nunito',
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: AppColors.mainTextColor1,
        ),
      );
    });
  }


}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}



class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: width/341.5,
        ),
        SizedBox(
          width: width/6.5361,
          child: Text(
            text,
            style: SafeGoogleFont('Nunito',
              fontSize: width/85.375,
              fontWeight: FontWeight.bold,
              color: textColor,
              textStyle: const TextStyle(
                overflow: TextOverflow.ellipsis
              )
            ),
          ),
        )
      ],
    );
  }
}