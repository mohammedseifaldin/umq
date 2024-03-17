import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';

class OrderCurrentUtils {

  /**
   * the total of price of product at cart.
   *  example: milk is 5 USD * 2 pecs = 10 USD
   *    +   Juice is 2 USD * 3 pecs = 6  USD
   *     the total price of products is 10 + 6 = 16 USD
   */
   static int priceProductsAtCart(){
    //get cart
    List<MCartSingleProduct> listCart = OrderCurrentSingletone.instance().cartList;
    if( listCart.isEmpty ) return 0 ;

    int result  = 0 ;

    //loop
     listCart.forEach(( cart) {
       int price = cart.product!.price!;
       int qty = cart.counter!;
       int singlePrice = price * qty;
       result += singlePrice;
     });

     return result;
  }


  static double vat() {
    int productPrice = priceProductsAtCart();
    double result  = productPrice * 0.05 ; // in Saudi is 5%
    return result;
  }

  static double totalInvoice() {
    int productPrice = priceProductsAtCart();
    double vatValue = vat();
    return vatValue + productPrice;
  }


}