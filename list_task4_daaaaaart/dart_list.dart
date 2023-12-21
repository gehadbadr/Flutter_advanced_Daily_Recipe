void main() {
//----------------task 1---------
  List mylist = <int>[1, 1, 2, 3, 4, 5, 8, 13, 21, 34, 55, 89];
  print('Tsak 1 ==============>');
  for (var i = 0; i < mylist.length; i++) {
    if (mylist[i] < 5) {
      print(mylist[i]);
    }
  }
//----------------task 2---------
  List mylist2 = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];
  List reslist = <int>[];
  for (var i = 0; i < mylist.length; i++) {
    for (var j = 0; j < mylist2.length; j++) {
      if (mylist[i] == mylist2[j]) {
        reslist.add(mylist[i]);
      }
    }
  }
  var reslistWithoutDaplicate = reslist.toSet().toList();
  print('Tsak 2 ==============>');
  print(reslistWithoutDaplicate);

  //----------------task 3---------
  List mylist3 = <int>[1, 4, 9, 16, 25, 36, 49, 64, 81, 100];
  List evenlist = <int>[];
  for (final i in mylist3) {
    if (i.isEven) {
      evenlist.add(i);
    }
  }
  print('Tsak 3 ==============>');
  print(evenlist);

  //----------------task 4---------
  List mylist4 = <int>[5, 10, 15, 20, 25];
  print('Tsak 4 ==============>');
  firstAndLast(mylist4);
}

void firstAndLast(List myList) {
  List res = <int>[];
  res.add(myList.first);
  res.add(myList.last);
  print(res);
}
