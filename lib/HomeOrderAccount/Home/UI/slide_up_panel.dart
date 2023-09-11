import 'package:delivoo/Components/entry_field.dart';
import 'package:delivoo/Routes/routes.dart';
import 'package:delivoo/Themes/colors.dart';
import 'package:flutter/material.dart';

class SlideUpPanel extends StatefulWidget {
  final List<String> itemName;

  SlideUpPanel(this.itemName);

  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  List<String> weight = [
    '1kg x 1',
    '1kg x 1',
    '1kg x 1',
  ];
  List<double> prices = [
    3.00,
    4.50,
    2.50,
  ];

  double sum() {
    double total = 0.00;
    for (int i = 0; i < prices.length; i++) {
      total += prices[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.15,
      initialChildSize: 0.15,
      maxChildSize: 0.975,
      builder: (context, controller) {
        return Container(
          padding: EdgeInsets.only(left: 4.0),
          color: kCardBackgroundColor,
          child: SingleChildScrollView(
            controller: controller,
            child: Container(
              height: MediaQuery.of(context).size.height - 300.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: 'Delivery Boy',
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0, top: 14.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 22.0,
                                backgroundImage: AssetImage('images/profile.png'),
                              ),
                              title: Text(
                                'George Anderson',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              subtitle: Text(
                                'Delivery Partner',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        fontSize: 11.7,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffc2c2c2)),
                              ),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.message,
                                          color: kMainColor),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, PageRoutes.chatPage);
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.phone, color: kMainColor),
                                      onPressed: () {
                                        /*.......*/
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Hero(
                            tag: 'arrow',
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.itemName.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              widget.itemName[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0),
                            ),
                            subtitle: Text(
                              weight[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 13.3),
                            ),
                            trailing: Text(
                              '\$ ${prices[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(fontSize: 13.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    color: Colors.white,
                    child: EntryField(
                      image: 'images/custom/ic_instruction.png',
                      initialValue: 'Keep tomatoes in separate bag please.',
                      readOnly: true,
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Text('PAYMENT INFO',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: kDisabledColor,
                            fontSize: 13.3,
                            letterSpacing: 0.67)),
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Sub Total',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            '\$ ${sum()}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ]),
                  ),
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Service Fee',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            '\$ 1.50',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ]),
                  ),
                  Container(
                    color: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cash on Delivery',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            '\$ 11.50',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
