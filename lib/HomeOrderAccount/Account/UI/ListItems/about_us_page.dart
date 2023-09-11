import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text('About Us', style: Theme.of(context).textTheme.bodyText1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(48.0),
                color: kCardBackgroundColor,
                child: Image(
                  image:
                      AssetImage("images/logos/logo_user.png"), //delivoo logo
                  height: 130.0,
                  width: 99.7,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'About Delivoo',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque pulvinar porta sagittis. Sed id varius magna. Etiam felis neque, gravida vitae elementum non, consequat eu odio. Mauris cursus commodo nisi sed imperdiet. Fusce vitae vehicula ipsum, ut commodo lorem. Praesent interdum blandit condimentum. Curabitur vel orci vitae odio congue facilisis eget eget diam.\n\nNam a arcu efficitur, ornare leo eu, euismod leo. Vestibulum porttitor varius leo, eget posuere felis congue vel. Sed sit amet erat quam. Mauris et ex sapien. Sed venenatis, felis sed eleifend vulputate, mauris libero pretium urna, non hendrerit urna quam vitae justo. Maecenas rhoncus lectus consectetur eros pretium feugiat.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      '\nOur Vision',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque pulvinar porta sagittis. Sed id varius magna. Etiam felis neque, gravida vitae elementum non, consequat eu odio. Mauris cursus commodo nisi sed imperdiet. Fusce vitae vehicula ipsum, ut commodo lorem. Praesent interdum blandit condimentum. Curabitur vel orci vitae odio congue facilisis eget eget diam. Nam a arcu efficitur, ornare leo eu, euismod leo. Vestibulum porttitor varius leo, eget posuere felis congue vel. Sed sit amet erat quam. Mauris et ex sapien. Sed venenatis, felis sed eleifend vulputate, mauris libero pretium urna, non hendrerit urna quam vitae justo. Maecenas rhoncus lectus consectetur eros pretium feugiat.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
