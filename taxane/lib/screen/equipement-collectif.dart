import 'package:flutter/material.dart';
import 'package:taxane/utils/color-by-dii.dart';

class EquipementCollectif extends StatefulWidget {
  const EquipementCollectif({Key? key}) : super(key: key);

  @override
  _EquipementCollectifState createState() => _EquipementCollectifState();
}

class _EquipementCollectifState extends State<EquipementCollectif> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: .0,
      ),
      backgroundColor: vert,
      body: Stack(),
    );
  }
}
