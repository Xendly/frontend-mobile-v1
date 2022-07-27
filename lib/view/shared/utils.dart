Map<String, String> currencies = {
  'NGN': 'Nigerian Naira',
  'USD': 'United States Dollar',
};

String getCurrency(String currencyCode) {
  if (currencies.containsKey(currencyCode)) {
    return currencies[currencyCode]!;
  } else {
    return "#";
  }
}
