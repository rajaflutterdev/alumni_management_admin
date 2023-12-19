
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';



class Alldepartment extends StatefulWidget {
  List? derpartMentList;
   Alldepartment({this.derpartMentList});

  @override
  State<Alldepartment> createState() => _AlldepartmentState();
}

class _AlldepartmentState extends State<Alldepartment> {

  int touchedIndex= 1;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        SizedBox(
          width: width/5.253846153846154,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse
                        .touchedSection!.touchedSectionIndex;
                  });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              ListView.builder(
                shrinkWrap: true,
                itemCount:widget.derpartMentList!.length,
                itemBuilder: (context, index) {
                return  Indicator(
                  color: Color(0xff53B175),
                  text: widget.derpartMentList![index].toString(),
                  isSquare: true,
                );
              },),


            ],
          ),
        ),

      ],
    );
  }





  List<PieChartSectionData> showingSections() {
    return List.generate(widget.derpartMentList!.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 16.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [
        Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {

        case 0:
          return PieChartSectionData(
            color: Color(0xff53B175),
            value: 0.5,
            title: '${(00).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red,
            value: (0.5),
            title: '${(0.5).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        case 2:
          return PieChartSectionData(
            color: Color(0xffe8ce0c),
            value: (0.6),
            title: '${(0 *100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle:  GoogleFonts.poppins(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.mainTextColor1,

            ),
          );
        default:
          throw Error();
      }
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
        Text(
          text,
          style: TextStyle(
            fontSize: width/85.375,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}