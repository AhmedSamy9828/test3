class Boll {
  final List<List<dynamic>> asd;
  final BollInfo info;

  const Boll({
    required this.asd,
    required this.info,
  });
}

class BollInfo {
  final String moderatorName;
  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;
  final String orderDate;
  final String invoiceNumber;
  final int productUnits;
  final int totalPriceProducts;

  final String factory;
  final String address;
  final String number1;
  final String number2;

  const BollInfo({
    required this.moderatorName,
    required this.clientName,
    required this.clientGovernorate,
    required this.clientAddress,
    required this.clientNumber,
    required this.orderDate,
    required this.invoiceNumber,
    required this.productUnits,
    required this.totalPriceProducts,

    required this.factory,
    required this.address,
    required this.number1,
    required this.number2,
  });
}