import 'dart:developer';

import 'package:chases_scroll/src/config/keys.dart';
import 'package:chases_scroll/src/config/locator.dart';
import 'package:chases_scroll/src/models/transaction_model.dart';
import 'package:chases_scroll/src/repositories/api/api_clients.dart';
import 'package:chases_scroll/src/repositories/endpoints.dart';
import 'package:chases_scroll/src/services/storage_service.dart';

class WalletRepository {
  final _storage = locator<LocalStorageService>();
  List<TransactionHistory> getWalletHistory = [];

  //escrow
  List<dynamic> inEscrow = [];
  List<dynamic> inEscrowFinilized = [];
  List<dynamic> inEscrowRefund = [];

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
  Future<List<dynamic>> getEscrowRefundCompleted() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=REFUND_COMPLETED";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final inEscrowRefund = response.message['content'];
      // log(allEvents.toString());
      log("getEscrowRefundCompleted ======>${response.message['content']}");

      return inEscrowRefund;
    }
    return [];
  }

  //get escrow inEscrow
  Future<List<dynamic>> getInEscrow() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=IN_ESCROW";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final inEscrow = response.message['content'];
      log("getInEscrow ======>${response.message['content']}");
      // log(allEvents.toString());

      return inEscrow;
    }
    return [];
  }

  //get escrow finilized
  Future<List<dynamic>> getInFinalized() async {
    String url = "${Endpoints.escrowAddStatus}?escrowStatus=FINALIZED";
    final response = await ApiClient.get(
      url,
      useToken: true,
    );

    if (response.status == 200 || response.status == 201) {
      final inEscrowFinilized = response.message['content'];
      // log(allEvents.toString());
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
}
