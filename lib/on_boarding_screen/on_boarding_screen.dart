import 'package:evently/custom_widgets/selection_widget.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:evently/l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = 'OnBoardingScreen';

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  // ignore: unused_element
  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName,
      {double width = 300, double height = 300}) {
    return Image.asset(
      assetName,
      width: width,
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryBlue),
      bodyTextStyle: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold),
      bodyPadding: EdgeInsets.all(10),
      pageColor: Theme.of(context).scaffoldBackgroundColor,
      imagePadding: EdgeInsets.zero,
      bodyFlex: 3,
      imageFlex: 9,
      bodyAlignment: Alignment.center,
      imageAlignment: Alignment.bottomCenter,
    );

    return IntroductionScreen(
      key: introKey,
      // globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      allowImplicitScrolling: true,
      autoScrollDuration: 20000,
      // infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: _buildImage('assets/images/on_boarding_top.png',
                width: 300, height: 100),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Personalize Your Experience",
          bodyWidget: Column(
            children: [
              Text(
                  "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                  style: pageDecoration.bodyTextStyle),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(AppLocalizations.of(context)!.language,
              //             style: pageDecoration.bodyTextStyle),
              //         SelectionWidget(
              //           widget1: Image.asset(AssetsManager.america),
              //           widget2: Image.asset(AssetsManager.egypt),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(AppLocalizations.of(context)!.theme,
              //             style: pageDecoration.bodyTextStyle),
              //         SelectionWidget(
              //           widget1: Icon(
              //             Icons.light_mode,
              //             color: AppColor.primaryBlue,
              //           ),
              //           widget2: Icon(
              //             Icons.dark_mode,
              //             color: AppColor.primaryBlue,
              //           ),
              //         ),
              //       ],
              //     )
            ],
          ),
          image: _buildImage('assets/images/on_boarding_1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find Events That Inspire You",
          body:
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
          image: _buildImage('assets/images/on_boarding_2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Effortless Event Planning",
          body:
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
          image: _buildImage('assets/images/on_boarding_3.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
            title: "Connect with Friends & Share Moments",
            body:
                "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
            image: _buildImage('assets/images/on_boarding_4.png'),
            decoration: pageDecoration),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back_rounded, color: AppColor.primaryBlue),
      // skip: const Text('Skip',
      //     style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.gold)),
      next:
          const Icon(Icons.arrow_forward_rounded, color: AppColor.primaryBlue),
      done:
          const Icon(Icons.arrow_forward_rounded, color: AppColor.primaryBlue),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(0),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: AppColor.grey,
        activeSize: Size(22.0, 10.0),
        activeColor: AppColor.primaryBlue,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   void _onBackToIntro(context) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => const OnBoardingScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home')),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text("This is the screen after Introduction"),
//             const SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () => _onBackToIntro(context),
//               child: const Text('Back to Introduction'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
