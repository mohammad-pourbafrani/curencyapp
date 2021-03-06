// ignore_for_file: must_be_immutable

import 'package:arz_online/Model/Currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart' hide TextDirection;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', ''), // farsi or rtl
      ],
      theme: ThemeData(
        fontFamily: 'vazir',
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'vazir',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            fontFamily: 'vazir',
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            fontFamily: 'vazir',
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          headline3: TextStyle(
            fontFamily: 'vazir',
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
          headline4: TextStyle(
            fontFamily: 'vazir',
            fontSize: 14,
            color: Colors.green,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext cntx) async {
    // var url = "http://sasansafari.com/flutter/api.php?access_key=flutter123456";
    var url = "http://sasansafari.com";
    var value = await http.get(Uri.parse(url));

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showSnackBar(cntx, "?????????????????? ???? ???????????? ?????????? ????.");
        List jsonList = convert.jsonDecode(value.body);

        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    developer.log("build", name: 'wlifestyle');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Image.asset('assets/images/icon.png'),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '???????? ???? ?????? ??????',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: Align(
              child: Image.asset('assets/images/menu.png'),
              alignment: Alignment.centerLeft,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/q.png'),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "?????? ?????? ???????? ?????????? ",
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              ' ?????? ?????????? ???? ?????????????? ???????? ?? ???????? ???????????? ?????? ?????????????? ???????? ???????????????? ?????????? ???? ???????????? ?? ?????????????? ???? ?????? ?????????? ?????????????? ?????? ?? ???????? ???? ???? ???? ?????????? ???? ????????????.',
              style: Theme.of(context).textTheme.bodyText1,
              textDirection: TextDirection.rtl,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 130, 130, 130),
                  borderRadius: BorderRadius.all(
                    Radius.circular(1000),
                  ),
                ),
                height: 32,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "?????? ???????? ??????",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "????????",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Text(
                      "??????????",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: listFuterBuilder(context),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                      child: TextButton.icon(
                        onPressed: () {
                          currency.clear();
                          listFuterBuilder(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh_bold,
                          color: Colors.black,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "??????????????????",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 202, 193, 255)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "?????????? ??????????????????${_getTime()}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<dynamic> listFuterBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int postion) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MyItem(postion, currency),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 9 == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Add(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
      future: getResponse(context),
    );
  }

  String _getTime() {
    DateTime now = DateTime.now();
    return DateFormat('kk:mm:ss').format(now);
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Colors.green,
    ),
  );
}

class MyItem extends StatelessWidget {
  int postion;
  List<Currency> currency;
  MyItem(this.postion, this.currency);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.grey,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[postion].title!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            getFarsiNumber(currency[postion].price.toString()),
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            getFarsiNumber(currency[postion].changes.toString()),
            style: currency[postion].status == "n"
                ? Theme.of(context).textTheme.headline3
                : Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 1.0,
            color: Colors.grey,
          )
        ],
        color: Colors.red,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "??????????????",
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}

String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = [
    '??',
    '??',
    '??',
    '??',
    '??',
    '??',
    '??',
    '??',
    '??',
    '??',
  ];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });

  return number;
}
