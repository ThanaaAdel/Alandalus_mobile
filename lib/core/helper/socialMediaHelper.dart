import 'package:url_launcher/url_launcher.dart';

class SocialMediaHelper {
  void openFacebookApp(String pageId) async {
    final url = 'fb://page/${pageId}'; // Replace 'your_page_id' with the Facebook Page ID or any other valid Facebook URL scheme

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openInstagramApp(String userName) async {
    final url = 'instagram://user?username=${userName}'; // Replace 'your_username' with the Instagram username or any other valid Instagram URL scheme

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openTwitterApp(String userName) async {
    final url = 'twitter://user?screen_name=${userName}'; // Replace 'your_username' with the Twitter username or any other valid Twitter URL scheme

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openSnapchatApp(String userName) async {
    final url = 'snapchat://add/${userName}'; // Replace 'username' with the Snapchat username or any other valid Snapchat URL scheme

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openWhatsApp(String phoneNumber) async {
    final url = 'https://wa.me/$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchPhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




}
