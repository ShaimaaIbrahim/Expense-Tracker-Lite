import 'package:expense_tracker_lite/data/data_source/remote/currency_conversion_data_source.dart';
import 'package:expense_tracker_lite/domain/repository/currency_repository.dart';

import '../../data/models/currency_model.dart';

class CurrencyRepositoryImp implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  CurrencyRepositoryImp({required this.remoteDataSource});
  
  @override
  Future<CurrencyModel> convertCurrency(String from, String amount) async{
    final model = await remoteDataSource.convertCurrency(from, amount);
    return model;
  }
}