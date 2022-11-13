import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/models/badge.dart';
import 'package:nappy_mobile/utils.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_header.dart';
import 'package:nappy_mobile/views/card_editor/badges/badge_subtitle_suggestions.dart';
import 'package:nappy_mobile/views/card_editor/card_editor_view.dart';
import 'package:nappy_mobile/views/card_editor/widgets/card_editor_text_field.dart';

class PhoneBadgeView extends StatefulWidget {
  final Badge badge;
  final Color themeColor;
  const PhoneBadgeView({
    super.key,
    required this.badge,
    required this.themeColor,
  });
  @override
  State<PhoneBadgeView> createState() => _PhoneBadgeViewState();
}

class _PhoneBadgeViewState extends State<PhoneBadgeView> {
  late final CardEditorField phoneNumberField;
  late final CardEditorField phoneExtField;
  late final CardEditorField labelField;
  Country country = Country.worldWide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.themeColor,
        title: Text("Insert ${widget.badge.label}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: const Text("SAVE"),
          ),
        ],
      ),
      body: Column(
        children: [
          BadgeHeader(
            badge: widget.badge,
            themeColor: widget.themeColor,
            title: "${getCode()}${phoneNumberField.text}",
            subtitle: labelField.text,
            titleSuffixLabel: phoneExtField.text.isEmpty ? "" : ' Ext. ${phoneExtField.text}',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: InkWell(
                    onTap: () => pickCountry(),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            country.flagEmoji,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        Text("+${country.phoneCode}"),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        hSpace(10),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CardEditorTextField(
                    keyboardType: TextInputType.number,
                    controller: phoneNumberField.controller,
                    labelText: phoneNumberField.title,
                    themeColor: widget.themeColor,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                hSpace(12),
                Expanded(
                  child: CardEditorTextField(
                    keyboardType: TextInputType.number,
                    controller: phoneExtField.controller,
                    labelText: phoneExtField.title,
                    themeColor: widget.themeColor,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ),
          vSpace(20),
          if (widget.badge.subtitleSuggestions.isNotEmpty) ...{
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: BadgeSubtitleSuggestions(
                suggestions: widget.badge.subtitleSuggestions,
                onSuggestionClicked: (suggestion) {
                  setState(() {
                    labelField.setText(suggestion);
                  });
                },
                themeColor: widget.themeColor,
              ),
            )
          },
        ],
      ),
    );
  }

  String getCode() {
    if (country == Country.worldWide) {
      return "";
    } else {
      return "+${country.phoneCode}";
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumberField = CardEditorField(widget.badge.label);
    phoneExtField = CardEditorField("Ext.");
    labelField = CardEditorField("Label (Optional)");
  }

  @override
  void dispose() {
    super.dispose();
    phoneNumberField.controller.dispose();
    phoneExtField.controller.dispose();
    labelField.controller.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 32,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 600, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          filled: false,
          labelText: 'Search',
          hintText: 'Start typing to search',
          floatingLabelStyle: const TextStyle(color: Colors.black),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
      onSelect: (Country c) {
        setState(() {
          country = c;
        });
      },
    );
  }
}
