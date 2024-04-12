import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/html/editior/FileHtmlUploadController.dart';
import 'package:umq/toolsUI/html/editior/FixerScrollbarHtml.dart';
import 'package:umq/toolsUI/html/editior/UrlContentEditior.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

/**
    call page example code:
    var page = HtmlEditiorPage(callback: (String value) {

    });
    NavigationTools.push( page );
 */

double heightEditor = 400;

class HtmlEditiorPage extends StatefulWidget {
  ValueChanged<String> callback;

  /**
   this already html data saved
   */
  String? edit_dataHtml_content;

  /**
      // this url have some html tags, we need to download first then edit it
   */
  String? edit_url_content;
  String uniqueName;

  HtmlEditiorPage(
      {super.key,
      required this.uniqueName,
      this.edit_dataHtml_content,
      this.edit_url_content,
      required this.callback});

  @override
  HtmlEditorState createState() {
    bool hideHtmlEditorUntilDownloadUrlContent = false;
    if (edit_url_content != null) {
      hideHtmlEditorUntilDownloadUrlContent = true;
    }
    return HtmlEditorState(hideHtmlEditorUntilDownloadUrlContent);
  }
}

class HtmlEditorState extends ResumableState<HtmlEditiorPage> {
  QuillEditorController controller = QuillEditorController();
  bool progressStatus = false;
  bool hideHtmlEditorUntilDownloadUrlContent = false;

  HtmlEditorState(this.hideHtmlEditorUntilDownloadUrlContent);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setupUrlContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    fixScrollbarOnBuildPage();
    setHtmlEditorHeight();
    return PageFastor(this,
        //toolbar
        toolbar: tooblarWidget(),
        statusBarColorCustom: HexColor(ColorProject.black_4),
        toolbar_height: getToolbarHeight(),
        thumbVisibility: true,
        floatBottom: floatingButtonForSaveInMobileOnly(),
        content: getContent());
  }

  //------------------------------------------------------------------- toolbar

  Widget tooblarWidget() {
    var toolbarTitle = ToolbarSimpleFastor(context, "HTML Editor");

    return ColumnTemplate.t(
        // colorBackground: DSColor.ds_background_layout_3_transparent,
        height: getToolbarHeight(),
        children: [toolbarTitle, chooseToolbarWithSaveButtonOrToolbarOnly()]);
  }

  Widget chooseToolbarWithSaveButtonOrToolbarOnly() {
    var toolbarHtml = ToolBar(controller: controller, toolBarConfig: null);

    Widget toolbarAndSaveInWebsiteLandscape;

    if (DeviceTools.isLandscape(context)) {
      toolbarAndSaveInWebsiteLandscape =
          RowTemplate.child1_expanded_child2_wrapWidth(
              toolbarHtml, buttonSave());
    } else {
      toolbarAndSaveInWebsiteLandscape = toolbarHtml;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: DSDimen.space_level_2),
      color: HexColor(ColorProject.greyDark),
      child: toolbarAndSaveInWebsiteLandscape,
    );
  }

  double getToolbarHeight() {
    const toolbarTitleHeight = ToolbarSimpleFastor.frameHeight;
    Log.i("getToolbarHeight() - device width: ${DeviceTools.widthFullSize}");
    if (DeviceTools.isLandscape(context)) {
      return toolbarTitleHeight + 80;
    } else if (DeviceTools.widthFullSize < 500) {
      return toolbarTitleHeight + 155;
    } else {
      return toolbarTitleHeight + 115;
    }
  }

  //------------------------------------------------------------------- content

  Widget getContent() {
    return ColumnTemplate.t(margin: getMarginForHtmlView(), children: [
      progressView(),
      htmlView(),
      // addMoreSpaceButton()
    ]);
  }

  EdgeInsets getMarginForHtmlView() {
    if (DeviceTools.isPortrait(context)) {
      return EdgeInsets.only(
          //top: AdminToolbar.toolbarHeightLayer+ 20 ,
          left: DSDimen.space_level_2 * 2,
          right: DSDimen.space_level_2 * 2,
          bottom: DSDimen.space_level_2);
    } else {
      return EdgeInsets.only(
          //top: AdminToolbar.toolbarHeightLayer+ 20 ,
          left: DSDimen.space_parent * 4,
          right: DSDimen.space_parent * 4,
          bottom: DSDimen.space_parent);
    }
  }

  //-------------------------------------------------------------------------- html editor

  Widget progressView() {
    if (progressStatus == false) return EmptyView.zero();

    var prg = ProgressSpinkit.get();
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 40),
      child: prg,
    );
  }

  //-------------------------------------------------------------------------- html editor

  Widget htmlView() {
    if (progressStatus) return EmptyView.zero();

    //check not need
    if (hideHtmlEditorUntilDownloadUrlContent) {
      return EmptyView.zero();
    }

    var htmlEditorData = QuillHtmlEditor(
      text: widget.edit_dataHtml_content,
      controller: controller,
      // height: heightEditor,
      backgroundColor: HexColor("#E1E1E1"), //#F4F4F4
      hintText: 'Loading',
      isEnabled: true,
      minHeight: heightEditor,
      textStyle: const TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 20.0,
        color: Colors.black87,
        fontWeight: FontWeight.normal,
      ),
      onTextChanged: (s) {
        Log.i("print on change: $s");
      },
    );

    return htmlEditorData;
  }

  //--------------------------------------------------------------------- buttons

  Widget floatingButtonForSaveInMobileOnly() {
    if (DeviceTools.isLandscape(context)) return EmptyView.zero();

    //button save at web only
    if (progressStatus) {
      return EmptyView.zero();
    } else {
      return buttonSave();
    }
  }

  Widget progressSave() {
    return ProgressSpinkit.get();
  }

  Widget buttonSave() {
    var bt = ButtonFastor(
      "save",
      () async {
        String value = await controller.getText();
        Log.i("buttonSave() - html:$value");
        await uploadHtmlData();
      },
      width: 65,
      height: 35,
      levelDS: LevelDS.l3_dark,
      margin: const EdgeInsets.symmetric(vertical: 20),
      gravityLayout: Alignment.center,
    );

    return Container(
      alignment: Alignment.center,
      child: bt,
    );
  }

  Widget addMoreSpaceButton() {
    return ButtonFastor(
      "Add More Lines",
      () async {
        Log.i("addMoreSpaceButton() - click ");

        await fixScrollbarDueToIncreaseLines();

        // setState(() {
        //   heightEditor += 500;
        // });
      },
      width: 150,
      height: 35,
      levelDS: LevelDS.l3_dark,
      margin: const EdgeInsets.symmetric(vertical: 20),
      gravityLayout: Alignment.bottomRight,
    );
  }

  void setHtmlEditorHeight() {
    //case: website brower chrome from desktop
    if (DeviceTools.isLandscape(context)) {
      heightEditor =
          DeviceTools.getHeight(context) - getToolbarHeight() - 100.0;
      Log.i("setHtmlEditorHeight() - heightEditor: $heightEditor");
      return;
    }
  }
}
