import 'package:flutter/material.dart';
import '../Widgets/kullandığım_ilaçlar_list.dart';

class KullandigimIlaclar extends StatefulWidget {
  static const routeName = '/kullandigim-ilaclar';
  @override
  _KullandigimIlaclarState createState() => _KullandigimIlaclarState();
}

class _KullandigimIlaclarState extends State<KullandigimIlaclar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(),
      body: UsedMeds(),
    );
  }
}
