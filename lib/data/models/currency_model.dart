class CurrencyModel {
  final String base;
  final double amount;
  final Map<String, double> result; // Keys: e.g., "EUR", "rate"
  final int ms;
  final String? updated; // Optional field

  CurrencyModel({
    required this.base,
    required this.amount,
    required this.result,
    required this.ms,
    this.updated,
  });

  // Factory method to parse JSON
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      base: json['base'] as String,
      amount: (json['amount'] as num).toDouble(),
      result: (json['result'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, (value as num).toDouble()),
      ),
      ms: json['ms'] as int,
      updated: json['updated'] as String?,
    );
  }

  // Convert to JSON (optional, for sending data back)
  Map<String, dynamic> toJson() => {
    'base': base,
    'amount': amount,
    'result': result,
    'ms': ms,
    if (updated != null) 'updated': updated,
  };
}