import 'package:flutter/material.dart';

class RadioButtonGenerator extends StatelessWidget {
  const RadioButtonGenerator(
      {super.key,
      required this.color,
      required this.title,
      required this.info,
      required this.amount,
      required this.radioWidget,
      required this.icon});

  final Color color;
  final Widget icon;
  final String title;
  final String info;
  final int amount;
  final Widget radioWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color.withOpacity(0.1)),
            child: icon
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  info,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.5)),
                )
              ],
            ),
          ),
          Text(
            '\$ $amount',
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          radioWidget,
        ],
      ),
    );
  }
}
