class PayPalConstant {

  /**
   make price is 1 dollar for testing only
   */
  static const forcePriceIsOneDollar = false;

  static var linkToPayBaseWithPrice = "https://scuba-world.net/paypal?price_target=";


  //------------------------------------------------------- success and failed
/**

    //case success
    var isStatusComplated =  "COMPLETED" == transaction.status;
    if(isStatusComplated  ) {
    var urlSuccessWithParam =  "https://umq.app/paypal/success" +"?transaction_status=" + transaction.status +  "&transaction_id=" + transaction.id;
}

    //case failed
    var urlCancelWithParam = "https://umq.app/paypal/cancel" +"?transaction_status=" + transaction.status + "&transaction_id=" + transaction.id;

 */

  static const returnUrlSuccessTransaction = "https://umq.app/paypal/success";
  static const returnUrlFailedTransaction = "https://umq.app/paypal/cancel";

}