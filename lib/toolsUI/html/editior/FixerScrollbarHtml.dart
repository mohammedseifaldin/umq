import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/html/editior/HtmlEditiorPage.dart';

extension FixerScrollbarHtml on HtmlEditorState {

  //------------------------------------------------------------------------ on build page

  @Deprecated( "still under testing")
  Future fixScrollbarOnBuildPage() async {
    if(DeviceTools.isPortrait(context)) return;

    Log.i( "fixScrollbarOnBuildPage()  "  );
    if( widget.edit_dataHtml_content != null ) {
      _typeEditDataOnBuildPage();
    } else {
      _typeEmptyDataPageOnBuildPage();
    }
  }


  Future _typeEditDataOnBuildPage() async {
    String emptyLines = _newLineGenerator(100);
    //edit
    widget.edit_dataHtml_content = widget.edit_dataHtml_content! + emptyLines;
  }


  Future _typeEmptyDataPageOnBuildPage() async {
    String emptyLines = _newLineGenerator(100);
    widget.edit_dataHtml_content = emptyLines;
  }

  //----------------------------------------------------------------- increase  lines


  Future fixScrollbarDueToIncreaseLines() async {
    String value = await controller.getText();
    String emptyLines = _newLineGenerator(100, append: "**more line**");
    setState(() {
      widget.edit_dataHtml_content = value + emptyLines;
    });
  }


  //------------------------------------------------------------------ tools methods

  String _newLineGenerator(int counterLine, { String? append}  ) {
      String single = "<p>\n</p>";
      String result = "";
      for( int i = 0 ; i < counterLine ; i++ ) {
        result += single;
      }

      //append
      if(append != null ) {
        result += append;
      }

      return result;
  }


}