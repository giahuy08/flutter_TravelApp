import 'package:flutter/material.dart';

import 'enterprise_item.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: EnterpriseItem());
  }
}
