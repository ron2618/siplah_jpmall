import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
            margin: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25),
            child: Icon(Icons.favorite_border),
          )
        ],
      ),
      body: LayoutDetails(),
    );
  }
}

class LayoutDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ProductDetailsAnimation(),
        // CustomBottomSheet()
      ],
    );
  }
}

class ProductDetailsAnimation extends StatefulWidget {
  @override
  _ProductDetailsAnimationState createState() => _ProductDetailsAnimationState();
}

class _ProductDetailsAnimationState extends State<ProductDetailsAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}