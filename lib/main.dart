import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{  
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'Calculator App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage
      (
        title: 'Calculator App'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget 
{
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> 
{
  String output = "0";
  double temp;
  String _output =  "0";
  double no1 = 0.0;
  double no2 = 0.0;
  String operand = "";
  bool flag = true;
  
  buttonPressed(String buttonText)
  {
    if(buttonText == "CLR")
    {
      _output =  "0";
      no1 = 0.0;
      no2 = 0.0;
      operand = "";
    }
    else if(buttonText == "<=")
    {
      temp = double.parse(_output);
      if(temp<0){
        temp = -temp;
        flag = false;
      }
      if(temp>0)
      {
        if(temp.toString() == temp.toInt().toDouble().toString())
        {
          temp = temp/10;
          _output = temp.toInt().toString();
        }
        else
        {
          double calc = double.parse
          (
            (double.parse(temp.toStringAsFixed(2))-double.parse(temp.toStringAsFixed(2)).toInt()).toStringAsFixed(2)
          );
          calc *= 10;
          double calctemp = calc.floor().toDouble();
          if(calctemp == calc)
            calc = 0;
          else
            calc = calctemp/10;
          temp = temp.floor().toDouble() + calc;
          if(!flag)
            temp = -temp;
          _output = temp.toString();
        }
      }
      else
      {
        _output = "0";
      }
    }
    else if(buttonText == "=>")
    {
      flag = true;
      temp = double.parse(_output);
      if(temp!=0)
      {
        if(temp<0)
        {
          temp = -temp;
          flag = false;
        }
        temp = log(temp)/ln10;
        temp = temp.floor().toDouble();
        temp = pow(10,temp);
        temp = double.parse(_output)%temp;
        if(temp.toString() == temp.toInt().toDouble().toString())
        {
          if(!flag)
            temp = -temp;
          _output = temp.toInt().toString();
        }
        else
        {
          if(!flag)
            temp = -temp;
          _output = temp.toString();
        }
      }
      else
        _output = "0";
    }
    else if(buttonText=="+" || buttonText=="-" || buttonText=="x" || buttonText=="/" || buttonText=="%")
    {
      no1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    }
    else if(buttonText==".")
    {
      if(_output.contains("."))
      {
        print("Already contains a decimal");
        return;
      }
      else
      {
        _output = _output + buttonText;
      }
    }
    else if(buttonText == "=")
    {
        no2 = double.parse(output);

        if(operand == "+")
        {
          _output = (no1+no2).toString();
        }

        if(operand == "-")
        {
          _output = (no1-no2).toString();
        }
        if(operand == "x")
        {
          _output = (no1*no2).toString();
        }
        if(operand == "/")
        {
          if(no2 == 0.0)
          {
            _output = "Infinite";
          }
          else if(no1 == 0.0 && no2 == 0.0)
          {
            _output = "Nan";
          }
          else
          {
          _output = (no1/no2).toString();
          }
        }
        if(operand == "%")
        {
          _output = ((no1*(no2/100))).toString();
        }
        no1 = 0.0;
        no2 = 0.0;
        operand = "";
    }
    else
    {
      _output = _output + buttonText;
    }
    print(_output);
    setState(() 
    {
      output = double.parse(_output).toStringAsFixed(2);
    });

  }
  Widget buildButton(String buttonText)
  {
    return Expanded
    (
      child: OutlineButton 
      (
        padding: EdgeInsets.all(30.0),
        shape: RoundedRectangleBorder
        (
          side: BorderSide
          (
            color: Colors.black,
            
          ),
        ),
        disabledBorderColor: Colors.white,
        splashColor: Colors.grey,
        child: Text
        (
          buttonText,
          style: TextStyle
          (
            color: Colors.blue, fontWeight: FontWeight.bold
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }
  @override
  Widget build(BuildContext context) 
  { 
    return Scaffold
    (
      appBar: AppBar
      (   
        title: Text(widget.title),
      ),
      body: Container
      (
        child: new Column
        (
          children: <Widget>
          [
            Container
            (
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric
              (
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text
              (
                output,
                style: TextStyle
                (
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
            ),
            Expanded
            (
              child: Divider()
            ),
            Column
            (
              children: <Widget>
              [
                Row
                (
                  children: <Widget>
                  [
                    buildButton("CLR"),
                    buildButton("=>"),
                    buildButton("<="),
                    buildButton("="),
                  ],
                ),
                Row
                (
                  children: <Widget>
                  [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/"),
                  ],
                ),
                Row
                (
                  children: <Widget>
                  [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("x"),
                  ],
                ),
                Row
                (
                  children: <Widget>
                  [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row
                (
                  children: <Widget>
                  [
                    buildButton("0"),
                    buildButton("."),
                    buildButton("%"),
                    buildButton("+"),
                  ],
                ),
              ],
            ),
          ]
        ),
      ),
       
    );
  }
}
