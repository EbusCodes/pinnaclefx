import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final int amount;
  final int days;

  const MyRadioListTile({
    required this.days,
    required this.amount,
    required this.value,
    required this.groupValue,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: radioItem(context)
    );
  }

radioItem(BuildContext context) {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: isSelected ? BoxDecoration(
        color: Color.fromRGBO(33, 17, 71, 0.5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
      )  : BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$days days',
            style: TextStyle(
                color: Color.fromRGBO(33, 17, 71, 1),
                fontWeight: FontWeight.w400,
                fontSize: 15.sp),
          ),
          FittedBox(
            child: Text(
              '\$${((amount * 0.45 * days / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
              style: TextStyle(
                  color: Color.fromRGBO(33, 17, 71, 1),
                  fontWeight: FontWeight.w700,
                  fontSize: 15.sp),
            ),
          )
        ],
      ),
    );
}
}
