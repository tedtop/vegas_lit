import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pluto_grid/pluto_grid.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:vegas_lit/config/palette.dart';
import 'package:vegas_lit/config/styles.dart';
import 'package:vegas_lit/leaderboard/models/player.dart';
import 'package:vegas_lit/leaderboard/widgets/pagenumberview.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<PlutoRow> players = <PlutoRow>[];

  @override
  void initState() {
    super.initState();
    players = getData();
    //_employeeDataSource = EmployeeDataSource(playerData: players);
  }

  List<PlutoColumn> leaderboardPlayerColumn = [
    PlutoColumn(
        title: 'Rank',
        field: 'rank',
        type: PlutoColumnType.number(),
        width: 70,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Text(
            '${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
            maxLines: 1,
            style: const TextStyle(color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Player',
        field: 'player',
        type: PlutoColumnType.text(),
        width: 120,
        renderer: (rendererContext) {
          return Text(
            rendererContext.row.cells[rendererContext.column.field].value
                .toString(),
            style: const TextStyle(fontSize: 15, color: Palette.darkGrey),
          );
        },
        enableSorting: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Profit',
        field: 'profit',
        type: PlutoColumnType.text(),
        width: 120,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Text(
            '\$${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
            maxLines: 1,
            style: const TextStyle(color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Account Balance',
        field: 'accountBalance',
        type: PlutoColumnType.text(),
        width: 150,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Text(
            '\$${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
            maxLines: 1,
            style: const TextStyle(color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: '# of Bets',
        field: 'noOfBets',
        type: PlutoColumnType.number(),
        width: 95,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});
          return Text(
            rendererContext.row.cells[rendererContext.column.field].value
                .toString(),
            style: const TextStyle(fontSize: 15, color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: '# of Correct Bets',
        field: 'noOfCorrectBets',
        type: PlutoColumnType.number(),
        width: 140,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});
          return Text(
            rendererContext.row.cells[rendererContext.column.field].value
                .toString(),
            style: const TextStyle(fontSize: 15, color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Open Bets',
        field: 'openBets',
        type: PlutoColumnType.text(),
        width: 110,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Text(
            '\$${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
            maxLines: 1,
            style: const TextStyle(color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Potential Winnings',
        field: 'potentialWinnings',
        type: PlutoColumnType.text(),
        width: 145,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Text(
            '\$${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
            maxLines: 1,
            style: const TextStyle(color: Palette.darkGrey),
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Biggest Win',
        field: 'biggestWin',
        type: PlutoColumnType.text(),
        width: 120,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});

          return Row(
            children: [
              const Icon(
                FlutterIcons.coins_faw5s,
                color: Colors.yellow,
                size: 16,
              ),
              Text(
                '\$${rendererContext.row.cells[rendererContext.column.field].value.toString()}',
                maxLines: 1,
                style: const TextStyle(color: Palette.darkGrey),
              ),
            ],
          );
        },
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
    PlutoColumn(
        title: 'Last Week\'s Rank',
        field: 'lastWeeksRank',
        type: PlutoColumnType.number(),
        width: 130,
        renderer: (rendererContext) {
          if (rendererContext.row.cells[rendererContext.column.field].value ==
              'sortBytag')
            return IconButton(
                icon: const Icon(Icons.arrow_downward), onPressed: () {});
          return Text(
            rendererContext.row.cells[rendererContext.column.field].value
                .toString(),
            style: const TextStyle(fontSize: 15, color: Palette.darkGrey),
          );
        },
        textAlign: PlutoColumnTextAlign.right,
        enableSorting: true,
        enableColumnDrag: false,
        enableContextMenu: false,
        enableEditingMode: false,
        enableFilterMenuItem: false,
        enableHideColumnMenuItem: false,
        enableRowChecked: false,
        enableRowDrag: false,
        enableSetColumnsMenuItem: false),
  ];

  List<PlutoRow> getData() {
    //Use api here to get the data and
    //give it as an input to the next playerFromJson
    ////
    //final players = playerFromJson(jsonEncode([]));
    List<PlutoRow> playerRows = [];
    // players.forEach((player) {
    //   playerRows.add(player.toPlutoRow());
    // });
    playerRows = [
      PlutoRow(cells: {
        'rank': PlutoCell(value: 1),
        'player': PlutoCell(value: 'What'),
        'profit': PlutoCell(value: 3900.52),
        'accountBalance': PlutoCell(value: 4020.74),
        'noOfBets': PlutoCell(value: 127),
        'noOfCorrectBets': PlutoCell(value: 57),
        'openBets': PlutoCell(value: 480.00),
        'potentialWinnings': PlutoCell(value: 3341.61),
        'biggestWin': PlutoCell(value: 325.36),
        'lastWeeksRank': PlutoCell(value: 12),
      }),
      PlutoRow(cells: {
        'rank': PlutoCell(value: 2),
        'player': PlutoCell(value: 'kevin'),
        'profit': PlutoCell(value: 3682.45),
        'accountBalance': PlutoCell(value: 2893.65),
        'noOfBets': PlutoCell(value: 86),
        'noOfCorrectBets': PlutoCell(value: 35),
        'openBets': PlutoCell(value: 226.62),
        'potentialWinnings': PlutoCell(value: 3156.85),
        'biggestWin': PlutoCell(value: 567.68),
        'lastWeeksRank': PlutoCell(value: 18),
      }),
      PlutoRow(cells: {
        'rank': PlutoCell(value: 3),
        'player': PlutoCell(value: 'stuart'),
        'profit': PlutoCell(value: 3221.12),
        'accountBalance': PlutoCell(value: 5496.63),
        'noOfBets': PlutoCell(value: 59),
        'noOfCorrectBets': PlutoCell(value: 17),
        'openBets': PlutoCell(value: 681.86),
        'potentialWinnings': PlutoCell(value: 2862.89),
        'biggestWin': PlutoCell(value: 257.95),
        'lastWeeksRank': PlutoCell(value: 43),
      }),
      PlutoRow(cells: {
        'rank': PlutoCell(value: 4),
        'player': PlutoCell(value: 'bob'),
        'profit': PlutoCell(value: 2895.35),
        'accountBalance': PlutoCell(value: 3596.49),
        'noOfBets': PlutoCell(value: 256),
        'noOfCorrectBets': PlutoCell(value: 96),
        'openBets': PlutoCell(value: 296.96),
        'potentialWinnings': PlutoCell(value: 2532.45),
        'biggestWin': PlutoCell(value: 456.86),
        'lastWeeksRank': PlutoCell(value: 27),
      }),
    ];
    return playerRows;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Palette.darkGrey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'LEADERBOARD',
                    style: Styles.pageTitle,
                  ),
                ),
              ],
            ),
            ScreenTypeLayout(
              desktop: Container(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Current Leaderboard',
                          style: Styles.normalTextBold,
                        ),
                      ),
                      Expanded(child: Container()),
                      const TextBar(
                        text: 'Current Week',
                      ),
                      const TextBar(
                        text: 'All Leagues',
                      ),
                      const TextBar(
                        text: 'All Bet Types',
                      ),
                    ],
                  ),
                ),
              ),
              mobile: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 8),
                        child: Text(
                          'Current Leaderboard',
                          style: Styles.normalTextBold,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  const TextBar(
                    text: 'Current Week',
                  ),
                  const TextBar(
                    text: 'All Leagues',
                  ),
                  const TextBar(
                    text: 'All Bet Types',
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                color: Palette.lightGrey,
              ),
              child: Center(
                child: Text(
                  'CONTEST WINNINGS',
                  style: Styles.largeTextBold,
                ),
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 1220),
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Palette.green,
            ),
            Padding(
<<<<<<< HEAD
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.fill,
                  gridLinesVisibility: GridLinesVisibility.none,
                  source: _employeeDataSource,
                  columns: [
                    GridNumericColumn(
                      mappingName: 'id',
                      headerText: '#',
                      textAlignment: Alignment.center,
                      headerTextAlignment: Alignment.center,
                    ),
                    GridTextColumn(
                      mappingName: 'name',
                      headerText: 'Player',
=======
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 1220,
                    height: 450,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    constraints: const BoxConstraints(
                      minHeight: 450,
>>>>>>> 6e106fd... redesigned leaderboard
                    ),
                    child: PlutoGrid(
                      columns: leaderboardPlayerColumn,
                      rows: players,
                      configuration: PlutoGridConfiguration(
                          activatedColor: Palette.cream,
                          gridBorderColor: Palette.green,
                          rowHeight: 20,
                          scrollbarConfig: const PlutoGridScrollbarConfig(
                            isAlwaysShown: kIsWeb,
                            draggableScrollbar: true,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ScreenTypeLayout(
              mobile: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PageNumberView(pages: 15),
                  )
                ],
              ),
              desktop: Container(
                  margin: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(maxWidth: 1220),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PageNumberView(pages: 15),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  const TextBar({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Container(
            color: Palette.lightGrey,
            padding: const EdgeInsets.all(8.0),
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.nunito(
                    color: Palette.cream,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(
                  FontAwesome.angle_down,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
