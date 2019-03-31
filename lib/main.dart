import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:despesas/components/GradientAppBar.dart';
import 'package:despesas/utils/Theme.dart' as theme;
import 'package:despesas/utils/Route.dart';
import 'package:despesas/models/ExpenseMonth.dart';
import 'package:despesas/models/Expense.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Só Despesas :(',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: theme.baseTextStyle.fontFamily,
        backgroundColor: Colors.white,
        primaryColor: theme.primaryColor,
      ),
      onGenerateRoute: (RouteSettings settings) => Routes.getRoute(settings),
      home: MyHomePage(title: 'Só Despesas :('),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _fNumber = NumberFormat.compactCurrency(
        locale: 'pt-Br', symbol: 'R\$', decimalDigits: 2);

    var data = [
      new ExpenseMonth('Nov', 28, Color(0xff996BF5)),
      new ExpenseMonth('Dez', 15, Color(0xff996BF5)),
      new ExpenseMonth('Jan', 12, Color(0xff996BF5)),
      new ExpenseMonth('Fev', 42, Color(0xff996BF5)),
      new ExpenseMonth('Mar', _counter, Color(0xff996BF5)),
      new ExpenseMonth('Abr', 25, Colors.grey[200]),
      new ExpenseMonth('Maio', 10, Colors.grey[200]),
      new ExpenseMonth('Jun', 5, Colors.grey[200]),
      new ExpenseMonth('Jul', 15, Colors.grey[200]),
    ];

    var series = [
      new charts.Series(
        id: 'Clicks',
        domainFn: (ExpenseMonth expense, _) => expense.month,
        measureFn: (ExpenseMonth expense, _) => expense.value,
        colorFn: (ExpenseMonth expense, _) => expense.color,
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      primaryMeasureAxis:
          charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
      domainAxis: charts.OrdinalAxisSpec(
        showAxisLine: true,
        renderSpec: new charts.NoneRenderSpec(),
      ),
      layoutConfig: charts.LayoutConfig(
          leftMarginSpec: charts.MarginSpec.fixedPixel(0),
          topMarginSpec: charts.MarginSpec.fixedPixel(0),
          rightMarginSpec: charts.MarginSpec.fixedPixel(0),
          bottomMarginSpec: charts.MarginSpec.fixedPixel(0)),
    );

    var chartWidget = Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.5,
        child: chart,
      ),
    );

    var makeCardCharts = Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                chartWidget,
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'R\$ 1.203,43',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text('Seu dinheiro está indo embora.'),
            ),
          ],
        ),
      ),
    );

    ListTile makeListExpense(Expense expense) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        isThreeLine: false,
        selected: true,
        leading: Container(
          padding: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Icon(
              expense.icon,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          expense.subtitle,
          style: TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
          maxLines: 1,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${DateFormat('dd/MM').format(expense.date)}',
                style: TextStyle(
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontSize: 12),
              ),
            ),
            Text(
              '${_fNumber.format(expense.value)}',
              style: TextStyle(
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      );
    }

    var makeCardExpense = ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Container(
              decoration: BoxDecoration(
                color: expenses[index].color,
              ),
              child: makeListExpense(expenses[index])),
        );
      },
    );

    return Scaffold(
      appBar: GradientAppBar(
        title: Text(
          widget.title,
          style: theme.headerTextStyle,
        ),
        backgroundColorStart: theme.primaryColor,
        backgroundColorEnd: theme.secundaryColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            makeCardCharts,
            Expanded(child: makeCardExpense),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

var expenses = [
  Expense(Icons.fastfood, 'Lanche muito grande e caro',
      'Pare de comer tanto assim', 45.00, DateTime.now(), theme.primaryColor),
  Expense(Icons.directions_bus, 'Bilhete semanal de viagem',
      'Você poderia ir andando', 39.90, DateTime.now(), Colors.black87),
  Expense(Icons.fastfood, 'Lanche muito grande e caro',
      'Pare de comer tanto assim', 45.00, DateTime.now(), theme.primaryColor),
  Expense(Icons.fastfood, 'Lanche muito grande e caro',
      'Pare de comer tanto assim', 45.00, DateTime.now(), Colors.cyan),
];

// Colors.blueGrey
// Colors.black87
// Colors.red
// Colors.blue
// Color(0xff996BF5)
