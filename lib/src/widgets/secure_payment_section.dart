import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../l10n/app_localizations.dart';

class SecurePaymentSection extends StatelessWidget {
  const SecurePaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.paySafeWithConekta.toUpperCase(),
                style: theme.textTheme.labelSmall,
              ),
              const Spacer(), // Pushes the icon to the right
              Icon(
                Icons.info_outline,
                size: 16.0,
                color: theme.primaryColor, // Adjust color as needed
              ),
              const SizedBox(width: 4.0), // Adjust spacing as needed
            ],
          ),
          const SizedBox(height: 8.0), // Adjust spacing as needed
          SvgPicture.network(
            'https://assets.conekta.com/cpanel/statics/assets/img/conekta-logo-blue-full.svg',
            height: 20.0, // Adjust size as needed
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: Divider(
              color: theme.colorScheme.shadow,
            ),
          ),
        ],
      ),
    );
  }
}
