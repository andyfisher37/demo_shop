import 'dart:async';
import 'dart:convert';
import 'package:demo_shop/models/http_exception.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;

  // Verify is user authenticate (token no null)
  bool get isAuth {
    return token != null;
  }

  // Get the user token
  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  // Get the user Id
  String? get userId {
    return _userId;
  }

  // Authentication user in system
  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDZAdKzf-QMgn-ltFvIqlqgjIngYTFGIug');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      // Set auto log out
      _autologout();
      notifyListeners();
      // Save the preference for current user in mobile device...
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate?.toIso8601String()
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  // Registration new user in the system
  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  // Login user in the system
  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  // Automation log in user in system
  Future<bool> tryAutoLogin() async {
    // get preferences
    final prefs = await SharedPreferences.getInstance();

    // check the key in pref
    if (!prefs.containsKey('userData')) {
      return false;
    }
    // extract user data
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'] as String);
    // if user token is expired...
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    // set extracted user data
    _token = extractedUserData['token'] as String;
    _userId = extractedUserData['userId'] as String;
    _expiryDate = expiryDate;

    notifyListeners();
    _autologout();
    return true;
  }

  // Logout user from system...
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    _authTimer = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userData');
    prefs.clear();
  }

  // Automatic log out user after duration time
  void _autologout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
