import 'package:evently/custom_widgets/custom_toast_message.dart';
import 'package:evently/custom_widgets/special_elevated_button.dart';
import 'package:evently/custom_widgets/special_text_field.dart';
import 'package:evently/firebase_utils.dart';
import 'package:evently/model/event.dart';
import 'package:evently/provider/events_list_provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/tab_widget.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_text_style.dart';
import 'package:evently/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  static const String routeName = 'Add Event';

  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  String selectedImage = '';
  String selectedCategory = '';
  var formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  String? formattedDate;
  TimeOfDay? selectedTime;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late EventsListProvider eventsListProvider;
  @override
  Widget build(BuildContext context) {
    eventsListProvider = Provider.of<EventsListProvider>(context);
    List<String> categories = [
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
    List<String> categoriesImages = [
      AssetsManager.birthdayImage,
      AssetsManager.sportImage,
      AssetsManager.meetingImage,
      AssetsManager.gamingImage,
      AssetsManager.eatingImage,
      AssetsManager.holidayImage,
      AssetsManager.exhibitionImage,
      AssetsManager.workshopImage,
      AssetsManager.bookClubImage,
    ];
    selectedImage = categoriesImages[selectedIndex];
    selectedCategory = categories[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.create_event),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(selectedImage),
                ),
              ),
              DefaultTabController(
                length: categories.length,
                child: TabBar(
                  onTap: (value) {
                    selectedIndex = value;
                    setState(() {});
                  },
                  padding: EdgeInsets.all(0),
                  labelPadding: EdgeInsets.all(5),
                  tabAlignment: TabAlignment.center,
                  labelStyle: AppTextStyle.medium16Transparent.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  unselectedLabelStyle: AppTextStyle.medium16Primary,
                  indicatorColor: AppColor.transparent,
                  dividerColor: AppColor.transparent,
                  isScrollable: true,
                  tabs: categories.map((categoryName) {
                    return TabWidget(
                        selectedBackgroundColor: AppColor.primaryBlue,
                        unSelectedBackgroundColor: AppColor.transparent,
                        borderColor: AppColor.primaryBlue,
                        isSelected:
                            selectedIndex == categories.indexOf(categoryName),
                        tabTitle: categoryName);
                  }).toList(),
                ),
              ),
              SpecialLabel(AppLocalizations.of(context)!.title),
              SpecialTextField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please Enter Event Title';
                    }
                    return null;
                  },
                  controller: titleController,
                  hintText: AppLocalizations.of(context)!.event_title,
                  textColor: Theme.of(context).primaryColorDark,
                  borderColor: Theme.of(context).primaryColorLight,
                  prefixIcon: Image.asset(
                    AssetsManager.iconEdit,
                    color: Theme.of(context).primaryColorDark,
                  )),
              SpecialLabel(AppLocalizations.of(context)!.description),
              SpecialTextField(
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please Enter Event Description';
                  }
                  return null;
                },
                controller: descriptionController,
                maxLines: 5,
                hintText: AppLocalizations.of(context)!.event_description,
                textColor: Theme.of(context).primaryColorDark,
                borderColor: Theme.of(context).primaryColorLight,
              ),
              SpecialDateTimeRow(
                function: chooseDate,
                icon: Icons.calendar_month_outlined,
                label: AppLocalizations.of(context)!.event_date,
                buttonText: selectedDate == null
                    ? AppLocalizations.of(context)!.choose_date
                    // : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    : DateFormat('dd/MM/yyyy').format(selectedDate!),
              ),
              SpecialDateTimeRow(
                function: chooseTime,
                icon: Icons.timelapse_outlined,
                label: AppLocalizations.of(context)!.event_time,
                buttonText: selectedTime == null
                    ? AppLocalizations.of(context)!.choose_time
                    : selectedTime!.format(context),
              ),
              SpecialLabel(AppLocalizations.of(context)!.location),
              InkWell(
                onTap: () {
                  // to do : choose location
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryBlue, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Image.asset(
                          AssetsManager.iconLocation,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(AppLocalizations.of(context)!.choose_event_location,
                          style: AppTextStyle.medium16Primary),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: AppColor.primaryBlue, size: 16)
                    ],
                  ),
                ),
              ),
              SpecialElevatedButton(
                onPressed: addEvent,
                centerText: true,
                text: AppLocalizations.of(context)!.add_event,
              )
            ],
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      Event event = Event(
          name: selectedCategory,
          title: titleController.text,
          description: descriptionController.text,
          image: selectedImage,
          category: selectedCategory,
          date: selectedDate!,
          time: selectedTime!.format(context),
          index: selectedIndex,
          latitude: 0.0,
          longitude: 0.0,
          locationName: 'Default Location');
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      FirebaseUtils.addEventToFirestore(event,
              userProvider.currentUser!.id ?? 'nullable which is impossible')
          .then((value) {
        // to do : show alert dialog
        // print('event added');
        CustomToastMessage.showMessage('Event Added Successfully');
        eventsListProvider.getAllEvents(
            userProvider.currentUser!.id ?? 'nullable which is impossible');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // --- offline case ---
      }).timeout(Duration(seconds: 1), onTimeout: () {
        // to do : show alert dialog
        // print('event added');
        CustomToastMessage.showMessage('Event Added Successfully');
        eventsListProvider.getAllEvents(
            userProvider.currentUser!.id ?? 'nullable which is impossible');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    }
  }

  void chooseDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 3650)));
    selectedDate = date;
    // formattedDate = DateFormat('dd/MMM/yyyy').format(selectedDate!);
    setState(() {});
  }

  void chooseTime() async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    selectedTime = time;
    setState(() {});
  }
}

class SpecialLabel extends StatelessWidget {
  final String label;
  const SpecialLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Text(label,
          style: AppTextStyle.medium16Black
              .copyWith(color: Theme.of(context).primaryColorDark)),
    );
  }
}

class SpecialDateTimeRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String buttonText;
  final VoidCallback? function;
  const SpecialDateTimeRow(
      {super.key,
      this.icon,
      this.label = '',
      this.buttonText = '',
      this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColorDark,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: AppTextStyle.medium16Grey
                .copyWith(color: Theme.of(context).primaryColorDark),
          ),
          Spacer(),
          TextButton(
              onPressed: function,
              child: Text(
                buttonText,
                style: AppTextStyle.medium16Primary,
              ))
        ],
      ),
    );
  }
}
