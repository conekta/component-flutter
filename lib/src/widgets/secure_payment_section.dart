import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:conekta_component/src/utils/colors.dart';
import 'package:conekta_component/src/utils/dark-colors.dart';
import '../../l10n/app_localizations.dart';

class SecurePaymentSection extends StatelessWidget {
  const SecurePaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final logoUrl = isDarkMode ? DarkAppColors.logoUrl : AppColors.logoUrl;
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
              const SizedBox(width: 4.0), // Adjust spacing as needed
            ],
          ),
          const SizedBox(height: 8.0), // Adjust spacing as needed
          SvgPicture.network(
            logoUrl,
            height: 20.0, // Adjust size as needed
            color: isDarkMode ? Colors.white : null,
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
