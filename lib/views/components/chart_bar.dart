import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

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
    // final size = MediaQuery.of(context);

    var groupTitle = AutoSizeGroup();
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: maxHeight * .02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: maxHeight * .13,
                child: Center(
                  child: AutoSizeText(
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
                ),
              ),
              Container(
                height: maxHeight * .68,
                margin: EdgeInsets.symmetric(vertical: maxHeight * .01),
                width: maxWidth * .25,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
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
              SizedBox(
                height: maxHeight * .13,
                child: Center(
                  child: AutoSizeText(
                    label,
                    maxLines: 1,
                    minFontSize: 5,
                    maxFontSize: 12,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
