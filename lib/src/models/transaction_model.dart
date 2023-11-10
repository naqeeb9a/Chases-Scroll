class TransactionHistory {
  String? id;
  String? userID;
  List<int>? timestamp;
  String? description;
  String? currency;
  String? gatewayReferenceID;
  int? payableAmount;
  int? totalAmount;
  String? status;
  String? purpose;
  String? transactionGateway;
  dynamic linkedOrderCode;

  TransactionHistory({
    this.id,
    this.userID,
    this.timestamp,
    this.description,
    this.currency,
    this.gatewayReferenceID,
    this.payableAmount,
    this.totalAmount,
    this.status,
    this.purpose,
    this.transactionGateway,
    this.linkedOrderCode,
  });

  TransactionHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    userID = json['userID'] ?? "";
    timestamp = json['timestamp'] != null ? [json['timestamp']] : null;
    description = json['description'] ?? "";
    currency = json['currency'] ?? "";
    gatewayReferenceID = json['gatewayReferenceID'] ?? "";
    payableAmount = json['payableAmount'] ?? 0;
    totalAmount = json['totalAmount'] ?? 0;
    status = json['status'] ?? "";
    purpose = json['purpose'] ?? "";
    transactionGateway = json['transactionGateway'] ?? "";
    linkedOrderCode = json['linkedOrderCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userID'] = userID;
    data['timestamp'] = timestamp;
    data['description'] = description;
    data['currency'] = currency;
    data['gatewayReferenceID'] = gatewayReferenceID;
    data['payableAmount'] = payableAmount;
    data['totalAmount'] = totalAmount;
    data['status'] = status;
    data['purpose'] = purpose;
    data['transactionGateway'] = transactionGateway;
    data['linkedOrderCode'] = linkedOrderCode;
    return data;
  }

  @override
  String toString() {
    return 'TransactionHistory{'
        'id: $id, '
        'userID: $userID, '
        'timestamp: $timestamp, '
        'description: $description, '
        'currency: $currency, '
        'gatewayReferenceID: $gatewayReferenceID, '
        'payableAmount: $payableAmount, '
        'totalAmount: $totalAmount, '
        'status: $status, '
        'purpose: $purpose, '
        'transactionGateway: $transactionGateway, '
        'linkedOrderCode: $linkedOrderCode'
        '}';
  }
}

class WalletHistory {
  List<int>? timestamp;
  String? title;
  String? currency;
  int? value;

  WalletHistory({this.timestamp, this.title, this.currency, this.value});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'] != null ? [json['timestamp']] : null;
    title = json['title'];
    currency = json['currency'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['title'] = title;
    data['currency'] = currency;
    data['value'] = value;
    return data;
  }

  @override
  String toString() {
    return 'WalletHistory(timestamp: $timestamp, title: $title, currency: $currency, value: $value)';
  }
}
