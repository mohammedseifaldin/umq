import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

/**
 *
 How to use this class
    1- in build view of "TextField" call method "startCheckerHeightTextField() "

    void startCheckerHeightTextField() {
    checkerHeightTextField =  CheckerHeightTextField(
    txt: "",
    tf_frame_width: getWidthOfFrameTextField(),
    maxLine :4 ,
    margin : 14,
    callBackHeight: ( newHeight ) {

    //save to state                            //step 2 - update height of frame of container carry textfield
    chatMessageState.setState( (){

    InputMessageView.height_Frame = newHeight  ;
    });

    }
    );
    }


 */
class CheckerHeightTextField {
  String txt;
  double tf_frame_width;
  double? padding;
  double? margin;
  double? dimenFont;
  int? maxLine;
  ValueChanged<double> callBackHeight;

  //result
  int linesExpected = 1;
  double heightFrameExpected = 40;

  double previousHeight = 40;

  CheckerHeightTextField({
    required this.txt,
    required this.tf_frame_width,
    required this.callBackHeight,
    this.padding,
    this.margin,
    this.dimenFont,
    this.maxLine,
  }) {
    //set default
    dimenFont ??= DSDimen.text_level_2;

    padding ??= DSDimen.textfield_auto_padding;
  }

  Future updateText(String nexText) async {
    //set value
    txt = nexText;

    //calculate again
    linesExpected = await _linesCalculate();
    heightFrameExpected = await _heightOfFrameCalclate();

    //call back
    await callBackValidate();

    //update previous
    previousHeight = heightFrameExpected;
  }

  Future callBackValidate() async {
    //check there is no update to height
    if (previousHeight == heightFrameExpected) {
      // Log.i( "callBackValidate() - previousHeight == heightFrameExpected - stop!  ");
      return;
    }

    //now update
    // Log.i( "callBackValidate() - result heightFrameExpected: " + heightFrameExpected.toString() );
    callBackHeight(heightFrameExpected);
  }

  Future<double> _heightOfFrameCalclate() async {
    //calculate height
    double singleHeightPixelExpected = dimenFont! * 2;
    double heightFrameExpected = singleHeightPixelExpected * linesExpected;

    //add margin
    margin ??= 0;
    return heightFrameExpected + margin!;
  }

  Future<int> _linesCalculate() async {
    int lineexpectedRoundtoplusone = 1;

    //get data
    int lenChar = txt.length;
    double oneCharacterNeedPixel = 0.62 * dimenFont!;
    double needWidthFrame = oneCharacterNeedPixel * lenChar;
    double lineexpectedDouble = needWidthFrame / tf_frame_width;

    //check fraction is 0.xxxx is not equal zero
    /**
        example:
        lineExpected_double is 2.5, means i need the result to be 3 lines not 2 lines

     */
    double fraction = lineexpectedDouble - lineexpectedDouble.truncate();
    if (fraction > 0) {
      lineexpectedRoundtoplusone = lineexpectedDouble.toInt() + 1;
    } else {
      lineexpectedRoundtoplusone = lineexpectedDouble.toInt();
    }

    //log
    // Log.i( "_linesCalculate() - dimenFont: " + dimenFont.toString()  );
    // Log.i( "_linesCalculate() - lenChar: " + lenChar.toString()  );
    // Log.i( "_linesCalculate() - tf_frame_width: " + tf_frame_width.toString()  );
    // Log.i( "_linesCalculate() - oneCharacterNeedPixel: " + oneCharacterNeedPixel.toString()  );
    // Log.i( "_linesCalculate() - lineExpected_double: " + lineExpected_double.toString()  );
    // Log.i( "_linesCalculate() - lineExpected_roundToPlusOne: " + lineExpected_roundToPlusOne.toString()  );

    //check max line
    if (maxLine != null) {
      if (maxLine! < lineexpectedRoundtoplusone) return maxLine!;
    }

    //check min is one
    if (lineexpectedRoundtoplusone < 1) {
      return 1;
    }

    return lineexpectedRoundtoplusone;
  }
}
