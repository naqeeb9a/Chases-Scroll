import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/escrow_model.dart';
import 'package:chases_scroll/src/models/transaction_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

class WalletRepository {
  //orderID
  static String orderCode =
      locator<LocalStorageService>().getDataFromDisk(AppKeys.orderCode);
  final _storage = locator<LocalStorageService>();
  List<TransactionHistory> getWalletHistory = [];

  //escrow
  List<EscrowModel> inEscrow = [];
  List<EscrowModel> inEscrowFinilized = [];
  List<EscrowModel> inEscrowRefund = [];

  //withdrawl paystack amount
  Future<dynamic> buyEventWithWallet() async {
    String url = "${Endpoints.payWithWallet}?orderCode=$orderCode";
    final response = await ApiClient.postWithoutBody(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("buyEventWithWallet ======>${response.message}");
      return response.message;
    }
    return response.message;
  }

  //get escrow balance USD
  Future<bool> checkAccountStatus() async {
    final response = await ApiClient.get(
      Endpoints.accountStatus,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      // log(allEvents.toString());
      log("checkAccountStatus ======>${response.message}");

      return response.message;
    }
    return response.message;
  }

  //get checkPAyStack Account
  Future<bool> checkPaystackAccount() async {
    final response = await ApiClient.get(
      Endpoints.checkPaystack,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      return response.message;
    }
    return response.message;
  }

  //fundWallet paystack
  Future<Map<String, dynamic>> fundWalletPaystack({
    final int? amount,
  }) async {
    final data = {
      "currency": "NGN",
      "amount": amount,
      "transactionGateway": "PAYSTACK"
    };
    final response = await ApiClient.post(
      Endpoints.fundWallet,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("fundPaystackNGN ======>${response.message}");
      return response.message;
    }
    return response.message;
  }

  //fundWallet paystack
  Future<Map<String, dynamic>> fundWalletStripe({
    final int? amount,
  }) async {
    final data = {
      "currency": "USD",
      "amount": amount,
      "transactionGateway": "STRIPE"
    };
    final response = await ApiClient.post(
      Endpoints.fundWallet,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("fundwalletUSD ======>${response.message}");
      return response.message;
    }
    return response.message;
  }

  //get account status
  Future<bool> getAccountStatus() async {
    final response = await ApiClient.get(
      Endpoints.accountStatus,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      // log(allEvents.toString());
      log("getAccountStatus ======>${response.message}");

      return true;
    }
    return false;
  }

  //get escrow finilized
  Future<List<EscrowModel>> getEscrowRefundCompleted() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=REFUND_COMPLETED";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> getCompletedEscrow = response.message['content'];
      // log(allEvents.toString());
      inEscrowRefund = getCompletedEscrow
          .map<EscrowModel>((post) => EscrowModel.fromJson(post))
          .toList();

      log("getEscrowRefundCompleted ======>${response.message['content']}");

      return inEscrowRefund;
    }
    return [];
  }

  //get escrow inEscrow
  Future<List<EscrowModel>> getInEscrow() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=IN_ESCROW";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> getInEscrow = response.message['content'];
      // log(allEvents.toString());
      inEscrow = getInEscrow
          .map<EscrowModel>((post) => EscrowModel.fromJson(post))
          .toList();

      log("getInEscrow ======>${response.message['content']}");

      return inEscrow;
    }
    return [];
  }

  //get escrow finilized
  Future<List<EscrowModel>> getInFinalized() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=FINALIZED";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> finalizedEscrow = response.message['content'];
      // log(allEvents.toString());
      inEscrowFinilized = finalizedEscrow
          .map<EscrowModel>((post) => EscrowModel.fromJson(post))
          .toList();

      log("getInFinalized ======>${response.message['content']}");

      return inEscrowFinilized;
    }
    return [];
  }

  //get wallet balance naira
  Future<dynamic> getNairaBalance() async {
    String url = "${Endpoints.walletBalances}?currency=NGN";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      // log(allEvents.toString());
      log("getEscrowBalance ======>${response.message}");
      _storage.saveDataToDisk(
          AppKeys.balanceNaira, response.message['walletBalances']['balance']);
      _storage.saveDataToDisk(
          AppKeys.escrowNaira, response.message['escrowBalances']['balance']);

      return response.message;
    }
    return response.message;
  }

  // //fund wallet
  // Future<bool> getTransactionListWallet({
  //   final String? currency,
  //   final int? amount,
  // }) async {
  //   final data = {"currency": currency, "amount": amount};
  //   final response = await ApiClient.put(
  //     Endpoints.fundWallet,
  //     body: data,
  //     useToken: true,
  //   );

  //   if (response.status == 200 || response.status == 201) {
  //     return true;
  //   }
  //   return false;
  // }

  //get escrow balance USD
  Future<dynamic> getUsdBalance() async {
    String url = "${Endpoints.walletBalances}?currency=USD";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      // log(allEvents.toString());
      log("getEscrowBalance ======>${response.message}");
      _storage.saveDataToDisk(
          AppKeys.balanceUSD, response.message['walletBalances']['balance']);
      _storage.saveDataToDisk(
          AppKeys.ecrowUSD, response.message['escrowBalances']['balance']);

      return response.message;
    }
    return response.message;
  }

  //onboard paystack
  Future<bool> onBoardPayStack({
    String? accountNumber,
    String? code,
  }) async {
    final data = {"account_number": accountNumber, "bank_code": code};
    final response = await ApiClient.post(
      Endpoints.onboardPaystack,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("onBoardPayStack ======>${response.message}");
      return true;
    }
    return false;
  }

  //Onboard Stripe
  Future<dynamic> onboardStripe() async {
    final response = await ApiClient.get(
      Endpoints.onboardStripe,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("verifyPaymentWellet ======>${response.message}");
      return response.message;
    }
    return response.message;
  }

  //fundWallet paystack
  Future<dynamic> verifyPaymentWellet({String? transactID}) async {
    String url = "${Endpoints.verifyFund}?transactionID=$transactID";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("verifyPaymentWellet ======>${response.message}");
      return response.message;
    }
    return response.message;
  }

  //get transaction wallet
  Future<List<TransactionHistory>> walletHistory() async {
    final response = await ApiClient.get(
      Endpoints.getTransactions,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final List<dynamic> allpostUser = response.message['content'];
      // log(allEvents.toString());
      getWalletHistory = allpostUser
          .map<TransactionHistory>((post) => TransactionHistory.fromJson(post))
          .toList();
      log("getWalletHistory ======>$getWalletHistory");
      return getWalletHistory;
    }
    return [];
  }

  //withdrawl paystack amount
  Future<bool> withdrawWallet({
    double? amount,
    String? currency,
  }) async {
    final data = {};
    String url =
        "${Endpoints.withdrawWallet}?currency=$currency&amount=$amount";
    final response = await ApiClient.post(
      url,
      body: data,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      log("withdrawPaystack ======>${response.message}");
      return true;
    }
    return false;
  }
}
