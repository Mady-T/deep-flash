import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Text('FAQ Content goes here'),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Text('About Us Content goes here'),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Text('Contact Us Content goes here'),
      ),
    );
  }
}

AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Testapp',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Pop the current screen
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 20,
            width: 20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            _handleMenuSelection(context, value);
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              value: 'faq',
              child: Text('FAQ'),
            ),
            PopupMenuItem<String>(
              value: 'about',
              child: Text('About Us'),
            ),
            PopupMenuItem<String>(
              value: 'contact',
              child: Text('Contact Us'),
            ),
          ],
          icon: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
  void _handleMenuSelection(BuildContext context, String value) {
    // Handle the selected option
    switch (value) {
      case 'faq':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FAQPage(),
          ),
        );
        break;
      case 'about':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutUsPage(),
          ),
        );
        break;
      case 'contact':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactUsPage(),
          ),
        );
        break;
    }
  }