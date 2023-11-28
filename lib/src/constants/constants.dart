import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

setWidth({required double width}) {
  return SizedBox(
    width: width,
  );
}

setHeight({required double height}) {
  return SizedBox(height: height);
}

final appPrimaryColor = Colors.blue.shade900;

const emailRegExPattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

final emailRegEx = RegExp(emailRegExPattern);

String? validateEmail(String? value) {
  return value ==null || value.isEmpty && !emailRegEx.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

final List<String> countryList = ['India'];

final List<String> indiaStates = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha (Orissa)',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand (Uttaranchal)',
  'West Bengal',
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli',
  'Daman and Diu',
  'Lakshadweep',
  'National Capital Territory of Delhi',
  'Puducherry (Pondicherry)',
];


Future<dynamic> selectImage(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Select source',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          setHeight(height: 16),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.camera,
              color: appPrimaryColor,
            ),
            title: Text(
              'Camera',
              style: TextStyle(
                color: appPrimaryColor,
              ),
            ),
            onTap: () => context.pop(ImageSource.camera),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.image,
              color: appPrimaryColor,
            ),
            title: Text(
              "Gallery",
              style: TextStyle(
                color: appPrimaryColor,
              ),
            ),
            onTap: () => context.pop(ImageSource.gallery),
          ),
        ],
      );
    },
  );
}
