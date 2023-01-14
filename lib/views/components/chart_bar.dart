import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.value,
    required this.percentage,
  });

  final String label;
  final double value;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    var groupTitle = AutoSizeGroup();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          AutoSizeText(
            // AppLocalizations.of(context)!.valor_produto(value),
            value.toStringAsFixed(2),
            maxLines: 1,
            minFontSize: 5,
            group: groupTitle,
            maxFontSize: 11,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SizedBox(
              height: 60,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.grey,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AutoSizeText(
            label,
            maxLines: 1,
            minFontSize: 5,
            maxFontSize: 12,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
