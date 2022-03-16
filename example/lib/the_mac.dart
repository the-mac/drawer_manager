import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends InkWell {
  SocialButton(String title, Color color, IconData icon, {Key? key, required Function() onTap})
      : super(
          key: key,
          onTap: onTap,
          child: Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(Radius.circular(10))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)
                    ),
                ),
              ],
            ),
          )
        );
}

class TheMACPage extends StatelessWidget {
  const TheMACPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: const Text(
              'Welcome to\nThe Mobile Apps Community!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff0085E0),
                  fontSize: 28,
                  fontWeight: FontWeight.bold)
              ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          Image.asset(
            'assets/the-mac-avatar.jpeg',
            height: 250,
          ),
          SocialButton(
            'Share Driver Manager',
            const Color(0xff0085E0),
            Icons.share,
            onTap: () {
                Share.share('https://pub.dev/packages/drawer_manager', subject: 'Check out our package on pub.dev!');
            }
          ),
          SocialButton(
            'Check out our Facebook',
            const Color(0xff39579A),
            FontAwesomeIcons.facebookF,
            onTap: () {

            }
          ),
          SocialButton(
            'Check out our Github',
            Colors.black,
            FontAwesomeIcons.github,
            onTap: () {

            }
          ),
        ],
      ),
    );
  }
}
