// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mahindra_test/model/data_model.dart';
import 'package:mahindra_test/provider/calendar_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'widgets/multiple_selection_widget.dart';
import 'widgets/single_selection_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CalendarProvider())],
      child: MaterialApp(
        title: 'Mahindra Finance Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double dW = 0;
  double dH = 0;

  String selectedType = 'Day';
  String selectedTab = 'All';
  DateTime selectedDate = DateTime.now();

  final DatePickerController _controller = DatePickerController();
  List<DataModel> listOfData = [];

  DateTime startRange = DateTime.now();
  DateTime endRange = DateTime.now().add(const Duration(days: 7));

  Widget getOptionWidget({required String title}) {
    return GestureDetector(
      onTap: () {
        selectedType = title;
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: dW * 0.03),
        decoration: BoxDecoration(
          color: selectedType == title
              ? Theme.of(context).primaryColor
              : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedType != title
                ? Theme.of(context).primaryColor
                : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  int getCount(String tab) {
    int count = 0;
    if (tab == 'All') {
      for (var data in listOfData) {
        count += data.hrdCount + data.techCount + data.followUpCount;
      }
    } else if (tab == 'HRD') {
      for (var data in listOfData) {
        count += data.hrdCount;
      }
    } else if (tab == 'Tech 1') {
      for (var data in listOfData) {
        count += data.techCount;
      }
    } else if (tab == 'Follow up') {
      for (var data in listOfData) {
        count += data.followUpCount;
      }
    }
    return count;
  }

  void selectDateRange() async {
    DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2018),
      lastDate: DateTime(2200),
      currentDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: startRange, end: endRange),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (selectedRange != null) {
      startRange = selectedRange.start;
      endRange = selectedRange.end;
      createDateRange();
    }
  }

  createDateRange() {
    Provider.of<CalendarProvider>(context, listen: false)
        .createDataFromRange(startRange, endRange);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0))
        .then((value) => createDateRange());
  }

  @override
  Widget build(BuildContext context) {
    dW = MediaQuery.of(context).size.width;
    dH = MediaQuery.of(context).size.height;
    listOfData = Provider.of<CalendarProvider>(context).data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Calendar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
                vertical: dW * 0.025, horizontal: dW * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getOptionWidget(title: 'Day'),
                getOptionWidget(title: 'Week'),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: selectedType == 'Week'
          ? Padding(
              padding: EdgeInsets.only(bottom: dW * 0.03),
              child: FloatingActionButton.extended(
                onPressed: selectDateRange,
                extendedPadding: EdgeInsets.symmetric(horizontal: dW * 0.03),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                label: const Text(
                  'Select Date Range',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            )
          : const SizedBox.shrink(),
      body: SizedBox(
        height: dH,
        width: dW,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedType == 'Day')
                Container(
                  padding: EdgeInsets.symmetric(vertical: dW * 0.035),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                  ),
                  width: dW,
                  child: DatePicker(
                    DateTime.now(),
                    height: dW * 0.2,
                    width: dW * 0.15,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: Theme.of(context).primaryColor,
                    selectedTextColor: Colors.white,
                    dateTextStyle: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600),
                    dayTextStyle: const TextStyle(
                        fontSize: 11.5, fontWeight: FontWeight.w600),
                    monthTextStyle: const TextStyle(
                        fontSize: 11.5, fontWeight: FontWeight.w600),
                    controller: _controller,
                    daysCount: 90,
                    onDateChange: (date) {
                      selectedDate = date;
                      setState(() {});
                    },
                  ),
                ),
              SizedBox(height: dW * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...['All', 'HRD', 'Tech 1', 'Follow up'].map(
                    (tab) => CustomTab(
                      title: '$tab(${getCount(tab)})',
                      id: tab,
                      selectedId: selectedTab,
                      dW: dW,
                    ),
                  ),
                ],
              ),
              SizedBox(height: dW * 0.05),
              if (selectedType == 'Day') ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
                  child: SingleSelectionWidget(dW: dW, priority: "Medium"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
                  child: SingleSelectionWidget(dW: dW, priority: "High"),
                ),
              ],
              if (selectedType == 'Week') ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dW * 0.05),
                  child: Column(
                    children: [
                      ...listOfData.map(
                        (data) => MultiSelectionWidget(dW: dW, data: data),
                      )
                    ],
                  ),
                ),
              ],
              SizedBox(height: dW * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String title;
  final String id;
  final String selectedId;
  final double dW;
  final bool applyRightMargin;
  const CustomTab({
    super.key,
    required this.title,
    required this.id,
    required this.selectedId,
    required this.dW,
    this.applyRightMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedId == id;
    return Container(
      padding:
          EdgeInsets.only(bottom: dW * 0.01, left: dW * 0.04, right: dW * 0.04),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2.5,
          ),
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          title,
          style: TextStyle(
            fontSize: isSelected ? 14 : 13,
            color: isSelected ? Colors.black : Colors.black,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
