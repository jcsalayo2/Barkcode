// ignore_for_file: prefer_const_constructors, duplicate_import

import 'package:barkcode/pages/home_page.dart';
import 'package:barkcode/pages/login_page.dart';
import 'package:barkcode/main.dart';
import 'package:barkcode/pages/pet_profile_page.dart';
import 'package:barkcode/pages/pet_form_page.dart';
import 'package:barkcode/pages/register_page.dart';
import 'package:barkcode/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*This file uses Fluro [https://pub.dev/packages/fluro] because fluro is a 
straightforward package when it comes to routing with params

i.e - when viewing the product
OLD URL - host:port#/#/product/details
CURRENT WITH FLURO - host:port#/#/product/details/Grocer-BunBox?s.KsJnE68ocyLovu3Hn268?sku=GBBOX30

*NOTE SUBJECT TO CHANGE INCLUDING THE LINK FORMAT
 */
class FloruRouter {
  static FluroRouter fluroRouter = FluroRouter();

  static var baseScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return BasePage();
  }));

  static var profileScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return PetProfilePage(
      id: params['id'][0],
    );
  }));

  static var registerScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return RegisterPage();
  }));

  static var homeScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return HomePage();
  }));

  static var petFormScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return ProfileFormPage();
  }));

  static initRoutes() {
    fluroRouter.define('/', handler: baseScreenHandler);
    fluroRouter.define('/register', handler: registerScreenHandler);
    fluroRouter.define('/profile/:id', handler: profileScreenHandler);
    fluroRouter.define('/home', handler: homeScreenHandler);
    fluroRouter.define('/pet_form', handler: petFormScreenHandler);
  }
}
