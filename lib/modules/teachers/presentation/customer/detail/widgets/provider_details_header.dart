
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/logic/ProviderInfoController.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/widgets/provider_details_button.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DimenProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/app_colors.dart';
import 'package:umq/toolsUI/dialog/CheckoutLoginDialog.dart';
import 'package:umq/toolsUI/rating_stars.dart';




extension ProviderDetailsHeader on ProviderDetailsState {



  Widget getProviderDetailsHeader( ) {
    return frameViewContent();
  }


  Widget frameViewContent(){
    return Stack(
      children: [

        cardMain(),
        manImage( ),
      ],
    );
  }

  
  // name, rate, buttons
   
  Widget cardMain(){
    var col =   Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 35,
        ),
        providerName(),
        const SizedBox(
          height: 5,
        ),
        providerRate(),
        const SizedBox(
          height: 20,
        ),
        buttonsRow()
      ],
    );

    //decoration
    return Container(
      width: DeviceTools.getWidth(context),
      margin: const EdgeInsets.only(top: 25), //to make the manPhoto in middle
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 220, 247, 248),
          borderRadius: BorderRadius.all(Radius.circular( DimenProject.radiusScaffoldCorner))),
      child:  col,
    );
  }


  Widget providerName() {
    return Text(
      widget.provider!.users!.name??"NA",
      style:
          const TextStyle(color: darkBlue, fontSize: 18, fontWeight: FontWeight.w800),
    );
  }

  Widget providerRate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingStars(widget.provider!.rate.toString(), 25.0, onChanged: (v) {
          print(v);
        })
      ],
    );
  }

  Widget buttonsRow() {
    return Row(
      children: [
        ProviderDetailsButton(
          title: 'chat',
          buttonFn: ()  async {

            int targetUserId = widget.provider!.users!.id!;
            GoTo.chatSpecificUser(context, targetUserId);
            //launch('tel://${widget.provider!.users!.mobile ??""}');
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ProviderDetailsButton(
          title: 'rate',
          buttonFn: () async {
            await showRateDialog();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ProviderDetailsButton(
          title: 'favorite',
          buttonFn: () async {


            await favProvider(widget.provider!.id.toString(), context);
          },
        )
      ],
    );
  }

  //------------------------------------------------------------------------ photo man

  Widget manImage( ) {
    return Align( child:  imageCircle(), alignment: Alignment.center );
  }

  Widget imageCircle(){
    String url =   widget.provider!.users!.photo??"";
    return ImageView(width: 60, height: 60,
    radius_all: 30,
    assetAspectRatio: DrawableProject.placeholderImage,
  //  colorBackground: Colors.yellow,
    onPressed: (){
      GoTo.fullScreenImage(context, url);
    },
    urlBackground: url );
  }

  // Widget paddingClickOnImagePhoto (){
  //   var con = EmptyView.colored(  60,   60 , Colors.black);
  //   var click =  GestureDetector( child: con, onTap: () {
  //     String url =   widget.provider!.users!.photo??"";
  //     GoTo.fullScreenImage(context, url);
  //   });
  //
  //   return Positioned(child:  click, top:  -30 );
  // }

  //-------------------------------------------------------------------- rate

  Future showRateDialog() async {
    //check login
    if( await UserSingleTone.instance().isGuest() ) {
      CheckoutLoginDialog.show(context);
      return;
    }

    GoTo.rateDialog( context, widget.provider!, this );
  }

}

