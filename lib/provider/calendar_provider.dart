import 'dart:math';

import 'package:flutter/material.dart';

import '../model/data_model.dart';

class CalendarProvider with ChangeNotifier {
  List<DataModel> _data = [];

  List<DataModel> get data {
    return [..._data];
  }

  createDataFromRange(DateTime startDate, DateTime endDate) {
    List<DataModel> loadedData = [];
    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      loadedData.add(
        DataModel(
          id: DateTime.now().toString(),
          date: currentDate,
          hrdCount: Random().nextInt(5),
          techCount: Random().nextInt(7),
          followUpCount: Random().nextInt(9),
        ),
      );
      currentDate = currentDate.add(const Duration(days: 1));
    }

    _data = loadedData;
    notifyListeners();
  }
}
