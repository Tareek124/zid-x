main() {
  List fristlist = [10, 20, 30, 40, 50, 55, 65, 75];
  List Secondlist = [20, 25, 35, 65, 50, 55, 75, 80];
  dynamic thirlist = fristlist + Secondlist;
  Set.from(thirlist);
  print(Set.from(thirlist));
}
