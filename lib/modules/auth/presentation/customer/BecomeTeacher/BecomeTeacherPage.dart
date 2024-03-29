import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/auth/provider/BecomeTeacherNotifier.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/toolsUI/ThemeColor.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';
import 'package:umq/toolsUI/textview/HeaderTextHelper.dart';

class BecomeTeacherPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
  BecomeTeacherPage();
}

class _PageState extends StateMVC<BecomeTeacherPage> {
  AuthChangeNotifier? provider;

  @override
  void initState() {
    super.initState();
    provider = AuthChangeNotifier.getListenFalse(context);
    provider!.getCity();
    provider!.getOrgnaization();
  }

  @override
  Widget build(BuildContext context) {
    provider = AuthChangeNotifier.getListenTrue(context);
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: provider!.becomeTeacherScaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_auth.jpeg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                HeaderTextHelper.HeaderText('Become TRAINER',
                    color: Colors.white),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: sp_city(),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: ThemeColor.colorSecoundry.withOpacity(.5),
                      border: Border.all(color: Colors.white, width: 0.5)),
                ),
                Container(
                  height: 45,
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: sp_orginization(),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: ThemeColor.colorSecoundry.withOpacity(.5),
                      border: Border.all(color: Colors.white, width: 0.5)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonPrimaryWidget(
                  'Submit',
                  onTap: () {
                    provider!.registerProvider();
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-------------------------------------------------------------------- city

  Widget sp_city() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<MCity>(
      value: provider!.becomeTeacherSelectedCity,
      isExpanded: true,
      items:
          provider!.becomeTeacherCities.map<DropdownMenuItem<MCity>>((value) {
        return DropdownMenuItem<MCity>(
            value: value,
            child: Text(
              getCityNameByLang(value),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ));
      }).toList(),
      dropdownColor: ThemeColor.colorSecoundry.withOpacity(.5),
      iconEnabledColor: Colors.white,
      onChanged: (value) {
        setState(() {
          provider!.becomeTeacherSelectedCity = value!;
        });
      },
    ));
  }

  String getCityNameByLang(MCity value) {
    return MCityTools.getNameByLang(context, value);
  }

  //--------------------------------------------------------------- orginization

  Widget sp_orginization() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<MOrganization>(
      value: provider!.becomeTeacherSelectedOrganization,
      isExpanded: true,
      items: provider!.becomeTeacherOrganization
          .map<DropdownMenuItem<MOrganization>>((value) {
        return DropdownMenuItem<MOrganization>(
            value: value,
            child: Text(
              getOrgNameByLang(value),
              //  value.name,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ));
      }).toList(),
      dropdownColor: ThemeColor.colorSecoundry.withOpacity(.5),
      iconEnabledColor: Colors.white,
      onChanged: (value) {
        setState(() {
          provider!.becomeTeacherSelectedOrganization = value!;
        });
      },
    ));
  }

  String getOrgNameByLang(MOrganization value) {
    // if( LanguageTools.isArabic(context)){
    //   return value.name_ar;
    // }
    return value.name;
  }
}
