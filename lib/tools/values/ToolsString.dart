class ToolsString{

  static String removeNewLine(String? s ){
    s ??= "";
    return s.replaceAll( "\n",  "");
  }
}