import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxHeight = constraints.maxHeight;
      final maxWidth = constraints.maxWidth;

      return Container(
        height: maxHeight * .30,
        width: maxWidth,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/zzz.svg",
              semanticsLabel: "zzz",
              color: Colors.black,
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: AutoSizeText(
                "Nenhuma transação cadastrada",
                maxFontSize: 12,
                minFontSize: 1,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
