import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:despesas_androidx/components/GradientAppBar.dart';
import 'package:despesas_androidx/utils/Theme.dart' as theme;
import 'package:despesas_androidx/utils/Route.dart';
import 'package:despesas_androidx/models/ExpenseMonth.dart';
import 'package:despesas_androidx/models/Expense.dart';
import 'package:intl/intl.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      new ExpenseMonth('Nov', 28, theme.primaryColor),
      new ExpenseMonth('Dez', 15, theme.primaryColor),
      new ExpenseMonth('Jan', 12, theme.primaryColor),
      new ExpenseMonth('Fev', 42, theme.primaryColor),
      new ExpenseMonth('Mar', _counter, theme.primaryColor),
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
        // renderSpec: new charts.NoneRenderSpec(),
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
        width: MediaQuery.of(context).size.width * 0.88,
        child: chart,
      ),
    );

    var makeCardCharts = Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            chartWidget,
            Padding(
              padding: EdgeInsets.only(left: 12, top: 15),
              child: Text(
                'R\$ 1.203,43',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, bottom: 5),
              child: Text('Seu dinheiro está indo embora.'),
            ),
          ],
        ),
      ),
    );

    ListTile makeListExpense(Expense expense) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        isThreeLine: false,
        selected: true,
        leading: Container(
          padding: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 1,
                color: Colors.black45,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Icon(
              expense.icon,
              color: Colors.black45,
            ),
          ),
        ),
        title: Text(
          expense.title,
          style: TextStyle(color: Colors.black87),
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          expense.subtitle,
          style: TextStyle(
            color: Colors.black45,
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
                    color: Colors.black45,
                    fontStyle: FontStyle.italic,
                    fontSize: 12),
              ),
            ),
            Text(
              '${_fNumber.format(expense.value)}',
              style: TextStyle(
                color: Colors.black54,
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
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  makeListExpense(expenses[index]),
                  Divider(
                    color: Colors.black26,
                  )
                ],
              )),
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
      'Pare de comer tanto assim', 45.00, DateTime.now()),
  Expense(Icons.directions_bus, 'Bilhete semanal de viagem',
      'Você poderia ir andando', 39.90, DateTime.now()),
  Expense(Icons.local_gas_station, 'Combustível', 'Dá para ir empurrando',
      90.00, DateTime.now()),
  Expense(Icons.local_movies, 'Filme do Shazam!',
      'Tem gasto que não da para evitar', 45.00, DateTime.now()),
  Expense(Icons.videogame_asset, 'Resident Evil 2', 'Vale apena cada centavo',
      155.00, DateTime.now()),
];

// Colors.blueGrey
// Colors.black87
// Colors.red
// Colors.blue
// Color(0xff996BF5)
