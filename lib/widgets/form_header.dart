import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      this.imageColor,
      this.imageHeight = 0.2,
      this.heightBetween,
      this.image,
      this.title,
      this.subTitle,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.textAlign});
  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String? image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(image!),
          color: imageColor,
          height: size.height * imageHeight,
        ),
        SizedBox(
          height: heightBetween,
        ),
        Text(
          title!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          subTitle!,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
