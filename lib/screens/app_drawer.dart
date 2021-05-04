import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    bool isUserAuthenticated = false;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _AppBarHeader(),
                  ...(isUserAuthenticated ? signedInList() : signedOutList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// List of tiles to show when user is Signed Out
  List<Widget> signedOutList() {
    return [
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/login");
        },
        child: ListTile(
          title: Text(
            "Sign Up or Log In",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ),
      SizedBox(height: 5),
      InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            "/web_view_screen",
          );
        },
        child: ListTile(
          title: Text(
            'Terms of Service',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      SizedBox(height: 5),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/web_view_screen");
        },
        child: ListTile(
          title: Text(
            'Privacy Policy',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    ];
  }

  /// List of tiles to show when user is Signed In
  List<Widget> signedInList() {
    return [
      SizedBox(height: 15),
      getMenuItems("Orders", "assets/drawer/order.png", "/order_history"),
      SizedBox(height: 5),
      getMenuItems("Favourites", "assets/drawer/fav.png", "/favorites"),
      SizedBox(height: 5),
      SizedBox(height: 5),
      getMenuItems("Addresses", "assets/drawer/address.png", "/user_addresses"),
      SizedBox(height: 5),
      SizedBox(height: 5),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/web_view_screen");
        },
        child: ListTile(
          title: Text(
            'Terms of Service',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      SizedBox(height: 5),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/web_view_screen");
        },
        child: ListTile(
          title: Text(
            'Privacy Policy',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      SizedBox(height: 5),
      FlatButton(
        padding: EdgeInsets.only(left: 0),
        child: ListTile(
          title: Text(
            'Sign Out',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        onPressed: () async {
          setState(
              () {}); // TODO: Can remove this setState to make this widget stateless?
        },
      ),
    ];
  }

  Widget getMenuItems(
    String title,
    String icon,
    String redirectScreen, [
    bool requireAuth = true,
  ]) {
    return InkWell(
      child: ListTile(
        leading: Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ),
      onTap: () {
        if (requireAuth) {
          Navigator.pushNamed(context, "/login");
        } else {
          Navigator.of(context).pushNamed(redirectScreen);
        }
      },
    );
  }
}

class _AppBarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Icon(Icons.ac_unit)),
        SizedBox(height: 20),
      ],
    );
  }
}
