import 'dart:core';

import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';

import '../serverpod_client.dart';

class AccountModel extends ChangeNotifier {

  List<Principal> principal = [];

  fetchPrincipalByUserId({int? userId}) async {
    try {
      principal = await client.principal.getPrincipalByUserId(userId: userId);
      principal.sort((a,b) => a.point.compareTo(b.point));
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}