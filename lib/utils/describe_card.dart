import 'package:chronomap_mobile/utils/shadowed_container.dart';
import 'package:flutter/material.dart';

class CustomTextContainer extends StatelessWidget {
  final String textContent;

  const CustomTextContainer({
    super.key,
    required this.textContent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 12, 30, 12),
      child: ShadowedContainer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              textContent,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
