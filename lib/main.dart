import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(
      UserCard(
        AssetImage("images/face.png"),
        "John Doe",
        "Description",
        "123 456 7890",
        "example@domain.com",
      ),
    );

class UserCard extends StatelessWidget {
  final AssetImage image;
  final String name;
  final String description;
  final String number;
  final String email;
  final ThemeData themeData;

  const UserCard(
      this.image, this.name, this.description, this.number, this.email,
      {this.themeData});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = themeData ??
        ThemeData(
          backgroundColor: Colors.teal,
          primaryColor: Colors.white,
          primaryColorDark: Colors.teal.shade800,
          primaryColorLight: Colors.tealAccent.shade700,
          cardColor: Colors.white,
        );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: new MaterialApp(
        home: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Avatar(image, 50.0),
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      description.toUpperCase(),
                      style: TextStyle(
                        fontFamily: "Josefin Sans",
                        fontSize: 15.0,
                        color: theme.primaryColorLight,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                    width: 500.0,
                    child: Divider(
                      thickness: 1.5,
                      color: theme.primaryColorLight,
                      indent: 150,
                      endIndent: 150,
                    ),
                  ),
                  InfoButton(
                    Icons.phone,
                    number,
                    theme.primaryColorDark,
                    theme.cardColor,
                    () => launch("tel:$number"),
                  ),
                  InfoButton(
                    Icons.mail_outline,
                    email,
                    theme.primaryColorDark,
                    theme.cardColor,
                    () => launch("mailto:$email"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final AssetImage avatar;
  final double radius;

  const Avatar(this.avatar, this.radius);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        image: DecorationImage(
          image: avatar,
        ),
        boxShadow: [
          new BoxShadow(
            color: Colors.black,
            offset: const Offset(0.0, 15.0),
            blurRadius: 12.0,
            spreadRadius: -20.0,
          ),
        ],
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color cardColor;
  final Function callback;

  const InfoButton(
      this.icon, this.text, this.textColor, this.cardColor, this.callback);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      color: cardColor,
      margin: EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 5.0,
      ),
      child: InkWell(
        onTap: () {
          this.callback();
        },
        child: ListTile(
          leading: Icon(
            this.icon,
            size: 35,
            color: textColor,
          ),
          title: Text(
            this.text,
            style: TextStyle(
              fontFamily: "Josefin Sans",
              fontSize: 19.0,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
