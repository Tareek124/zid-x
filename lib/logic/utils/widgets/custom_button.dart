import 'package:flutter/material.dart';
import '../../../constants/colors.dart';
import '../functions/custom_size.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? function;
  const CustomButton({Key? key, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 60,
        width: CustomSize.width,
        decoration: BoxDecoration(
          color: darkOrange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CustomSignInButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Function()? function;
  const CustomSignInButton(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 60,
        width: CustomSize.width! * 0.45,
        decoration: BoxDecoration(
          border: Border.all(
            color: green,
            width: 3,
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            SizedBox(
              height: 45,
              child: Image.asset("assets/images/$imageUrl"),
            ),
            const SizedBox(width: 35),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
