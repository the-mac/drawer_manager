import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
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

class WebViewContainer extends StatelessWidget {

  final String webViewUrl;

  const WebViewContainer(this.webViewUrl, {Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context) {

    return Container(
        child: WebView(
          initialUrl: webViewUrl,
          javascriptMode: JavascriptMode.unrestricted,
          debuggingEnabled: false,
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue)
        )
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context)
    );
  }
}

class TheMACPage extends StatelessWidget {

  static const shareURL = 'https://pub.dev/packages/drawer_manager';
  static const facebookURL = 'https://m.facebook.com/groups/694991294608697/';
  static const githubURL = 'https://github.com/the-mac';

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
            'View Drawer Manager',
            const Color(0xff0085E0),
            Icons.share,
            onTap: () {
                Navigator.push<void>(
                  context, MaterialPageRoute( builder: (BuildContext context) => const WebViewContainer(shareURL))
                );
            }
          ),
          SocialButton(
            'Check out our Facebook',
            const Color(0xff39579A),
            FontAwesomeIcons.facebookF,
            onTap: () {
                Navigator.push<void>(
                  context, MaterialPageRoute( builder: (BuildContext context) => const WebViewContainer(facebookURL))
                );
            }
          ),
          SocialButton(
            'Check out our Github',
            Colors.black,
            FontAwesomeIcons.github,
            onTap: () {
                Navigator.push<void>(
                  context, MaterialPageRoute( builder: (BuildContext context) => const WebViewContainer(githubURL))
                );
            }
          ),
        ],
      ),
    );
  }
}
