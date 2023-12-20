import 'package:flutter/material.dart';
import 'package:mahindra_test/model/data_model.dart';
import 'package:intl/intl.dart';

class MultiSelectionWidget extends StatelessWidget {
  final double dW;
  final DataModel data;
  const MultiSelectionWidget({
    super.key,
    required this.dW,
    required this.data,
  });

  Widget getTallyWidget({required int value, required String title}) {
    return Padding(
      padding: EdgeInsets.only(right: dW * 0.03),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: title == 'Total' ? Colors.black54 : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black38),
            ),
            child: Text(
              '${value > 9 ? value : '0$value'}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: title == 'Total' ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(height: dW * 0.005),
          Text(
            title,
            style: const TextStyle(fontSize: 12.5),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: dW * 0.03),
      padding: EdgeInsets.symmetric(vertical: dW * 0.035),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFE0E0E0),
            offset: Offset(3, 3),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: dW * 0.15,
            width: dW * 0.007,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Column(
            children: [
              Text(
                DateFormat('dd').format(data.date),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                DateFormat('MMM').format(data.date),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          getTallyWidget(
            value: data.hrdCount,
            title: "HRD",
          ),
          getTallyWidget(
            value: data.techCount,
            title: "Tech 1",
          ),
          getTallyWidget(
            value: data.followUpCount,
            title: "Follow up",
          ),
          getTallyWidget(
            value: data.hrdCount + data.techCount + data.followUpCount,
            title: "Total",
          )
        ],
      ),
    );
  }
}
