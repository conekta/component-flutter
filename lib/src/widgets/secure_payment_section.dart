import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../l10n/app_localizations.dart';
import '../utils/theme_extensions.dart';

class SecurePaymentSection extends StatelessWidget {
  final Widget logo;
  const SecurePaymentSection({super.key, this.logo = const _DefaultLogo()});

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
              const SizedBox(width: 4.0), // Adjust spacing as needed
            ],
          ),
          const SizedBox(height: 8.0), // Adjust spacing as needed
          logo,
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

class _DefaultLogo extends StatelessWidget {
  const _DefaultLogo();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      'https://assets.conekta.com/cpanel/statics/assets/img/conekta_white.svg',
      height: 20.0,
      colorFilter: context.isDarkMode
          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
          : null,
    );
  }
}
