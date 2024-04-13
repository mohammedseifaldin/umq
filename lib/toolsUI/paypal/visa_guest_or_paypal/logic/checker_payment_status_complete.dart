import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/PaypalGenericPage.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/shared/PayPalConstant.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/shared/ToolsPayment.dart';

extension CheckerPaymentStatusComplete on PaypalGenericState {
  //-------------------------------------------------------------------- check the url valied

  Future checkThisUrlForCompleteStatus(String urlToCheck) async {
    //check null
    if (urlToCheck.isEmpty) return;
    Log.i("checkThisUrlForCompleteStatus() - urlToCheck: $urlToCheck");

    //check success before: to avoid return more than one time
    if (isTransactionSuccess) {
      Log.i(
          "checkThisUrlForCompleteStatus() - stop -  isTransactionSuccess equal(true)");
      return;
    }

    //check completed by failed
    bool isFailedUrl =
        urlToCheck.contains(PayPalConstant.returnUrlFailedTransaction);
    if (isFailedUrl) {
      whatToDoAfterFailedStatus();
      return;
    }

    //check success
    bool isSuccessUrl =
        urlToCheck.contains(PayPalConstant.returnUrlSuccessTransaction);
    if (isSuccessUrl) {
      parseParameterTransactionInformationFromUrl(urlToCheck);
      return;
    }
  }

  //---------------------------------------------------------------------- what to do when failed

  Future whatToDoAfterFailedStatus() async {
    ToolsPayment.toast(context, msg: "Payment Failed");
  }

  //--------------------------------------------------------------------- what to after success

  Future parseParameterTransactionInformationFromUrl(String urlToCheck) async {
    final parsedUrl = Uri.parse(urlToCheck);
    transactionId = parsedUrl.queryParameters["transaction_id"].toString();
    whatToDoAfterCompleteStatus();
  }

  Future whatToDoAfterCompleteStatus() async {
    //avoid call twice
    isTransactionSuccess = true;

    showMessageSuccess();
  }

  void showMessageSuccess() {
    ToolsPayment.toast(context, msg: "Payment Have Been Done Successfully",
        wait_callBack: () {
      finishClassAndMakeCallback();
    });
  }

  void finishClassAndMakeCallback() {
    Log.i("finishClassAndMakeCallback() - transactionId: $transactionId");

    //dismiss page
    Navigator.of(context).pop();

    //callback
    payPalCallBack!(isTransactionSuccess, "Success", transactionId);
  }
}
