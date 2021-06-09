import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/palette.dart';
import '../../config/styles.dart';
import '../drawer_pages/faq.dart';
import '../drawer_pages/rules.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? ResponsiveBuilder(builder: (context, sizeInfo) {
            return Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(30),
                color: Palette.lightGrey,
                child: Column(
                  children: [
                    Flex(
                      direction:
                          sizeInfo.isDesktop ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: sizeInfo.isDesktop
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: sizeInfo.isDesktop
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BottomBarColumn(
                                heading: 'ABOUT',
                                content: {
                                  'Contact Us': () {
                                    launch(
                                      _emailLaunchUri.toString(),
                                    );
                                  },
                                  'About Us': () {}
                                },
                              ),
                              const SizedBox(width: 20),
                              BottomBarColumn(
                                heading: 'COMPANY',
                                content: {
                                  'Rules': () {
                                    Navigator.of(context).push(
                                      Rules.route(),
                                    );
                                  },
                                  'Privacy Policy': _launchPrivacyPolicy,
                                  'FAQ': () {
                                    Navigator.of(context).push(
                                      FAQ.route(),
                                    );
                                  },
                                  'Terms of Service': _launchTermsAndConditions
                                },
                              ),
                              const SizedBox(width: 20),
                              BottomBarColumn(
                                heading: 'SOCIAL',
                                content: {
                                  'Twitter': _launchTwitter,
                                  'Facebook': _launchFacebook,
                                  'Instagram': _launchInstagram,
                                  'LinkedIn': _launchLinkedIn
                                },
                              ),
                            ],
                          ),
                        ),
                        sizeInfo.isDesktop
                            ? const SizedBox(
                                width: 60,
                              )
                            : const SizedBox(),
                        sizeInfo.isDesktop
                            ? Container(
                                color: Palette.cream,
                                width: 2,
                                height: 150,
                              )
                            : const SizedBox(),
                        sizeInfo.isDesktop
                            ? const SizedBox(
                                width: 30,
                              )
                            : const SizedBox(),
                        Column(
                          crossAxisAlignment: sizeInfo.isDesktop
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            sizeInfo.isDesktop
                                ? const SizedBox()
                                : const Divider(
                                    color: Palette.cream,
                                  ),
                            const SizedBox(
                              height: 20,
                            ),
                            InfoText(
                              type: 'Email',
                              text: 'support@vegaslit.com',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            InfoText(
                              type: 'Address',
                              text:
                                  '1808, Summit Gate Ln, Las Vegas, NV - 89134',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Palette.cream,
                    ),
                    const SizedBox(
                      //height: sizeInfo.isDesktop ? 20 : 0,
                      width: 5,
                    ),
                    Text(
                      'Copyright © 2021 | VEGAS LIT',
                      style: Styles.bottomBarType,
                    ),
                  ],
                ));
          })
        : const SizedBox();
  }
}

class BottomBarColumn extends StatelessWidget {
  BottomBarColumn({this.heading, this.content});
  final String heading;
  final Map<String, Function> content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(heading, style: Styles.bottomBarHeading),
          const SizedBox(
            height: 10,
          ),
          ...content.keys
              .map((text) => Column(
                    children: [
                      TextButton(
                          onPressed: content[text],
                          child: Text(text, style: Styles.bottomBarNormal)),
                      const SizedBox(height: 5),
                    ],
                  ))
              .toList()
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  InfoText({this.type, this.text});
  final String type;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$type: ',
          style: Styles.bottomBarType,
        ),
        Text(
          text,
          style: Styles.bottomBarNormal,
        )
      ],
    );
  }
}

const _termsAndConditionsUrl = 'https://vegaslit.web.app/terms.html';
void _launchTermsAndConditions() async =>
    await canLaunch(_termsAndConditionsUrl)
        ? await launch(_termsAndConditionsUrl)
        : throw TermsAndConditionsUrlFailure();

const _privacyPolicyUrl = 'https://vegaslit.web.app/privacy.html';
void _launchPrivacyPolicy() async => await canLaunch(_privacyPolicyUrl)
    ? await launch(_privacyPolicyUrl)
    : throw PrivacyPolicyFailure();

const _facebookUrl = 'https://www.facebook.com/vegaslitgames';
void _launchFacebook() async => await canLaunch(_facebookUrl)
    ? await launch(_facebookUrl)
    : throw FacebookUrlFailure();

const _twitterUrl = 'https://twitter.com/VegasLitGames';
void _launchTwitter() async => await canLaunch(_twitterUrl)
    ? await launch(_twitterUrl)
    : throw TwitterUrlFailure();

const _instagramUrl = 'https://www.instagram.com/vegaslitgames';
void _launchInstagram() async => await canLaunch(_instagramUrl)
    ? await launch(_instagramUrl)
    : throw InstagramUrlFailure();

const _linkedInUrl = 'https://www.linkedin.com/company/vegas-lit-games';
void _launchLinkedIn() async => await canLaunch(_linkedInUrl)
    ? await launch(_linkedInUrl)
    : throw LinkedInUrlFailure();

final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'support@vegaslit.com',
  queryParameters: {'subject': 'Question about Vegas Lit app'},
);

class TermsAndConditionsUrlFailure implements Exception {}

class PrivacyPolicyFailure implements Exception {}

class FacebookUrlFailure implements Exception {}

class TwitterUrlFailure implements Exception {}

class InstagramUrlFailure implements Exception {}

class LinkedInUrlFailure implements Exception {}
