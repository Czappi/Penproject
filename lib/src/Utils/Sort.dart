List<String> alphabeticSort(List<String> list) {
  list.sort((a, b) => a.toString().compareTo(b.toString()));
  return list;
}

List<double> ascendingSort(List<double> list) {
  list.sort((a, b) => a.compareTo(b));
  return list;
}

List<double> descendingSort(List<double> list) {
  list.sort((b, a) => a.compareTo(b));
  return list;
}
