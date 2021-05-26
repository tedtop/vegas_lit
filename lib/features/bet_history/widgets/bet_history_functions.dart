String totalRisk({List<int> firstList, List<int> secondList}) {
  final firstListSum = firstList.isEmpty
      ? 0
      : firstList.reduce((value, element) => value + element);
  final secondListSum = secondList.isEmpty
      ? 0
      : secondList.reduce((value, element) => value + element);
  final totalSum = firstListSum + secondListSum;
  return totalSum.toString();
}
