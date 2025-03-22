import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/shared/bloc/language/language_bloc.dart';
import 'package:mobile_app_standard/shared/bloc/language/language_event.dart';
import 'package:mobile_app_standard/shared/bloc/language/language_state.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';

class LanguageDropdown extends StatelessWidget {
  final BuildContext context;
  const LanguageDropdown({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            customButton: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.language,
                  color: state.isDropdownOpen
                      ? PColor.primaryColor
                      : PColor.contentColor,
                ),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: Locale('th'),
                child: Text(
                  'ไทย',
                  style: TextStyle(
                    color: state.locale == Locale('th')
                        ? PColor.primaryColor
                        : null,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: Locale('en'),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: state.locale == Locale('en')
                        ? PColor.primaryColor
                        : PColor.contentColor,
                  ),
                ),
              ),
            ],
            value: state.locale,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context
                    .read<LanguageBloc>()
                    .add(ChangeLanguageEvent(newLocale));
              }
            },
            onMenuStateChange: (isOpen) {
              context.read<LanguageBloc>().add(ToggleDropdownEvent(isOpen));
            },
            dropdownStyleData: DropdownStyleData(
              width: 100,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(50),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              offset: const Offset(-8, -8),
            ),
          ),
        );
      },
    );
  }
}
