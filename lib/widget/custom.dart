import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pipmovie/material/color.dart';

class Search extends StatefulWidget {

  const Search({ Key key }) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 2),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide( color: Colors.grey,),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.orange),
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 0),
            hintText: "Cari judul film" ,
            hintStyle: TextStyle(color: theme),
            icon: Icon(Icons.movie_filter,
              color: theme,
              size: 40,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: theme,),
              onPressed: null,
            )
          ),
          
        ),
      ),
    );
  }
}

class CardMovie extends StatelessWidget {
  final String title; final String rate; final String img;
  const CardMovie({ Key key, this.title, this.rate, this.img }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          Card(
            elevation: 0.0,
            child:Image.network(img,fit: BoxFit.fill,width: 130.0,height: 160.0,),
          ),
          SizedBox(height: 5.0,),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            rate,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,            
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Function onpress;
  final String banner;
  final String title;
  final String rate;
  final String date;
  final bool loading;
  const InfoCard({
    Key key,
    this.title,
    this.rate,
    this.banner,
    this.date,
    this.loading,
    this.onpress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double radius = 8.0;
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 8),
        child: Container(
          decoration: BoxDecoration(
            color: theme,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3),
                color: Colors.black.withOpacity(0.15),
                blurRadius: 8
              )
            ],
            borderRadius: BorderRadius.circular(radius),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(radius)
                ),
                child: loading ? Center(child: CircularProgressIndicator()) : Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    banner,
                    fit: BoxFit.cover,
                  )
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,            
                    ),
                  ),
                  Text(date,
                    style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 14.0,            
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rate_sharp, color: Colors.orange,),
                      SizedBox(width: 2,),
                      Text(rate,
                        style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      
                      )
                      )
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ShadowDirection {
  topLeft,
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
  center,
}

class CustomContainer extends StatelessWidget {
  final double borderRadius;
  final double elevation;
  final double height;
  final double width;
  final Border border;
  final BorderRadius customBorders;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;
  final Color color;
  final Color shadowColor;
  final List<BoxShadow> boxShadows;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDoubleTap;
  final BoxShape boxShape;
  final AlignmentGeometry alignment;
  final ShadowDirection shadowDirection;
  final Color rippleColor;
  final bool animate;
  final Duration duration;
  const CustomContainer({
    Key key,
    this.child,
    this.border,
    this.color = Colors.transparent,
    this.borderRadius = 0.0,
    this.elevation = 0.0,
    this.rippleColor,
    this.shadowColor = Colors.black12,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.height,
    this.width,
    this.margin,
    this.customBorders,
    this.alignment,
    this.boxShadows,
    this.animate = false,
    this.duration = const Duration(milliseconds: 200),
    this.boxShape = BoxShape.rectangle,
    this.shadowDirection = ShadowDirection.bottomRight,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  static const double WRAP = -1;
  static const double EXPAND = -2;

  bool get circle => boxShape == BoxShape.circle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final w = width == null || width == EXPAND ? double.infinity : width == WRAP ? null : width;
    final h = height == EXPAND ? double.infinity : height;
    final br = customBorders ??
        BorderRadius.circular(
          boxShape == BoxShape.rectangle ? borderRadius : w != null ? w / 2.0 : h != null ? h / 2.0 : 0,
        );

    Widget content = Padding(
      padding: padding,
      child: child,
    );

    if (boxShape == BoxShape.circle || (customBorders != null || borderRadius > 0.0)) {
      content = ClipRRect(
        borderRadius: br,
        child: content,
      );
    }

    content = Material(
      color: Colors.transparent,
      type: MaterialType.transparency,
      shape: circle ? const CircleBorder() : RoundedRectangleBorder(borderRadius: br),
      child: InkWell(
        splashColor: onTap != null ? rippleColor ?? theme.splashColor : Colors.transparent,
        customBorder: circle ? const CircleBorder() : RoundedRectangleBorder(borderRadius: br),
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        child: content,
      ),
    );

    final List<BoxShadow> boxShadow = boxShadows ?? elevation != 0
        ? [
            BoxShadow(
              color: shadowColor ?? Colors.black12,
              offset: _getShadowOffset(min(elevation / 5.0, 1.0)),
              blurRadius: elevation,
              spreadRadius: 0,
            ),
          ]
        : const [];

    final boxDecoration = BoxDecoration(
      color: color,
      borderRadius: circle ? null : br,
      shape: boxShape,
      boxShadow: boxShadow,
      border: border,
    );

    return animate
        ? AnimatedContainer(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            duration: duration,
            decoration: boxDecoration,
            child: content,
          )
        : Container(
            height: h,
            width: w,
            margin: margin,
            alignment: alignment,
            decoration: boxDecoration,
            child: content,
          );
  }

  Offset _getShadowOffset(double ele) {
    final ym = 5 * ele;
    final xm = 2 * ele;
    switch (shadowDirection) {
      case ShadowDirection.topLeft:
        return Offset(-1 * xm, -1 * ym);
        break;
      case ShadowDirection.top:
        return Offset(0, -1 * ym);
        break;
      case ShadowDirection.topRight:
        return Offset(xm, -1 * ym);
        break;
      case ShadowDirection.right:
        return Offset(xm, 0);
        break;
      case ShadowDirection.bottomRight:
        return Offset(xm, ym);
        break;
      case ShadowDirection.bottom:
        return Offset(0, ym);
        break;
      case ShadowDirection.bottomLeft:
        return Offset(-1 * xm, ym);
        break;
      case ShadowDirection.left:
        return Offset(-1 * xm, 0);
        break;
      default:
        return Offset.zero;
        break;
    }
  }
}
