import 'package:flutter/material.dart';

import '../core/utils/date_formats.dart';

/// Lightweight localization for Shustho (Bangla + English).
///
/// String lookups are keyed by the current locale. Bangla text is authored
/// directly; numbers/dates are converted to Bangla numerals via [DateFormats].
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  bool get isBn => locale.languageCode == 'bn';

  String get day => isBn ? 'আজ' : 'Today';
  String get calendar => isBn ? 'ক্যালেন্ডার' : 'Calendar';
  String get insights => isBn ? 'পরিসংখ্যান' : 'Insights';
  String get settings => isBn ? 'সেটিংস' : 'Settings';
  String get profile => isBn ? 'প্রোফাইল' : 'Profile';
  String get next => isBn ? 'পরবর্তী' : 'Next';
  String get back => isBn ? 'পেছনে' : 'Back';
  String get skip => isBn ? 'এড়িয়ে যান' : 'Skip';
  String get save => isBn ? 'সংরক্ষণ করুন' : 'Save';
  String get cancel => isBn ? 'বাতিল' : 'Cancel';
  String get done => isBn ? 'সম্পন্ন' : 'Done';
  String get delete => isBn ? 'মুছুন' : 'Delete';
  String get close => isBn ? 'বন্ধ করুন' : 'Close';
  String get continueLabel => isBn ? 'চালিয়ে যান' : 'Continue';
  String get getStarted => isBn ? 'শুরু করুন' : 'Get Started';

  String get appTagline =>
      isBn ? 'বাংলাদেশের জন্য একটি বিনামূল্যের স্বাস্থ্য ট্র্যাকার' : 'A free health tracker for Bangladesh';

  String get period => isBn ? 'পিরিয়ড' : 'Period';
  String get periods => isBn ? 'পিরিয়ড' : 'Periods';
  String get cycle => isBn ? 'চক্র' : 'Cycle';
  String get ovulation => isBn ? 'ডিম্বস্ফোটন' : 'Ovulation';
  String get fertileWindow => isBn ? 'উর্বর সময়' : 'Fertile window';
  String get follicularPhase => isBn ? 'ফলিকুলার পর্যায়' : 'Follicular phase';
  String get lutealPhase => isBn ? 'লুটিয়াল পর্যায়' : 'Luteal phase';
  String get periodPhase => isBn ? 'পিরিয়ড' : 'Period';

  String get nextPeriod => isBn ? 'পরবর্তী পিরিয়ড' : 'Next period';
  String get nextPeriodIn => isBn ? 'পরবর্তী পিরিয়ড' : 'Next period in';
  String get daysLabel => isBn ? 'দিন' : 'days';
  String get dayLabel => isBn ? 'দিন' : 'day';
  String get daysShort => isBn ? 'দিন' : 'd';
  String get today => isBn ? 'আজ' : 'Today';

  String get logPeriod => isBn ? 'পিরিয়ড রেকর্ড করুন' : 'Log period';
  String get logSymptoms => isBn ? 'উপসর্গ রেকর্ড করুন' : 'Log symptoms';
  String get editToday => isBn ? 'আজকের তথ্য দেখুন' : 'View today';
  String get edit => isBn ? 'সম্পাদনা' : 'Edit';
  String get configure => isBn ? 'সেট করুন' : 'Configure';

  String get flow => isBn ? 'পরিমাণ' : 'Flow';
  String get flowNone => isBn ? 'কোনোটি নয়' : 'None';
  String get flowLight => isBn ? 'হালকা' : 'Light';
  String get flowMedium => isBn ? 'মাঝারি' : 'Medium';
  String get flowHeavy => isBn ? 'ভারী' : 'Heavy';

  String get painLevel => isBn ? 'ব্যথার মাত্রা' : 'Pain level';
  String get noPain => isBn ? 'ব্যথা নেই' : 'No pain';
  String get mildPain => isBn ? 'সামান্য' : 'Mild';
  String get moderatePain => isBn ? 'মাঝারি' : 'Moderate';
  String get severePain => isBn ? 'তীব্র' : 'Severe';

  String get mood => isBn ? 'মেজাজ' : 'Mood';
  String get moods => isBn ? 'মেজাজ' : 'Moods';
  String get symptoms => isBn ? 'উপসর্গ' : 'Symptoms';
  String get notes => isBn ? 'নোট' : 'Notes';
  String get notesHint => isBn ? 'অতিরিক্ত কিছু লিখুন...' : 'Write something extra...';

  String get moodHappy => isBn ? 'আনন্দিত' : 'Happy';
  String get moodCalm => isBn ? 'শান্ত' : 'Calm';
  String get moodAnxious => isBn ? 'উদ্বিগ্ন' : 'Anxious';
  String get moodSad => isBn ? 'বিষণ্ণ' : 'Sad';
  String get moodIrritable => isBn ? 'খিটখিটে' : 'Irritable';

  String get symCramps => isBn ? 'পেটে ব্যথা' : 'Cramps';
  String get symHeadache => isBn ? 'মাথাব্যথা' : 'Headache';
  String get symBackache => isBn ? 'পিঠে ব্যথা' : 'Backache';
  String get symBloating => isBn ? 'পেট ফোলা' : 'Bloating';
  String get symBreastTenderness => isBn ? 'স্তনে ব্যথা' : 'Breast tenderness';
  String get symFatigue => isBn ? 'ক্লান্তি' : 'Fatigue';
  String get symNausea => isBn ? 'বমি বমি ভাব' : 'Nausea';
  String get symAcne => isBn ? 'ব্রণ' : 'Acne';
  String get symCraving => isBn ? 'খাবারের লোভ' : 'Craving';
  String get symInsomnia => isBn ? 'অনিদ্রা' : 'Insomnia';
  String get symMoodSwings => isBn ? 'মেজাজ পরিবর্তন' : 'Mood swings';
  String get symAnxiety => isBn ? 'উদ্বেগ' : 'Anxiety';

  String get guardian => isBn ? 'অভিভাবক' : 'Guardian';
  String get guardianActive => isBn ? 'সক্রিয়' : 'Active';
  String get guardianInactive => isBn ? 'নিষ্ক্রিয়' : 'Inactive';
  String get guardianName => isBn ? 'নাম' : 'Name';
  String get guardianRelation => isBn ? 'সম্পর্ক' : 'Relation';
  String get guardianDescription => isBn
      ? 'একজন বিশ্বস্ত অভিভাবক (যেমন পরিবারের সদস্য) বেছে নিন যিনি প্রয়োজনে সাহায্য করতে পারেন। সব তথ্য আপনার ডিভাইসেই থাকবে।'
      : 'Choose a trusted guardian (such as a family member) who can help when needed. All data stays on your device.';
  String get guardianPlaceholder => isBn ? 'ভরসার মানুষের নাম' : 'Trusted person\'s name';
  String get guardianRelationPlaceholder => isBn ? 'যেমন: মা, বোন, বন্ধু' : 'e.g. Mother, sister, friend';
  String get guardianOfflineNote => isBn
      ? 'Shustho সম্পূর্ণ অফলাইন। কোনো ডেটা ডিভাইসের বাইরে পাঠানো হয় না।'
      : 'Shustho is fully offline. No data leaves your device.';

  String get reminders => isBn ? 'অনুস্মারক' : 'Reminders';
  String get remindersEnabled => isBn ? 'অনুস্মারক চালু করুন' : 'Enable reminders';
  String get reminderTime => isBn ? 'সময়' : 'Time';
  String get reminderHint => isBn
      ? 'প্রতিদিন আপনার চক্র সম্পর্কে মৃদু অনুস্মারক।'
      : 'Gentle daily reminders about your cycle.';

  String get language => isBn ? 'ভাষা' : 'Language';
  String get themeMode => isBn ? 'থিম' : 'Theme';
  String get lightMode => isBn ? 'লাইট' : 'Light';
  String get darkMode => isBn ? 'ডার্ক' : 'Dark';
  String get systemMode => isBn ? 'সিস্টেম' : 'System';

  String get averageCycleLength => isBn ? 'গড় চক্রের দৈর্ঘ্য' : 'Average cycle length';
  String get averagePeriodLength => isBn ? 'গড় পিরিয়ডের দৈর্ঘ্য' : 'Average period length';
  String get cycleLengthLabel => isBn ? 'চক্রের দৈর্ঘ্য' : 'Cycle length';
  String get periodLengthLabel => isBn ? 'পিরিয়ডের দৈর্ঘ্য' : 'Period length';
  String get lastPeriodLabel => isBn ? 'শেষ পিরিয়ডের তারিখ' : 'Last period start';
  String get selectDate => isBn ? 'তারিখ বেছে নিন' : 'Select a date';
  String get selectDateHint => isBn ? 'একটি তারিখ বেছে নিন' : 'Choose a date';
  String get daysUnit => isBn ? 'দিন' : 'days';

  String get phaseTitle => isBn ? 'আজকের চক্র' : 'Today\'s cycle';
  String get phaseDescription => isBn ? 'আপনার চক্রের অবস্থা' : 'Your cycle status';
  String periodDayX(int n) => isBn
      ? 'পিরিয়ডের ${DateFormats.digits(n, bn: true)}তম দিন'
      : 'Period day $n';
  String get periodStartsToday => isBn ? 'আজ পিরিয়ড শুরু হবে' : 'Period starts today';
  String periodStartsInDays(int n) => isBn
      ? 'পরবর্তী পিরিয়ড ${DateFormats.digits(n, bn: true)} দিন পরে'
      : 'Next period in $n days';
  String nextPeriodStartsIn(String n) => isBn
      ? 'পরবর্তী পিরিয়ড $n দিন পরে'
      : 'Next period in $n days';
  String get notInPeriod => isBn ? 'এখন পিরিয়ড চলছে না' : 'Not on your period now';
  String get startPeriodWhenItBegins => isBn
      ? 'পিরিয়ড শুরু হলে এক ট্যাপে রেকর্ড করুন।'
      : 'Tap the button when your period starts.';
  String get regularityUnknown => isBn ? 'এখনও জানা যায়নি' : 'Not yet known';
  String get periodStartedToday => isBn ? 'আজ পিরিয়ড শুরু' : 'Period started today';
  String get fertileWindowDesc => isBn
      ? 'গর্ভধারণের সম্ভাবনা বেশি থাকার সময়কাল।'
      : 'Your most likely days to conceive.';
  String get ovulationDesc => isBn
      ? 'ডিম্বস্ফোটন — সবচেয়ে উর্বর দিন।'
      : 'Ovulation — your most fertile day.';
  String get follicularDesc => isBn
      ? 'শরীর নতুন চক্রের জন্য প্রস্তুত হচ্ছে।'
      : 'Your body is preparing for a new cycle.';
  String get lutealDesc => isBn
      ? 'পরবর্তী পিরিয়ডের আগে শরীর প্রস্তুতি নিচ্ছে।'
      : 'Your body prepares for the next period.';
  String get periodDesc => isBn
      ? 'আপনার মাসিক চলছে। বিশ্রাম নিন এবং পর্যাপ্ত পানি পান করুন।'
      : 'Your period is ongoing. Rest well and stay hydrated.';

  String get stats => isBn ? 'পরিসংখ্যান' : 'Statistics';
  String get predictions => isBn ? 'ভবিষ্যদ্বাণী' : 'Predictions';
  String get cycleTrend => isBn ? 'চক্রের ধারা' : 'Cycle trend';
  String get loggedPeriodDays => isBn ? 'রেকর্ডকৃত পিরিয়ড দিন' : 'Logged period days';
  String get noDataYet => isBn
      ? 'এখনও কোনো ডেটা নেই। পিরিয়ড রেকর্ড করা শুরু করুন।'
      : 'No data yet. Start logging your period.';
  String get nextFertileWindow => isBn ? 'পরবর্তী উর্বর সময়' : 'Next fertile window';
  String get nextOvulation => isBn ? 'পরবর্তী ডিম্বস্ফোটন' : 'Next ovulation';
  String get estimated => isBn ? 'আনুমানিক' : 'Estimated';
  String get observed => isBn ? 'পর্যবেক্ষিত' : 'Observed';

  String get healthTips => isBn ? 'স্বাস্থ্য টিপস' : 'Health tips';
  String get redFlagsTitle => isBn ? 'লাল পতাকা' : 'Red flags';
  String get redFlagsDesc => isBn
      ? 'এসব লক্ষণ দেখা দিলে চিকিৎসকের পরামর্শ নিন:'
      : 'Seek medical advice if you notice:';
  String get redFlag1 => isBn
      ? 'ঘণ্টায় একাধিক প্যাড/ট্যাম্পন ভিজে যাওয়া বা খুব ভারী রক্তপাত'
      : 'Soaking a pad/tampon every hour or very heavy bleeding';
  String get redFlag2 => isBn
      ? 'ওষুধেও কমছে না এমন তীব্র ব্যথা'
      : 'Severe pain that medicine does not relieve';
  String get redFlag3 => isBn
      ? '৭ দিনের বেশি রক্তপাত'
      : 'Bleeding lasting more than 7 days';
  String get redFlag4 => isBn
      ? 'পিরিয়ডের মাঝে রক্তপাত'
      : 'Bleeding between periods';
  String get redFlag5 => isBn
      ? 'নিয়মিত ২১ দিনের কম বা ৩৫ দিনের বেশি ব্যবধানে চক্র'
      : 'Regular cycles shorter than 21 or longer than 35 days';
  String get healthTip1 => isBn
      ? 'পেটে গরম সেঁক পিরিয়ডের ব্যথা কমাতে সাহায্য করে।'
      : 'A warm compress on your lower belly can ease period cramps.';
  String get healthTip2 => isBn
      ? 'আয়রন সমৃদ্ধ খাবার (শাক, ডাল) পিরিয়ডে শক্তি ধরে রাখে।'
      : 'Iron-rich foods (greens, lentils) help keep your energy up.';
  String get healthTip3 => isBn
      ? 'পর্যাপ্ত পানি পান করুন এবং নিয়মিত হালকা হাঁটুন।'
      : 'Stay hydrated and take short gentle walks.';

  String get onboardingTitle => isBn
      ? 'Shustho-তে স্বাগতম'
      : 'Welcome to Shustho';
  String get onboardingSubtitle => isBn
      ? 'আপনার পিরিয়ড ও স্বাস্থ্য ট্র্যাক করুন — সম্পূর্ণ বিনামূল্যে ও অফলাইনে।'
      : 'Track your period and reproductive health — free and fully offline.';
  String get stepLanguage => isBn ? 'ভাষা বেছে নিন' : 'Choose your language';
  String get stepCycle => isBn ? 'আপনার চক্র সম্পর্কে বলুন' : 'Tell us about your cycle';
  String get stepGuardian => isBn ? 'অভিভাবক (ঐচ্ছিক)' : 'Guardian (optional)';
  String get stepCycleDesc => isBn
      ? 'আনুমানিক হলেও ঠিক আছে — পরে যেকোনো সময় বদলাতে পারবেন।'
      : 'Estimates are fine — you can change these anytime.';
  String get cycleLengthValue => isBn ? 'দিন' : 'days';
  String get lastPeriodDesc => isBn
      ? 'শেষ পিরিয়ড কবে শুরু হয়েছিল?'
      : 'When did your last period start?';

  String get allDataStaysLocal => isBn
      ? 'সব তথ্য আপনার ডিভাইসেই থাকে — ১০০% গোপনীয় ও অফলাইন।'
      : 'All data stays on your device — 100% private and offline.';
  String get resetData => isBn ? 'সব তথ্য মুছুন' : 'Reset all data';
  String get resetDataConfirm => isBn
      ? 'সব পিরিয়ড ও উপসর্গের তথ্য মুছে যাবে। এটা ঠিক আছে?'
      : 'All period and symptom data will be deleted. Is that OK?';
  String get resetDataDone => isBn ? 'সব তথ্য মুছে ফেলা হয়েছে' : 'All data has been cleared';
  String get privacy => isBn ? 'গোপনীয়তা' : 'Privacy';
  String get about => isBn ? 'সম্পর্কে' : 'About';
  String get aboutText => isBn
      ? 'Shustho (স্বাস্থ্য) — বাংলাদেশের জন্য একটি বিনামূল্যের, অফলাইন-ফার্স্ট মাসিক ও প্রজনন স্বাস্থ্য ট্র্যাকার।'
      : 'Shustho (স্বাস্থ্য) — a free, offline-first menstruation and reproductive health tracker for Bangladesh.';
  String get versionLabel => isBn ? 'সংস্করণ' : 'Version';
  String get version => '1.0.0';

  String get periodLogged => isBn ? 'পিরিয়ড রেকর্ড করা হয়েছে' : 'Period logged';
  String get symptomsLogged => isBn ? 'উপসর্গ রেকর্ড করা হয়েছে' : 'Symptoms logged';
  String get entryUpdated => isBn ? 'তথ্য হালনাগাদ হয়েছে' : 'Entry updated';
  String get noPeriodMarked => isBn ? 'পিরিয়ড নেই বলে চিহ্নিত' : 'Marked as not a period day';

  String get markNotPeriod => isBn ? 'পিরিয়ডের দিন নয়' : 'Not a period day';
  String get loggedFlow => isBn ? 'রেকর্ডকৃত পরিমাণ:' : 'Logged flow:';
  String get loggedSymptoms => isBn ? 'রেকর্ডকৃত উপসর্গ:' : 'Logged symptoms:';

  String get pickDate => isBn ? 'তারিখ' : 'Date';
  String get previousMonth => isBn ? 'আগের মাস' : 'Previous month';
  String get nextMonth => isBn ? 'পরের মাস' : 'Next month';

  String get legendPeriod => isBn ? 'পিরিয়ড' : 'Period';
  String get legendPredicted => isBn ? 'আনুমানিক পিরিয়ড' : 'Predicted period';
  String get legendFertile => isBn ? 'উর্বর সময়' : 'Fertile window';
  String get legendOvulation => isBn ? 'ডিম্বস্ফোটন' : 'Ovulation';

  String get dayDetails => isBn ? 'দিনের বিস্তারিত' : 'Day details';
  String get noEntryForDay => isBn ? 'এই দিনের কোনো রেকর্ড নেই।' : 'No record for this day.';

  String get welcome => isBn ? 'শুভেচ্ছা' : 'Welcome';
  String get greeting => isBn ? 'আজকের অবস্থা' : 'Today\'s status';

  // ---- Period tracker (Part 2) ----
  String get startPeriod => isBn ? 'পিরিয়ড শুরু করুন' : 'Start period';
  String get endPeriod => isBn ? 'পিরিয়ড শেষ করুন' : 'End period';
  String dayXofPeriod(int n) => isBn
      ? 'পিরিয়ডের ${DateFormats.digits(n, bn: true)}তম দিন'
      : 'Day $n of period';
  String get cycleHistory => isBn ? 'চক্রের ইতিহাস' : 'Cycle history';
  String cycleNo(int n) => isBn
      ? 'চক্র ${DateFormats.digits(n, bn: true)}'
      : 'Cycle $n';
  String get lengthLabel => isBn ? 'দৈর্ঘ্য' : 'Length';
  String get regularityLabel => isBn ? 'নিয়মিততা' : 'Regularity';
  String get regular => isBn ? 'নিয়মিত' : 'Regular';
  String get irregular => isBn ? 'অনিয়মিত' : 'Irregular';
  String get pcosHint => isBn ? 'PCOS-এর মতো অনিয়ম' : 'PCOS-like irregularity';
  String get startDate => isBn ? 'শুরুর তারিখ' : 'Start date';
  String get endDate => isBn ? 'শেষের তারিখ' : 'End date';

  // ---- Flow measurement ----
  String get spotting => isBn ? 'দাগ' : 'Spotting';
  String get productUsed => isBn ? 'ব্যবহৃত পণ্য' : 'Product used';
  String get productPad => isBn ? 'প্যাড' : 'Pad';
  String get productTampon => isBn ? 'ট্যাম্পন' : 'Tampon';
  String get productCup => isBn ? 'মেনস্ট্রুয়াল কাপ' : 'Menstrual cup';
  String get productUnderwear => isBn ? 'পিরিয়ড আন্ডারওয়্যার' : 'Period underwear';
  String get productNone => isBn ? 'কোনোটি নয়' : 'None';
  String get clots => isBn ? 'জমাট বাঁধা রক্ত' : 'Clots';
  String get hasClots => isBn ? 'জমাট রক্ত ছিল' : 'Had clots';
  String get clotSize => isBn ? 'আকার' : 'Clot size';
  String get clotSmall => isBn ? 'ছোট' : 'Small';
  String get clotMedium => isBn ? 'মাঝারি' : 'Medium';
  String get clotLarge => isBn ? 'বড়' : 'Large';
  String get clotNone => isBn ? 'জমাট নেই' : 'No clots';

  // ---- Prediction ----
  String get predictionTitle => isBn ? 'ভবিষ্যদ্বাণী' : 'Prediction';
  String get confidenceLabel => isBn ? 'আস্থা' : 'Confidence';
  String confidence(int n) => isBn
      ? '${DateFormats.digits(n, bn: true)}% আস্থা'
      : '$n% confidence';
  String get expectedRange => isBn ? 'সম্ভাব্য সময়' : 'Expected window';
  String get expectedDate => isBn ? 'সম্ভাব্য তারিখ' : 'Expected date';
  String get regularCycles => isBn ? 'নিয়মিত চক্র' : 'Regular cycle';
  String get irregularCycles => isBn ? 'অনিয়মিত চক্র' : 'Irregular cycle';
  String get pcosPattern => isBn ? 'PCOS-এর মতো চক্র' : 'PCOS-like pattern';
  String get nextPeriodRange => isBn
      ? 'পরবর্তী পিরিয়ড এই সময়ের মধ্যে শুরু হতে পারে'
      : 'Next period may start within this window';
  String get onDeviceModel => isBn
      ? 'মডেলটি আপনার ডিভাইসেই চলে — কোনো তথ্য পাঠানো হয় না।'
      : 'The model runs on your device — nothing is sent anywhere.';
  String get improvesWithLogging => isBn
      ? 'প্রতিটি রেকর্ডকৃত চক্রে ভবিষ্যদ্বাণী আরও নির্ভুল হয়।'
      : 'Predictions improve with every logged cycle.';

  // ---- Nutrition hub ----
  String get nutrition => isBn ? 'পুষ্টি' : 'Nutrition';
  String get nutritionHub => isBn ? 'পুষ্টি হাব' : 'Nutrition hub';
  String get phaseMeals => isBn ? 'পর্যায়ভিত্তিক খাবার' : 'Phase-based meals';
  String get menstrualPhase => isBn ? 'মাসিক পর্যায়' : 'Menstrual phase';
  String get ovulatoryPhase => isBn ? 'ওভুলেটরি পর্যায়' : 'Ovulatory phase';
  String get lutealPhaseName => isBn ? 'লুটিয়াল পর্যায়' : 'Luteal phase';
  String get ironRich => isBn ? 'আয়রনসমৃদ্ধ খাবার' : 'Iron-rich foods';
  String get freshVegetables => isBn ? 'তাজা সবজি, হালকা প্রোটিন' : 'Fresh vegetables, light proteins';
  String get antiInflammatory => isBn ? 'প্রদাহরোধী খাবার, ওমেগা-৩' : 'Anti-inflammatory foods, omega-3';
  String get complexCarbs => isBn ? 'কমপ্লেক্স কার্ব, ম্যাগনেসিয়াম' : 'Complex carbs, magnesium-rich foods';
  String get lowGiHighlight => isBn ? 'PCOS-বান্ধব কম GI খাবার' : 'PCOS-friendly low-GI foods';
  String get waterIntake => isBn ? 'পানি গ্রহণ' : 'Water intake';
  String get cupsOf => isBn ? 'গ্লাস' : 'cups';
  String get waterGoal => isBn ? 'লক্ষ্য: ৮ গ্লাস' : 'Goal: 8 cups';
  String get addWater => isBn ? 'পানি যোগ করুন' : 'Add water';
  String get logFood => isBn ? 'খাবার রেকর্ড করুন' : 'Log food';
  String get searchFood => isBn ? 'খাবার খুঁজুন...' : 'Search foods...';
  String get ironChart => isBn ? 'আয়রন গ্রহণ' : 'Iron intake';
  String get ironUnit => isBn ? 'মিগ্রা' : 'mg';
  String get perServing => isBn ? 'প্রতি পরিবেশনে' : 'per serving';
  String get lowGi => isBn ? 'কম GI' : 'Low GI';
  String get foodLogged => isBn ? 'খাবার রেকর্ড হয়েছে' : 'Food logged';
  String get noFoodFound => isBn ? 'কোনো খাবার পাওয়া যায়নি' : 'No foods found';

  // ---- Pain & cramps ----
  String get painTracker => isBn ? 'ব্যথা ট্র্যাকার' : 'Pain tracker';
  String get painScale => isBn ? 'ব্যথার মাত্রা (১-১০)' : 'Pain scale (1-10)';
  String get painMild => isBn ? 'হালকা' : 'Mild';
  String get painModerate => isBn ? 'মাঝারি' : 'Moderate';
  String get painSevere => isBn ? 'তীব্র' : 'Severe';
  String get painLocations => isBn ? 'ব্যথার জায়গা' : 'Pain location';
  String get locLowerAbdomen => isBn ? 'তলপেট' : 'Lower abdomen';
  String get locLowerBack => isBn ? 'কোমর' : 'Lower back';
  String get locUpperBack => isBn ? 'পিঠের উপরের অংশ' : 'Upper back';
  String get locThighs => isBn ? 'উরু' : 'Thighs';
  String get locHips => isBn ? 'নিতম্ব' : 'Hips';
  String get locHead => isBn ? 'মাথা' : 'Head';
  String get reliefMethods => isBn ? 'উপশমের উপায়' : 'Relief methods';
  String get reliefHeat => isBn ? 'গরম সেঁক / হট ওয়াটার বোতল' : 'Heat pad / hot water bottle';
  String get reliefMedication => isBn ? 'ব্যথার ওষুধ' : 'Pain medication';
  String get reliefTea => isBn ? 'ভেষজ চা (আদা, ক্যামোমাইল)' : 'Herbal tea (ginger, chamomile)';
  String get reliefRest => isBn ? 'বিশ্রাম / ঘুম' : 'Rest / sleep';
  String get reliefStretching => isBn ? 'হালকা স্ট্রেচিং / যোগা' : 'Light stretching / yoga';
  String get reliefMassage => isBn ? 'ম্যাসাজ' : 'Massage';
  String get painDuration => isBn ? 'ব্যথার সময়কাল' : 'Pain duration';
  String get durationHours => isBn ? 'ঘণ্টা' : 'hours';
  String get durationMinutes => isBn ? 'মিনিট' : 'minutes';
  String get medication => isBn ? 'ওষুধ' : 'Medication';
  String get medName => isBn ? 'ওষুধের নাম' : 'Medication name';
  String get medDose => isBn ? 'ডোজ' : 'Dose';
  String get medTime => isBn ? 'সময়' : 'Time';
  String get medEffectiveness => isBn ? 'কার্যকারিতা (১-৫)' : 'Effectiveness (1-5)';
  String get medNameHint => isBn ? 'যেমন: আইবুপ্রোফেন' : 'e.g. Ibuprofen';
  String get medDoseHint => isBn ? 'যেমন: ৪০০ মিগ্রা' : 'e.g. 400 mg';

  // ---- Mood tracker ----
  String get moodTracker => isBn ? 'মেজাজ ট্র্যাকার' : 'Mood tracker';
  String get moodEnergetic => isBn ? 'শক্তিতে ভরা' : 'Energetic';
  String get moodTired => isBn ? 'ক্লান্ত' : 'Tired';
  String get moodAngry => isBn ? 'রাগান্বিত' : 'Angry';
  String get moodCustomLabel => isBn ? 'কাস্টম মেজাজ' : 'Custom mood';
  String get moodCustomHint => isBn ? 'আপনার মেজাজ লিখুন' : 'Describe your mood';
  String get energyLevel => isBn ? 'শক্তির মাত্রা' : 'Energy level';
  String get sleepQuality => isBn ? 'ঘুমের মান' : 'Sleep quality';
  String get sleepHours => isBn ? 'ঘুমের সময়কাল' : 'Sleep duration';
  String get sleepHoursUnit => isBn ? 'ঘণ্টা' : 'hours';
  String get moodCorrelation => isBn ? 'চক্রের সাথে মেজাজের সম্পর্ক' : 'Mood vs cycle phase';

  // ---- Reminders ----
  String get reminderPeriodPredict => isBn ? 'পিরিয়ড শুরুর ভবিষ্যদ্বাণী' : 'Period start prediction';
  String get reminderPeriodEnd => isBn ? 'পিরিয়ড শেষের চেক-ইন' : 'Period end check-in';
  String get reminderPill => isBn ? 'বড়ি/ওষুধ' : 'Pill / medication';
  String get reminderWater => isBn ? 'পানি' : 'Water';
  String get reminderSymptom => isBn ? 'উপসর্গ রেকর্ড' : 'Symptom log';
  String get reminderDoctor => isBn ? 'ডাক্তার অ্যাপয়েন্টমেন্ট' : 'Doctor appointment';
  String get quietHours => isBn ? 'নীরব সময়' : 'Quiet hours';
  String get quietHoursDesc => isBn
      ? 'ঘুমের সময় কোনো নোটিফিকেশন আসবে না।'
      : 'No notifications during your sleep hours.';
  String get quietStart => isBn ? 'শুরু' : 'Start';
  String get quietEnd => isBn ? 'শেষ' : 'End';
  String get notificationsOffline => isBn
      ? 'সব নোটিফিকেশন অফলাইনে কাজ করে — ইন্টারনেট লাগে না।'
      : 'All notifications work offline — no internet needed.';
  String get reminderTypes => isBn ? 'রিমাইন্ডারের ধরন' : 'Reminder types';
  String get periodPredictionDesc => isBn
      ? 'পিরিয়ড শুরুর ১-৩ দিন আগে জানান'
      : 'Notify 1-3 days before your period';
  String get periodEndDesc => isBn
      ? 'পিরিয়ড শেষের সময় চেক-ইন'
      : 'Check in when your period ends';
  String get pillDesc => isBn ? 'প্রতিদিন ওষুধের সময়' : 'Daily medicine time';
  String get waterDesc => isBn
      ? 'পিরিয়ডে প্রতি ২ ঘণ্টায় পানি'
      : 'Water every 2 hours during your period';
  String get symptomDesc => isBn
      ? 'প্রতিদিন উপসর্গ রেকর্ড করতে মনে করান'
      : 'Daily nudge to log symptoms';
  String get doctorDesc => isBn
      ? 'ডাক্তারের অ্যাপয়েন্টমেন্ট রিমাইন্ডার'
      : 'Doctor appointment reminder';

  /// Returns the localized calendar month-year label.
  String monthYear(DateTime d) => DateFormats.monthYear(d, bn: isBn);

  /// Returns a localized full date string.
  String fullDate(DateTime d) => DateFormats.full(d, bn: isBn);

  /// Returns a localized weekday name.
  String weekdayName(DateTime d) => DateFormats.weekday(d, bn: isBn);

  /// Formats a number with locale digits.
  String num(int n) => DateFormats.digits(n, bn: isBn);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => const ['en', 'bn'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  @override
  String toString() => 'AppLocalizationsDelegate()';
}
