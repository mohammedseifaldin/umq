class ToolsArray {

  static String putCommanSeprator(List<dynamic> list )   {
    String result = "";
    if( list.length == 0 )return result;


    int size = list.length;
    for( int i = 0; i <  size; i++ ) {
      dynamic m = list[i];

      //check null
      if( m  == null ) continue;

      //check last
      bool isLast = i == (size - 1 );
      if(  isLast ) {
        result += "" + m;
      }  else {
        result +=  m + ", " ;
      }
    }
    return result;
  }


}