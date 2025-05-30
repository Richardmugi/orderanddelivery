import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';
import 'box_decorations.dart';

class HomeSearchBox extends StatelessWidget {
  final BuildContext? context;
  const HomeSearchBox({Key? key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecorations.buildBoxDecoration_1(),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          // Logo
          Image.asset(
            "assets/od5.png",
            height: 50,
          ),
          const SizedBox(width: 50),

          // Search Text Placeholder
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.search_anything,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color.fromRGBO(174, 133, 44, 1),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Search Icon
          Image.asset(
            'assets/search.png',
            height: 18,
            color: MyTheme.dark_grey,
          ),
        ],
      ),
    );
  }
}
