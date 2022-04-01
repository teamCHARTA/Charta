import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class ProductSnakbar extends StatefulWidget {
  final quantity;
  const ProductSnakbar({Key? key,required this.quantity}) : super(key: key);



  @override
  _ProductSnakbarState createState() => _ProductSnakbarState();
}

class _ProductSnakbarState extends State<ProductSnakbar> {
  var formkey = GlobalKey<FormState>();

  int quantity=0;


  @override
  Widget build(BuildContext context) {
    return Form(
        child:Column(
          children: [
            Text("Enter the quantity"),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Quantity",
                  labelText: "paper quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              validator: (text) {
                if (text!.isEmpty || text==0) {
                  return "please enter the Quantity";
                }if (text as int > widget.quantity) {
                  return "Order out of stock";
                }  else {
                  quantity = int.parse(text);
                  return null;
                }
              },
            ),


          ],

        ),



    );
  }
}
