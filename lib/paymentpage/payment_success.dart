import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cielo/flutter_cielo.dart';
import 'package:mystore/bloc/cartListBloc.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/location/map.dart';
import 'package:mystore/model/fooditem.dart';
import '../widgets/profile_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class PaymentSuccessPage extends StatefulWidget {
  final Sale sale;
  PaymentSuccessPage(this.sale);

  @override
  PaymentSuccessPageState createState() {
    return new PaymentSuccessPageState(sale);
  }
}

class PaymentSuccessPageState extends State<PaymentSuccessPage> {
  Sale sale;
  bool isDataAvailable = true;

  PaymentSuccessPageState(this.sale);

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    showSuccessDialog();
  }

  Widget bodyData() => Center(
        child: isDataAvailable
            ? RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/homepage');
                },
                color: Themes.orange,
                child: Text("Volta à Loja"),
              )
            : CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyData(),
    );
  }

  void showSuccessDialog() {
    setState(() {
      isDataAvailable = false;
      Future.delayed(Duration(seconds: 3)).then((_) => goToDialog());
    });
  }

  goToDialog() {
    setState(() {
      isDataAvailable = true;
    });
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      stream: bloc.listStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return successTicket(snapshot.data);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  SizedBox(
                    height: 10.0,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget successTicket(List<FoodItem> list) {
    double totalAmount = 0;
    String cardNumber = sale.payment.creditCard.cardNumber;
    String lastTwoCharacters = cardNumber.substring(cardNumber.length - 2);

    for (var foodItem in list) {
      totalAmount += foodItem.price;
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ProfileTile(
                title: "Obrigado!",
                textColor: Colors.black,
                subtitle:
                    "Transação bem sucedida. A sua ID de pagamento é: ${sale.payment.paymentId}",
              ),
              ListTile(
                title: Text("Data"),
                subtitle: Text(" "),
                trailing: Text("${DateTime.now().toString().substring(0, 19)}"),
              ),
              ListTile(
                title: Text("${FirebaseAuth.instance.currentUser.displayName}"),
                subtitle: Text("${FirebaseAuth.instance.currentUser.email}"),
                trailing: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      "${FirebaseAuth.instance.currentUser.photoURL}"),
                ),
              ),
              ListTile(
                title: Text("Valor Pago"),
                subtitle: Text('R\$ ' + totalAmount.toStringAsFixed(2)),
                trailing: Text("Concluído"),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 0.0,
                color: Colors.grey.shade300,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.ccVisa,
                    color: Themes.orange,
                  ),
                  title: Text("Cartão de Crédito"),
                  subtitle: Text("PNB Card ending **$lastTwoCharacters"),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  height: 40.0,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Themes.orange,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: Text(
                      "Rastrear seu pedido",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => Location()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
