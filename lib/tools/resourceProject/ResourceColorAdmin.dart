import 'package:hexcolor/hexcolor.dart';

class ResourceColorAdmin {

  //---------------------------------------------------------- colors

  //blue
  static var blue = HexColor(  "#3c8dbc"  );
  static var blueLight = HexColor(  "#3c8dbc"  );
  static var blueDark = HexColor(  "#367fa9"  );

  //shadow
  static var shadow = HexColor(  "#20000000"  );

  //red
  static var red = HexColor(  "#DD4B39"  );
  static var redDark = HexColor(  "#D73925"  );

  //gray
  static var grayDark = HexColor(  "#666666"  );
  static var grayDarkMedium = HexColor(  "#776671"  );
  static var grayDarkStrong = HexColor(  "#444444"  );
  static var gray_1 = HexColor( "#817E77"); //gray
  static var gray_2 = HexColor( "#777777"); //gray

  //white
  static var white = HexColor(  "#ffffff"  );
  static var whiteOff = HexColor(  "#F7FDF1"  );
  static var whiteBlueLight = HexColor( "#D2D6DE");

  //black
  static var black = HexColor(  "#3c4043");

  //green
  static var greenDark = HexColor(  "#3C763D"  );

 //------------------------------------------------------------ usage

  //background
  static var toolbarBackground = blueLight;
  static var navigationBackground = HexColor( "#1a2226");
  static var appBackground = whiteBlueLight ;
  static var appBackground_bluelight = HexColor( "#E8F0FE");
  static var appBackground_allContentActivity = HexColor( "#ECF0F5");


  //menu
  static var menuBackground_allView = HexColor( "#222D32");
  static var menuBackground_extendedMenu_title = HexColor( "#1e282c");
  static var menuBackground_extendedMenu_content = HexColor( "#2C3B41");

  //input
  static var clickOff = HexColor(  "#a9c7ce"  );
  static var clickOn = HexColor(  "#EAF1F2"  );

  //text
  static var text_h1 = HexColor( "#2B4051");
  static var text_h2 = HexColor( "#7ea4a4");
  static var text_h3 = gray_1;
  static var text_h4 = gray_2;

  //button
  static var button_clicked_on =  HexColor(  "#222D32"  );
  static var button_clicked_off =  HexColor(  "#1e282"  );
  static var button_h2 =  blueLight;

  //place holder
  static var placeHolder =  HexColor(  "#808080"  );

  //table row
  static var table_row_background = ResourceColorAdmin.black;
  static var table_row_title = ResourceColorAdmin.white;
  static var table_row_line = ResourceColorAdmin.white;

  //table header
  static var table_header_background = ResourceColorAdmin.white;
  static var table_header_title = ResourceColorAdmin.blueDark;
  static var table_header_line = ResourceColorAdmin.blueDark;


}
