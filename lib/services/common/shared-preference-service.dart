import 'package:sendeaze/constants/shared-pref-constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPref {
  setBoolToLocal(String _key, bool _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, _value);
  }

  setStringToLocal(String _key, String _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_value != null) {
      prefs.setString(_key, _value);
    }
  }

  getBoolFromLocal(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(_key);
    return value ?? false;
  }

  getDataFromLocal(String _key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(_key);
    print("=>latlan $value");
    return value ?? "";
  }

  setIntToLocal(String _key, int _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, _value);
  }

  removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool('rememberMe', false);
    //   prefs.setString(SharedPrefConstants.CURRENT_LANGUAGE, 0.toString());
  }
}
