
//--------------------------------------------------------------- get windows language
import 'package:umq/tools/context/MyApplication.dart';
import 'package:fastor_app_ui_widget/resource/uiFastor/language/LanguageTools.dart';

/**
 * html.window.navigator.language ;
 */


Window get window => Window();

class Window {
  Navigator get navigator =>  Navigator();
}

class Navigator {
  String get language => getLanguage();
}

dynamic getLanguage(){
  return LanguageTools.getLocalLanguage( MyApplication.getContext() );
}

//---------------------------------------------------------------- SEO Render widget

dynamic ParagraphElement(){
return null;
}

class HeadingElement {

  static dynamic h1(){
    return null;
  }



}

class HtmlElement {

}