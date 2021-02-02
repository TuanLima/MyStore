import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mystore/const/themeColor.dart';
import 'package:mystore/location/map.dart';
import './debit_card.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(1, 10, 10, 15),
                    child: GestureDetector(
                      child: Icon(
                        CupertinoIcons.back,
                        size: 45,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Text(
                    'Forma de Pagamento',
                    style: TextStyle(
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Themes.darkerBrown,
                        fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                  color: Themes.orange,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Themes.color)]),
              width: 333.0,
              child: Align(
                alignment: Alignment.center,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.local_atm,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 60.0,
                      ),
                      Text(
                        'Pagar na Entrega',
                        style: TextStyle(
                            color: Themes.darkerBrown,
                            fontSize: 20.0,
                            fontFamily: GoogleFonts.lato().fontFamily),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Location()));
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  color: Themes.orange,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [BoxShadow(blurRadius: 2, color: Themes.color)]),
              width: 333.0,
              child: Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.amazonPay,
                        color: Themes.darkerBrown,
                      ),
                      SizedBox(
                        width: 25.0,
                      ),
                      Text(
                        'Pagar com Cartão de Crédito',
                        style: TextStyle(
                            color: Themes.darkerBrown,
                            fontSize: 20.0,
                            fontFamily: GoogleFonts.lato().fontFamily),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => CreditCardPage()));
                  },
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://mercadoeconsumo.com.br/wp-content/uploads/2020/06/Delivery-Center-fecha-parceria-com-B2W-para-acelerar-transforma%C3%A7%C3%A3o-de-lojistas.jpg'))),
            ),
          ],
        ),
      ),
    );
  }
}
