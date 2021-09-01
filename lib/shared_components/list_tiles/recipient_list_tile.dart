import 'package:anonaddy/models/recipient/recipient_model.dart';
import 'package:anonaddy/screens/recipient_screen/recipient_detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global_providers.dart';
import '../custom_page_route.dart';

class RecipientListTile extends StatelessWidget {
  const RecipientListTile({Key? key, required this.recipientDataModel})
      : super(key: key);

  final Recipient recipientDataModel;

  @override
  Widget build(BuildContext context) {
    final recipientDataProvider = context.read(recipientStateManagerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.email_outlined,
              color: isDark ? Colors.white : Colors.grey[700],
              size: 30,
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recipientDataModel.email),
                SizedBox(height: 2),
                recipientDataModel.emailVerifiedAt == null
                    ? Text(
                        'Unverified',
                        style: TextStyle(color: Colors.red),
                      )
                    : Text(
                        'Verified',
                        style: TextStyle(color: Colors.green),
                      ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        recipientDataProvider.recipientDataModel = recipientDataModel;
        Navigator.push(
            context,
            CustomPageRoute(
                RecipientDetailedScreen(recipientData: recipientDataModel)));
      },
    );
  }
}
