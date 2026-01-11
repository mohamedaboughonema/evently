import 'package:evently/custom_widgets/custom_toast_message.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';

class EventsListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<String> categories = [];
  List<Event> eventsList = [];
  List<Event> favouriteEventsList = [];
  Map<String, String> categoriesEn = {};
  // 'All',
  // 'Birthday',
  // 'Sport',
  // 'Meeting',
  // 'Gaming',
  // 'Eating',
  // 'Holiday',
  // 'Exhibition',
  // 'Workshop',
  // 'Book Club',

  Map<String, String> categoriesAr = {};
  //   'الكل',
  //   'عيد الميلاد',
  //   'الرياضة',
  //   'الإجتماعات',
  //   'الألعاب',
  //   'التغذية',
  //   'الأجازات',
  //   'المعرض',
  //   'ورشة العمل',
  //   'نادى الكتاب',
  List<Event> filteredList = [];
  void getAllEvents(String userId) async {
    // print("getAllEvents CALLED");
    var querySnapshot = await FirebaseUtils.getEventCollection(userId)
        .orderBy('date', descending: true)
        .get();
    // print("Query finished");
    eventsList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    // ----------- sorting the events by date descending -----------
    // eventsList.sort((event1, event2) {
    //   return event2.date!.compareTo(event1.date!);
    // });
    filteredList = eventsList;
    notifyListeners();
    // print('get all events fun.');
  }

  void getAndFilterEvents(String userId) async {
    // print("getAndFilterEvents CALLED");
    var querySnapshot = await FirebaseUtils.getEventCollection(userId)
        .where('index', isEqualTo: selectedIndex - 1)
        .orderBy('date', descending: true)
        .get();
    // print("Query finished");
    filteredList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    // ----------- filtering the events by category -----------
    // eventsList = eventsList.where((event) {
    //   return event.category == categoriesAgain[selectedIndex];
    // }).toList();
    // ----------- sorting the events by date descending -----------
    // eventsList.sort((event1, event2) {
    //   return event2.date!.compareTo(event1.date!);
    // });
    print(categories[selectedIndex]);
    print('selected index: $selectedIndex');
    notifyListeners();
    print('get all events fun.');
  }

  void changeSelectedIndex(int index, String userId) {
    selectedIndex = index;
    if (selectedIndex == 0) {
      getAllEvents(userId);
    } else {
      getAndFilterEvents(userId);
      for (int i = 0; i < eventsList.length; i++) {
        print(
            'event ${i}: ${eventsList[i].name}, category: ${eventsList[i].category}, image: ${eventsList[i].image}');
      }
    }
  }

  void getFavouriteEvents(String userId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(userId)
        .where('isFavorite', isEqualTo: true)
        .orderBy('date', descending: true)
        .get();
    favouriteEventsList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    notifyListeners();
  }

  void updateIsFavourite(Event event, String userId) {
    FirebaseUtils.getEventCollection(userId)
        .doc(event.id)
        .update({"isFavorite": !event.isFavorite}).then((value) {
      print('favourite updated');
      CustomToastMessage.showMessage(event.isFavorite
          ? 'event removed from favourites'
          : 'event added to favourites');
      selectedIndex == 0 ? getAllEvents(userId) : getAndFilterEvents(userId);
      getFavouriteEvents(userId);
      // --- offline case ---
    }).timeout(
      Duration(seconds: 1),
      onTimeout: () {
        print('favourite updated');
        CustomToastMessage.showMessage(event.isFavorite
            ? 'event removed from favourites'
            : 'event added to favourites');
        selectedIndex == 0 ? getAllEvents(userId) : getAndFilterEvents(userId);
        getFavouriteEvents(userId);
      },
    );
  }

  void getCategoriesList(BuildContext context) {
    categories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.book_club,
    ];
  }
}
