class Employee {
  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;

  Employee(
      {
        required this.clientName,
        required this.clientGovernorate,
        required this.clientAddress,
        required this.clientNumber,
      });
}

class TableCheck {
  final String clientName;
  final String orderDate;
  final String productUnits;
  final String totalPriceProducts;

  TableCheck(
      {
        required this.clientName,
        required this.orderDate,
        required this.productUnits,
        required this.totalPriceProducts,
      });
}

class TableThrowback {
  final String clientName;
  final String clientGovernorate;
  final String clientAddress;
  final String clientNumber;

  TableThrowback(
      {
        required this.clientName,
        required this.clientGovernorate,
        required this.clientAddress,
        required this.clientNumber,
      });
}