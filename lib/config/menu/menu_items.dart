import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.subTitle,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  /*MenuItem(
    title: 'Riverpod Counter',
    subTitle: 'Introducción a riverpod',
    link: '/counter-river',
    icon: Icons.add,
  ),*/
  MenuItem(
    title: 'Dashboard',
    subTitle: 'Main dashboard overview',
    link: '/',
    icon: FontAwesomeIcons.house,
  ),
  MenuItem(
    title: 'Trips',
    subTitle: 'Your planned trips',
    link: '/trips',
    icon: FontAwesomeIcons.suitcase,
  ),
  MenuItem(
    title: 'Calendar',
    subTitle: 'Trip calendar',
    link: '/calendar',
    icon: FontAwesomeIcons.solidCalendar,
  ),
  MenuItem(
    title: 'Account',
    subTitle: 'Profile and settings',
    link: '/account',
    icon: FontAwesomeIcons.solidUser,
  ),
  MenuItem(
    title: 'Support',
    subTitle: 'Get help and support',
    link: '/support',
    icon: FontAwesomeIcons.circleQuestion,
  ),

  MenuItem(
    title: 'Cambiar tema',
    subTitle: 'Cambiar tema de la aplicación',
    link: '/theme-changer',
    icon: Icons.color_lens_outlined,
  ),
];
