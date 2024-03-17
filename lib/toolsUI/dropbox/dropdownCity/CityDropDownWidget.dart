
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/city_model.dart';

/**
 ----------------------------- How to use

 1- in "view" folder
    Widget dropDown() {
    var drop = CityDropDownWidget(
    items:  istCity,
    selectedValue: selectedValue ?? "Select City",
    onTap: (data, cityName) {
    city = data;
    selectedValue = cityName;
    setState(() {});
    },
    );

    return Container( child:  drop,
    margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8)
    );
    }


    2- create variable
    List<MCity> listCity = [];

    3-  controller download city list

    void getDownloadCity() async {

    String url =  BackendConstant.domain  + "/public/api/v2/city/?page=1&paginator=100";
    await NetworkManagerDio().callBack( url , type: NetworkTypeDio.get , callback: (status, msg, json ){

    // Log.i( "getDownloadCity() - json: " + json.toString()  );

    ResponseCityList response = ResponseCityList.fromJson(json);

    Log.i( "getDownloadCity() - response: " + response.toString()  );

    //set data
    setState(() {

    con.listCity = response.data!.data!;
    });


    });

    }



 */
class CityDropDownWidget extends StatelessWidget {
  final List<MCity> items;
  final String? selectedValue;
  final Function(MCity data, String city) onTap;

   CityDropDownWidget({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.onTap,
  }) : super(key: key);

  BuildContext? context;


  @override
  Widget build(BuildContext context) {
    this.context =context;

    return Container(
    //  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      //
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return getInputDecorator();
        },
      ),
    );
  }


  InputDecorator getInputDecorator(){
    return InputDecorator(
      decoration: getInputDecoration(),
      child: dropDownCityPicker(),
    );
  }


  InputDecoration   getInputDecoration(){
    return  InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( DSDimen.ds_size_corner_level_2),
        borderSide:   BorderSide(
          color:  DSColor.ds_textfield_boarder_line ,// Color(0xFF52b4f6),
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular( DSDimen.ds_size_corner_level_2 ),
        borderSide:   BorderSide(
          color: DSColor.ds_textfield_boarder_line, //Color(0xFF52b4f6),
          width: 1.0,
        ),
      ),
      prefixIcon:   Icon(
        CupertinoIcons.location_solid,
        color: DSColor.ds_textfield_hint, //Color(0xFF09184c)
      ),
    );
  }

  TextStyle getStyle() {
    return TextStyle(
      fontSize: DSDimen.text_level_2,
      color: DSColor.ds_textfield_text, // Colors.black,
    );
  }

  Widget getHintWidget() {
    return Text(
      selectedValue?? "Select City",
      style:   TextStyle(
        color: getColorHint() , // Colors.black,
        fontSize: DSDimen.text_level_2,
      ),
    );
  }


  Color getColorHint(){
    if( selectedValue == null ) {
      return DSColor.ds_textfield_hint;
    }
    return DSColor.ds_textfield_text;
  }

  Widget dropDownCityPicker() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<List<MCity>>(
        style:  getStyle() ,
        hint: getHintWidget(),
        isExpanded: true,
        isDense: true,
        onChanged: (List<MCity>? newValue) {},
        items: items.map<DropdownMenuItem<List<MCity>>>((MCity valueItem) {
          return getItemMenu(valueItem);
        }
        ).toList(),
      ),
    );
  }

  //------------------------------------------------------------- item menu

  DropdownMenuItem<List<MCity>> getItemMenu(MCity valueItem){
    return DropdownMenuItem(
      onTap: () {
        onTap(valueItem, getName(valueItem));
      },
      value: items,
      child: Row(
        children: [
          const SizedBox(
            width: 0,
          ),
          Text(
            getName(valueItem),
          ),
        ],
      ),
    );
  }


  String getName(MCity valueItem){
    String name = MCityTools.getNameByLang(context!, valueItem);
    return name;
  }


}
