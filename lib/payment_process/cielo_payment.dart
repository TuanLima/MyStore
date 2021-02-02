import 'package:flutter_cielo/flutter_cielo.dart';

const String MERCHANT_ID = "f5a923a7-c5d7-4234-9602-1e7fa9432708";
const String MERCHANT_KEY = "GOPKUNZDQGFYFKFIGBCTWLXESPPAVACWZIMPIBTN";
const MERCHANT_ORDER_ID = "123";

class CieloPayment {
  CreditCard _thisCard;

  static const List<String> brandOptions = [
    "Visa",
    "Master",
    "Amex",
    "Elo",
    "Aura",
    "JCB",
    "Diners",
    "Discover",
    "Hipercard",
    "Hiper"
  ];

  final CieloEcommerce cielo = CieloEcommerce(
      environment: Environment.SANDBOX,
      merchant: Merchant(
        merchantId: MERCHANT_ID,
        merchantKey: MERCHANT_KEY,
      ));

  Future<Sale> payByCreditCardNumber(
    int paymentAmountInCents,
    String customerName,
    CreditCard creditCard, [
    String merchandOrderId = MERCHANT_ORDER_ID,
    int numberOfInstallments = 1,
    String softDescriptor,
  ]) async {
    print("Iniciando pagamento....");
    Sale sale = Sale(
        merchantOrderId: MERCHANT_ORDER_ID,
        customer: Customer(name: customerName),
        payment: Payment(
            type: TypePayment.creditCard,
            amount: paymentAmountInCents,
            installments: numberOfInstallments, //numero de parcelas
            softDescriptor: softDescriptor,
            creditCard: creditCard ?? _thisCard));

    Sale response;
    try {
      response = await cielo.createSale(sale);
    } on CieloException catch (e) {
      print(e.message);
      print(e.errors[0].message);
      print(e.errors[0].code);
    }
    return response;
  }

  Future<CreditCard> tokenizeCreditCard(CreditCard creditCard) async {
    print("Tokenizando cartão....");
    CreditCard response;
    try {
      response =
          await cielo.tokenizeCard(creditCard); //?? _myCreditCard); //FIX
    } on CieloException catch (e) {
      print(e.message);
      print(e.errors[0].message);
      print(e.errors[0].code);
    }
    return response;
  }
}
