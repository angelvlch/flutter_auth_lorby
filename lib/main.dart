import 'package:auth_lorby/core/app/auth_app.dart';
import 'package:auth_lorby/core/injection/di.dart';
import 'package:flutter/material.dart';

void main() {
  setupDependencies();
  runApp(const AuthApp());
}
