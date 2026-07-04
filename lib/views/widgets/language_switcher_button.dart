import 'package:flutter/material.dart';

import '../../l10n/app_localizations_x.dart';
import '../../l10n/locale_scope.dart';

class LanguageSwitcherButton extends StatelessWidget {
  const LanguageSwitcherButton({
    super.key,
    this.iconColor,
    this.backgroundColor,
  });

  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = Localizations.localeOf(context);
    final localeController = LocaleScope.of(context);

    return PopupMenuButton<Locale>(
      tooltip: context.l10n.languageSelectorTooltip,
      onSelected: (Locale locale) {
        localeController.setLocale(locale);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        PopupMenuItem<Locale>(
          value: const Locale('en'),
          child: Row(
            children: <Widget>[
              if (currentLocale.languageCode == 'en')
                const Icon(Icons.check, size: 18),
              if (currentLocale.languageCode == 'en') const SizedBox(width: 8),
              Text(context.l10n.languageEnglish),
            ],
          ),
        ),
        PopupMenuItem<Locale>(
          value: const Locale('id'),
          child: Row(
            children: <Widget>[
              if (currentLocale.languageCode == 'id')
                const Icon(Icons.check, size: 18),
              if (currentLocale.languageCode == 'id') const SizedBox(width: 8),
              Text(context.l10n.languageIndonesian),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.language_rounded, color: iconColor),
      ),
    );
  }
}
