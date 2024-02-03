import 'package:covid19trackerapp/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid19trackerapp/Model/WorldStatesModel.dart';
import 'package:covid19trackerapp/View/countries_list.dart';


class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 13), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: statesServices.fecthWorldStatesRecords(),

                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      size: 30.0,
                      controller: _controller,
                    ),
                  );
                }else{
                 return Column(
                   children: [
                     PieChart(
                       dataMap: {
                         "Total": 22,
                         // double.parse(snapshot.data!cases!.toString()),
                         "Recovered": 22,
                         "Deaths": 22,
                       },
                       chartValuesOptions: const  ChartValuesOptions(
                         showChartValuesInPercentage: true,
                       ),
                       chartRadius: MediaQuery.of(context).size.width / 3.2,
                       legendOptions:
                       LegendOptions(legendPosition: LegendPosition.left),
                       animationDuration: Duration(milliseconds: 1200),
                       chartType: ChartType.ring,
                       colorList: colorList,
                     ),
                     Padding(
                       padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                       child: Card(
                         child: Column(
                           children: [
                             ReusableRow(title: 'Total', value: '200'),
                             // value:snapshot.data.cases.toString()
                             ReusableRow(title: 'Deaths', value: '200'),
                             ReusableRow(title: 'Recovered', value: '200'),
                           ],
                         ),
                       ),
                     ),
                     GestureDetector(
                       onTap:(){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                    },
                       child: Container(
                         height: 30,
                         decoration:  BoxDecoration(
                             color: Color(0xff1aa260),
                             borderRadius: BorderRadius.circular(10)
                         ),
                         child: const Center(
                           child: Text('Track Countries'),
                         ),
                       ),
                     )
                   ],
                 );
                }
              }),

            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title,value;
   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 4,),
          Divider()
        ],
      ),
    );
  }
}

