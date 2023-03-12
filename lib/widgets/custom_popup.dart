import 'package:flutter/material.dart';
import 'package:flutter_gql_spacex/helpers/types.dart';
import 'launch_card.dart';

class CustomPopUp extends StatelessWidget {
  const CustomPopUp({
    super.key,
    required this.launchDetails,
  });

  final LaunchType launchDetails;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: SizedBox(
          width: screenWidth < 600
              ? screenWidth * 0.8
              : screenWidth < 1200
                  ? screenWidth * 0.6
                  : screenWidth * 0.4,
          child: LaunchCard(
            launchDetails: launchDetails,
            showFullDetails: true,
          )),
      actions: [
        Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.close,
                  size: 15,
                ),
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red)),
                onPressed: () {
                  Navigator.pop(context);
                },
                label: const Text("Close")))
      ],
    );
  }
}
