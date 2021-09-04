import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

class MenuLeft extends StatelessWidget {
  final String test;
  final IconData icon;
  final bool isSelect;
  const MenuLeft({
    Key? key,
    required this.test,
    required this.icon,
    required this.isSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Spacer(),
          Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Row(
              children: [
                SizedBox(
                  width: constraints.maxWidth * .1,
                ),
                Container(
                  width: constraints.maxWidth * .9,
                  height: constraints.maxHeight,
                  child: Row(
                    children: [
                      Spacer(),
                      Icon(
                        icon,
                        color: isSelect ? vert : jaune,
                      ),
                      Spacer(),
                      Container(
                        width: constraints.maxWidth * .5,
                        child: Text(
                          test,
                          style: TextStyle(
                              fontSize: constraints.maxHeight * .26,
                              fontWeight: FontWeight.bold,
                              color: isSelect ? noir : blanc),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: isSelect ? beige : vert,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      )),
                )
              ],
            ),
          ),
          Spacer(),
        ],
      );
    });
  }
}
