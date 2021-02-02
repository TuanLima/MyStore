import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/paymentpage/payment_success.dart';
import 'package:mystore/widgets/profile_tile.dart';

import 'package:flutter_cielo/flutter_cielo.dart';
import 'package:mystore/payment_process/cielo_payment.dart';

const CUSTOMER_NAME = "Comprador crédito simples";
const String HOLDER = "Teste Holder";

class CreditCardPage extends StatefulWidget {
  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  final CieloPayment transaction = CieloPayment();
  //final Sale result;

  User user = FirebaseAuth.instance.currentUser;

  String _fontFamily = GoogleFonts.lato().fontFamily;

  BuildContext _context;

  String _selected_value;

  MaskedTextController ccMask =
      MaskedTextController(mask: "0000 0000 0000 0000");
  MaskedTextController expMask = MaskedTextController(mask: "00/0000");
  MaskedTextController cvvMask = MaskedTextController(mask: "000");

  TextEditingController nameController = TextEditingController();

  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              color: Colors.white10,
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 35, 15),
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.back,
                        size: 38,
                      ),
                      onTap: () {
                        Navigator.pop(_context);
                      },
                    ),
                  ),
                  Text(
                    'Cartão de Crédito',
                    style: TextStyle(
                        fontFamily: _fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
            ),
            creditCardWidget(),
            fillEntries()
          ],
        ),
      );

  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Colors.white10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(decoration: BoxDecoration(color: Themes.orange)),
              Opacity(
                opacity: 0.5,
                child: Image.asset(
                  "assets/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  initialData: user.displayName,
                  builder: (context, snapshot) => Text(
                    snapshot.data.length > 0 ? snapshot.data : user.displayName,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                initialData: "**** **** **** ****",
                builder: (context, snapshot) {
                  if (snapshot.data.length > 0) {
                    ccMask.updateText(snapshot.data);
                  }
                  return Text(
                    snapshot.data.length > 0
                        ? snapshot.data
                        : "**** **** **** ****",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<String>(
                    initialData: "MM/AA",
                    builder: (context, snapshot) {
                      if (snapshot.data.length > 0) {
                        expMask.updateText(snapshot.data);
                      }
                      return ProfileTile(
                        textColor: Colors.black,
                        title: "Vencimento",
                        subtitle:
                            snapshot.data.length > 0 ? snapshot.data : "MM/YY",
                      );
                    }),
                SizedBox(
                  width: 30.0,
                ),
                StreamBuilder<String>(
                    initialData: "***",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.black,
                          title: "CVV",
                          subtitle:
                              snapshot.data.length > 0 ? snapshot.data : "***",
                        )),
              ],
            ),
          ],
        ),
      );

  Widget fillEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: ccMask,
              keyboardType: TextInputType.text,
              maxLength: 19,
              style:
                  TextStyle(fontFamily: _fontFamily, color: Themes.darkerBrown),
              decoration: InputDecoration(
                  labelText: "Número do Cartão",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: expMask,
              keyboardType: TextInputType.text,
              maxLength: 7,
              style:
                  TextStyle(fontFamily: _fontFamily, color: Themes.darkerBrown),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "MM/AA",
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: cvvMask,
              keyboardType: TextInputType.text,
              maxLength: 3,
              style:
                  TextStyle(fontFamily: _fontFamily, color: Themes.darkerBrown),
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelText: "CVV",
                  border: OutlineInputBorder()),
            ),
            DropdownButtonFormField(
              value: _selected_value,
              items: CieloPayment.brandOptions
                  .map<DropdownMenuItem<String>>((item) =>
                      DropdownMenuItem<String>(child: Text(item), value: item))
                  .toList(),
              hint: Text(
                'Selecione a Bandeira do Cartão',
                style: TextStyle(
                    color: Themes.darkerBrown, fontFamily: _fontFamily),
              ),
              onChanged: (value) {
                setState(() {
                  _selected_value = value;
                });
              },
              onSaved: (value) {
                setState(() {
                  _selected_value = value;
                });
              },
            ),
          ],
        ),
      );

  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
        ),
        child: FloatingActionButton.extended(
          onPressed: () async {
            var sale;

            final CreditCard creditCard = CreditCard(
                cardNumber: ccMask.value.text.replaceAll(RegExp(r"\b"), ""),
                holder: HOLDER,
                expirationDate: expMask.value.text, //convert,
                securityCode: cvvMask.value.text,
                brand: _selected_value);

            print(creditCard.cardNumber);
            print(creditCard.holder);
            print(creditCard.expirationDate);
            print(creditCard.securityCode);
            print(creditCard.brand);

            try {
              sale = await pay(creditCard);
            } catch (e) {
              print('Payment did not succeed');
            }
            if (sale != null) {
              Navigator.of(_context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => PaymentSuccessPage(sale)));
            } else {
              ScaffoldMessenger.of(_context).showSnackBar(SnackBar(
                  content: Text('Payment did not succeed. Please try again.'),
                  duration: Duration(seconds: 2)));
            }
          },
          backgroundColor: Themes.orange,
          icon: Icon(
            FontAwesomeIcons.amazonPay,
            color: Colors.black,
          ),
          label: Text(
            "Efetuar Pagamento",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: bodyData(),
      floatingActionButton: floatingBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<Sale> pay(CreditCard creditCard) async {
    Sale result;
    try {
      result = await transaction.payByCreditCardNumber(
          100, CUSTOMER_NAME, creditCard);
    } catch (e) {
      print(e);
    }
    return result;
  }
}
