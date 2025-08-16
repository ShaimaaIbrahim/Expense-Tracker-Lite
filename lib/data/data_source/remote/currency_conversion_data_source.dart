import 'package:expense_tracker_lite/data/models/currency_model.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/network_manager.dart';

abstract class CurrencyRemoteDataSource {
  Future<CurrencyModel> convertCurrency(String from , String amount);
}

class CurrencyRemoteDataSourceImp implements CurrencyRemoteDataSource{
  final NetworkManager networkManager;

  CurrencyRemoteDataSourceImp(this.networkManager);
  
  @override
  Future<CurrencyModel> convertCurrency(String from , String amount) async{
    final response = await networkManager.get("${ApiEndpoints.currencyExchange}from=$from&to=USD&amount=$amount&api_key=$accessKey");
    debugPrint("response: $response");
    return  CurrencyModel.fromJson(response);
  }
  
}
