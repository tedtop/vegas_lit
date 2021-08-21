import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../config/palette.dart';
import '../../../config/styles.dart';
import '../../../data/models/vault_data.dart';

class AdminVaultDailyList extends StatelessWidget {
  const AdminVaultDailyList({Key key, @required this.vaultItem})
      : super(key: key);

  final VaultItem vaultItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: AutoSizeText(
              'Date: ${vaultItem.date}',
              style: Styles.normalTextBold,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Palette.cream),
              color: Palette.lightGrey,
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Bets', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        vaultItem.totalBets.toString(),
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Money In', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.moneyIn.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Money Out', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.moneyOut.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Profit', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.totalProfit.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminVaultCumulativeTile extends StatelessWidget {
  const AdminVaultCumulativeTile({Key key, @required this.vaultItem})
      : super(key: key);

  final VaultItem vaultItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: AutoSizeText(
              'Total',
              style: Styles.normalTextBold,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Palette.cream),
              color: Palette.lightGrey,
            ),
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Bets', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        vaultItem.totalBets.toString(),
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Money In', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.moneyIn.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Money Out', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.moneyOut.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      child: AutoSizeText('Profit', style: Styles.greenText),
                      width: 120,
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '${vaultItem.totalProfit.toString()}',
                        style: Styles.normalText,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
