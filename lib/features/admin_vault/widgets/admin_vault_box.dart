import 'package:flutter/material.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/data/models/vault_data.dart';

class AdminRecordBox extends StatelessWidget {
  AdminRecordBox({this.item});
  final VaultItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 380,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item.date == 'cumulative'
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      'Total',
                      style: Styles.normalTextBold,
                      textAlign: TextAlign.start,
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: Text(
                      'Date: ${item.date}',
                      style: Styles.normalTextBold,
                      textAlign: TextAlign.start,
                    ),
                  ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Palette.cream),
                  color: Palette.lightGrey),
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Bets', style: Styles.greenText),
                        width: 120,
                      ),
                      Expanded(
                          child: Text(item.numberOfBets.toString(),
                              style: Styles.normalText))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Money In', style: Styles.greenText),
                        width: 120,
                      ),
                      Expanded(
                          child: Text('\$${item.moneyIn.toString()}',
                              style: Styles.normalText))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Money Out', style: Styles.greenText),
                        width: 120,
                      ),
                      Expanded(
                          child: Text('\$${item.moneyOut.toString()}',
                              style: Styles.normalText))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: Text('Profit', style: Styles.greenText),
                        width: 120,
                      ),
                      Expanded(
                          child: Text('\$${item.totalProfit.toString()}',
                              style: Styles.normalText))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
