import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umq/tools/values/ToolsValue.dart';

class Save {
  static const tag = "Save";

  //-----------------------------------------------------------------------  map list

  static Future setMapList(
      String key, List<Map<String, dynamic>> mapList) async {
    //save all backend by index array
    int len = mapList.length;
    for (int i = 0; i < len; i++) {
      Map<String, dynamic> singleMap = mapList[i];
      String keyIndex = _generateKeyMapList(key, i);
      await setMap(keyIndex, singleMap);
    }

    //save size
    String keySize = _generateKeySize(key);
    await setInt(keySize, len);
  }

  static Future<List<Map<String, dynamic>>> getMapList(String key) async {
    List<Map<String, dynamic>> mapList = [];

    //get len
    String keySize = _generateKeySize(key);
    int len = await getInt(keySize);

    //get backend
    for (int i = 0; i < len; i++) {
      String keyIndex = _generateKeyMapList(key, i);
      Map<String, dynamic> singleMap = await getMap(keyIndex);
      //add
      mapList.add(singleMap);
    }

    //
    return mapList;
  }

  static String _generateKeySize(String key) {
    return "${key}_size";
  }

  static String _generateKeyMapList(String key, int index) {
    return "${key}_index$index";
  }

  // ----------------------------------------------------------------- single map

  static Future setMap(String key, Map<String, dynamic> mapJson,
      {VoidCallback? callback}) async {
    // Map<String, Object> values = <String, Object>{'counter': 1};

    //convert to json
    String json = jsonEncode(mapJson);
    // Log.k( tag,  "setObject() mapJson: " + mapJson.toString() );
    // Log.k( tag,  "setObject() json: " + json  );

    //set json to cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, json);

    //callback
    if (callback != null) callback();
  }

  static Future<Map<String, dynamic>> getMap(String key,
      {ValueChanged<Map<String, dynamic>>? callback}) async {
    // Map<String, Object> values = <String, Object>{'counter': 1};

    //get string of json from cache
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString(key) ?? "";

    // Log.k( "save class",  "getString() - key: " + key + " /value: " + result );
    if (ToolsValue.isEmpty(jsonString)) {
      jsonString = "";
    }
    // Log.k( tag,  "getObject() jsonString: " + jsonString  );

    //convert to mapJson
    Map<String, dynamic> mapJson = jsonDecode(jsonString);
    // Log.k( tag,  "getObject() Map<String, dynamic>: " + mapJson.toString()  );

    //callback
    if (callback != null) callback(mapJson);
    return mapJson;
  }

  //------------------------------------------------------------------ int

  static Future setInt(String key, int v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, v);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  //------------------------------------------------------------------ string

  static Future setString(String key, String v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, v);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  //------------------------------------------------------------------ bool

  static Future setBool(String key, bool v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, v);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool(key) ?? false;
    return result;
  }
}
