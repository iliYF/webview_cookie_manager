import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class WebviewCookieManager {
  static const MethodChannel _channel = const MethodChannel('webview_cookie_manager');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  factory WebviewCookieManager() {
    return _instance ??= WebviewCookieManager._();
  }

  WebviewCookieManager._();

  static WebviewCookieManager _instance;

  Future<void> clearCookies() {
    return _channel.invokeMethod<void>('clearCookies');
  }

  /// Gets whether there are stored cookies
  Future<bool> hasCookies() {
    return _channel.invokeMethod<bool>('hasCookies').then<bool>((bool result) => result ?? false);
  }

  /// Read out all cookies, or all cookies for a [url] when provided
  Future<List<Cookie>> getCookies(String url) {
    return _channel.invokeListMethod<Map>('getCookies', {'url': url}).then((results) => results == null
        ? <Cookie>[]
        : results.map((Map result) {
            final c = Cookie(result['name'] ?? '', removeInvalidCharacter(result['value'] ?? ''))
              // following values optionally work on iOS only
              ..path = result['path']
              ..domain = result['domain']
              ..secure = result['secure'] ?? false
              ..httpOnly = result['httpOnly'] ?? true;

            if (result['expires'] != null) {
              c.expires = DateTime.fromMillisecondsSinceEpoch((result['expires'] * 1000).toInt());
            }

            return c;
          }).toList());
  }

  /// Remove cookies with [currentUrl] for IOS and Android
  Future<void> removeCookie(String currentUrl) async {
    final listCookies = await getCookies(currentUrl);
    final serializedCookies =
        listCookies.where((element) => element.domain != null ? currentUrl.contains(element.domain) : false).toList();
    serializedCookies.forEach((c) => c.expires = DateTime.fromMicrosecondsSinceEpoch(0));
    await setCookies(serializedCookies);
  }

  /// Set [cookies] into the web view
  Future<void> setCookies(List<Cookie> cookies) {
    final transferCookies = cookies.map((Cookie c) {
      final output = <String, dynamic>{
        'name': c.name,
        'value': c.value,
        'path': c.path,
        'domain': c.domain,
        'secure': c.secure,
        'httpOnly': c.httpOnly,
        'asString': c.toString(),
      };

      if (c.expires != null) {
        output['expires'] = c.expires.millisecondsSinceEpoch ~/ 1000;
      }

      return output;
    }).toList();

    return _channel.invokeMethod<void>('setCookies', transferCookies);
  }

  String removeInvalidCharacter(String value) {
    // Remove Invalid Character
    var valueModified = value.replaceAll('\\"', "'");
    valueModified = valueModified.replaceAll(String.fromCharCode(32), "");
    return valueModified;
  }
}
