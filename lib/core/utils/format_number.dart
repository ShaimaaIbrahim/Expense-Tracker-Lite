import 'package:intl/intl.dart';

String formatNumber(int amount) {
  String numStr = amount.toString();
  int length = numStr.length;

  if (length <= 3) {
    return numStr;
  }

  String result = '';
  int commaPosition = length % 3; // Where the first comma should be

  for (int i = 0; i < length; i++) {
    if (commaPosition != 0 && i == commaPosition) {
      result += ',';
      commaPosition += 3; // Next comma after 3 more digits
    } else if (i > 0 && (i - commaPosition) % 3 == 0) {
      result += ',';
    }
    result += numStr[i];
  }

  return result;

  return result;
}
