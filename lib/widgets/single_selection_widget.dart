import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleSelectionWidget extends StatelessWidget {
  final double dW;
  final String priority;
  const SingleSelectionWidget({
    super.key,
    required this.dW,
    required this.priority,
  });

  Widget getTrailingWidget({
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 12),
        ),
        SizedBox(height: dW * 0.01),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

  void launchCall(mobileNumber) async {
    var url = Uri.parse('tel:$mobileNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('could not launch ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dW,
      margin: EdgeInsets.only(bottom: dW * 0.03),
      padding: EdgeInsets.symmetric(vertical: dW * 0.04, horizontal: dW * 0.05),
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Balram Naik',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: dW * 0.01),
              const Text(
                'ID: KJ12NM123ZSA',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13.5,
                ),
              ),
              SizedBox(height: dW * 0.02),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(text: 'Offered:  '),
                    TextSpan(
                      text: '\u20b9X,XX,XXX',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Poppins',
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(text: 'Current:  '),
                    TextSpan(
                      text: '\u20b9X,XX,XXX',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: dW * 0.025),
              Row(
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor:
                        priority == 'Medium' ? Colors.orange : Colors.pink,
                  ),
                  SizedBox(width: dW * 0.02),
                  Text(
                    '$priority Priority',
                    style: TextStyle(
                      color: priority == 'Medium' ? Colors.orange : Colors.pink,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              SizedBox(height: dW * 0.01),
              const Divider(color: Colors.black45),
              SizedBox(height: dW * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getTrailingWidget(
                    title: 'Due Date',
                    value: DateFormat('dd MMM yy')
                        .format(DateTime.now().add(const Duration(days: 30))),
                  ),
                  getTrailingWidget(title: 'Level', value: '10'),
                  getTrailingWidget(title: 'Days Left', value: '30 days'),
                ],
              )
            ],
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () => launchCall('1234567890'),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
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
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
