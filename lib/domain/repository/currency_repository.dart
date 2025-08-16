import '../../data/models/currency_model.dart';

abstract class CurrencyRepository {
  Future<CurrencyModel> convertCurrency(String from , String amount);
}