class ToolsValue {
  static bool isValid(String? str) {
    return checkHaveValue(str);
  }

  static bool isValidList(List<String>? listStr) {
    return !isEmptyList(listStr);
  }

  static bool checkHaveValue(String? str) {
    if (str == null) {
      return false;
    }
    if (str.isEmpty) {
      return false;
    }
    if (str == "") {
      return false;
    }
    if (str == "null") {
      return false;
    }
    if ("null" == str.trim().toLowerCase()) {
      return false;
    }
    if (str == " ") {
      return false;
    }
    return true;
  }

  static bool isNotZeroInt(int? n) {
    if (n == null) return false;
    if (n == 0) {
      return false;
    }
    return true;
  }

  static bool isNotZero(String? n) {
    if (!isValid(n)) {
      return false;
    }
    if (n == "0") {
      return false;
    }
    return true;
  }

  static bool isEmpty(String? str) {
    return !checkHaveValue(str);
  }

  static bool isEmptyInt(int? n) {
    if (n == null) return true;

    if (n == 0) {
      return true;
    }
    return false;
  }

  static bool isEmptyList(List<String>? myList) {
    if (myList == null) {
      return true;
    }
    if (myList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmptyListInteger(List<int>? myList) {
    if (myList == null) {
      return true;
    }
    if (myList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidListInteger(List<int>? list) {
    return !isEmptyListInteger(list);
  }

  static bool isZero(String? v) {
    return !isNotZero(v);
  }

  // static bool isNotZeroInt(int? v ) {
  //   return !isZeroInt(v);
  // }

  static bool isZeroInt(int? v) {
    if (v == null) return true;
    if (v == 0) return true;
    return false;
  }

  static bool isValidInteger(int? n) {
    if (n == null) return false;
    if (n == 0) return false;
    return true;
  }
}
