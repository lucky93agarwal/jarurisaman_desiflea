import 'package:flutter/material.dart';
import 'package:delivoo/Pages/refer_page.dart';

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 380,
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Stack(children: [

                  Image.asset(
                    'images/logos/popupimg.png',
                    height: 300,
                    width: double.infinity,
                  ),
                  new Positioned(
                    left: 270.0,
                    child: InkWell(onTap: (){
                      Navigator.of(context).pop();
                    },child: Icon(Icons.cancel_outlined, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)
                    ),)




                  ),

                ],)





              ),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),



            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
//            FlatButton(onPressed: (){
//              Navigator.of(context).pop();
//            }, child: Text('No'),textColor: Colors.white,),
//            SizedBox(width: 8,),
                Container(
                  width: 150,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);





                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReferPageActivity()),
                      );
                    },
                    child: Text('CONTINUE'),
                    color: Color(0xffFB6202),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
