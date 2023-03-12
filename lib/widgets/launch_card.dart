import 'package:flutter/material.dart';
import 'package:flutter_gql_spacex/helpers/common.dart';
import 'package:flutter_gql_spacex/helpers/types.dart';
import 'package:flutter_gql_spacex/widgets/custom_text.dart';
import 'custom_popup.dart';

class LaunchCard extends StatelessWidget {
  final LaunchType launchDetails;
  final bool? showFullDetails;

  const LaunchCard(
      {super.key, required this.launchDetails, this.showFullDetails = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.amber.shade50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomText(
                content: "Mission Name: ", textType: TextTypes.medium),
            CustomText(content: launchDetails.missionName),
            const SizedBox(height: 10),
            const CustomText(
                content: "Rocket Name: ", textType: TextTypes.medium),
            CustomText(content: launchDetails.rocketName),
            const SizedBox(height: 10),
            const CustomText(
                content: "Launch Date: ", textType: TextTypes.medium),
            CustomText(content: formatDate(launchDetails.launchDate)),
            const SizedBox(height: 10),
            const CustomText(
                content: "Launch details: ", textType: TextTypes.medium),
            CustomText(
              content: launchDetails.details.isNotEmpty
                  ? launchDetails.details
                  : "Sorry, no details found.",
              truncate: !showFullDetails!,
            ),
            const SizedBox(height: 15),
            if (!showFullDetails!)
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 15,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              CustomPopUp(launchDetails: launchDetails));
                    },
                    label: const Text("Read full details")),
              )
          ]),
        ),
      ),
    );
  }
}
