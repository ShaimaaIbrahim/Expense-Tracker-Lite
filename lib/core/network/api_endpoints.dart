import '../constants/api_constants.dart';

class ApiEndpoints {
  //https://api.exchangerate.host/convert?access_key=ff807dbc0fd639a921976a44aa4085f1&from=USD&to=GBP&amount=10
  //curl "https://api.fastforex.io/convert?from=USD&to=EUR&amount=100&api_key=YOUR_API_KEY"
  static const String baseUrl = 'https://api.fastforex.io';

  // CurrencyExchange endpoints
  static const String currencyExchange = '/convert?';
}