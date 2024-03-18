
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/ThemeColor.dart';


class UserTypePage extends StatefulWidget {
  @override
  UserTypePageState createState() => UserTypePageState();
}

class UserTypePageState extends State<UserTypePage> {

  // var dialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late BuildContext contextUserType;


  @override
  Widget build(BuildContext context) {
    contextUserType = context;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(children: [
          backgroundImage(),
         Positioned(child: columnPage(),bottom: 1,top: 1,left: 20,right: 20,)

        ],
        ),
    );
  }

  Widget backgroundImage(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_auth.jpeg'),
              fit: BoxFit.cover
          )
      ),
    );
  }

  Widget columnPage() {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        //trainer
        InkWell(
          onTap:(){
            openTrainer();
            // Navigator.pushNamed(context, '/become_provider');
          },
          child: trainerView(),
        ),


        //student
        InkWell(
          onTap:(){
            openStudent();
            //Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
          child: studentView(),
        ),
      ],
    );
  }


  Widget trainerView() {
    return Container(
      width: DeviceTools.getWidth(context),
      padding:const EdgeInsets.symmetric(vertical: 30),
      margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1],
            colors: [
              ThemeColor.hexToColor('#05A8F1'),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.supervised_user_circle,color: Colors.white,size: 60,),
          const  SizedBox(width: 20,),
          Text("Login as Trainer",
            textAlign: TextAlign.center,
            style:const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontFamily:'Schyler',
                color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget studentView() {
    return Container(
      width:  DeviceTools.getWidth(context),
      padding:const EdgeInsets.symmetric(vertical: 30),
      margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1],
            colors: [
              ThemeColor.hexToColor('#ffffff'),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 10,
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle,color: Colors.blue,size: 60,),
          const  SizedBox(width: 20,),
          Text("Login as Student",
            textAlign: TextAlign.center,
            style:const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontFamily:'Schyler',
                color: Colors.blue),
          )
        ],
      ),
    );
  }


  Future openTrainer() async{
    GoTo.becomeTeacher( contextUserType);
  }

  Future openStudent() async{

    GoTo.chooseHomeByTypeRoleUser( contextUserType );
  }

}
