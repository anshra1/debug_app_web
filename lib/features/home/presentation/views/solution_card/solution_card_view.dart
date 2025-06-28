import 'package:debug_app_web/features/home/presentation/views/home_page_view.dart';
import 'package:flutter/material.dart';

class SolutionCardView extends StatelessWidget {
  const SolutionCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(right: 16,bottom: 16),
          child: Container(
           
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView(
              shrinkWrap: true,
              children: const [
                Text(stackTrace),
                Text(stackTrace),
                Text(stackTrace),
                Text(stackTrace),
                Text(stackTrace),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
