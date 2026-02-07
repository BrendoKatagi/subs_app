import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:substore_app/config/app_routes.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkHelper {
  bool _initialURILinkHandled = false;
  Uri? _initialURI;
  Uri? _currentURI;

  Uri? get initialUri => _initialURI;

  Future<void> init() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;

      try {
        final initialURI = await getInitialUri();
        _currentURI = initialURI;

        if (initialURI != null) {
          _initialURI = initialURI;
        }

        uriLinkStream.listen((Uri? uri) async {
          _currentURI = uri;
        });
      } on PlatformException {
        debugPrint('Failed to receive initial uri');
      } on FormatException catch (_) {
        debugPrint('Malformed Initial URI received');
      }
    }
  }

  void Function(BuildContext)? uriNavigation() {
    if (_currentURI == null || _currentURI?.queryParameters == null || _currentURI!.queryParameters.isEmpty) return null;

    final Map<String, String> param = _currentURI!.queryParameters;

    final String page = param['page'] ?? '';

    return AppRoutes.pageNavigationFunction(page);
  }
}
