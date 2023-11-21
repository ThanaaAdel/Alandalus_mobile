import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../logger.dart';
import 'alerts.dart';


class ContactHelper{

  static void launchMap({num? lat = 47.6, num? long = -122.3}) async {
    var uri =  Uri.parse("google.navigation:q=$lat,$long&mode=d");
    Uri appleUrl = Uri.parse('https://maps.apple.com/?sll=$lat,$long');
    Uri googleUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$long');


    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else if (await canLaunchUrl(appleUrl)) {
      await launchUrl(appleUrl);
    } else if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
      // if (await canLaunchUrl(uri)) {
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  static launchURL(String toMailId) async {
    var url = 'mailto:$toMailId';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchCall(String phone ) async {
    log('ContactHelper', 'launchCall');
    var url = "tel://$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await  launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
  static launchSMS(String phone ) async {
    log('ContactHelper', 'launchSMS');
    var url = 'sms:$phone';

    if (await canLaunchUrl(Uri.parse(url))) {
      await  launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}