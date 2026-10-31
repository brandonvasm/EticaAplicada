import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';
import 'app_localizations_quc.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es'),
    Locale('quc'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'InfoG'**
  String get appTitle;

  /// No description provided for @homeWelcome.
  ///
  /// In es, this message translates to:
  /// **'Encuentra fácilmente los servicios públicos para migrantes y retornados en Guatemala'**
  String get homeWelcome;

  /// No description provided for @selectLanguage.
  ///
  /// In es, this message translates to:
  /// **'SELECCIONA TU IDIOMA'**
  String get selectLanguage;

  /// No description provided for @supportDirectory.
  ///
  /// In es, this message translates to:
  /// **'Directorio de Apoyo'**
  String get supportDirectory;

  /// No description provided for @supportDirectorySub.
  ///
  /// In es, this message translates to:
  /// **'Accede a trámites consulares, empleo, documentación y orientación legal con solo unos toques.'**
  String get supportDirectorySub;

  /// No description provided for @searchServices.
  ///
  /// In es, this message translates to:
  /// **'Buscar servicios'**
  String get searchServices;

  /// No description provided for @privacyNoticeTitle.
  ///
  /// In es, this message translates to:
  /// **'Aviso de privacidad'**
  String get privacyNoticeTitle;

  /// No description provided for @privacyNoticeBody.
  ///
  /// In es, this message translates to:
  /// **'InfoG respeta tu privacidad. Esta aplicación no recopila datos personales sin tu consentimiento.'**
  String get privacyNoticeBody;

  /// No description provided for @privacyNoticeDetail.
  ///
  /// In es, this message translates to:
  /// **'La información que proporcionas se utiliza únicamente para mejorar tu experiencia y conectarte con los servicios adecuados. Tus datos están protegidos conforme a la legislación guatemalteca vigente.'**
  String get privacyNoticeDetail;

  /// No description provided for @securityTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuestros compromisos con tu seguridad:'**
  String get securityTitle;

  /// No description provided for @securityRule1.
  ///
  /// In es, this message translates to:
  /// **'No compartimos tu información con terceros'**
  String get securityRule1;

  /// No description provided for @securityRule2.
  ///
  /// In es, this message translates to:
  /// **'Puedes solicitar la eliminación de tus datos en cualquier momento'**
  String get securityRule2;

  /// No description provided for @securityRule3.
  ///
  /// In es, this message translates to:
  /// **'Usamos conexiones seguras para proteger tu información'**
  String get securityRule3;

  /// No description provided for @acceptAndContinue.
  ///
  /// In es, this message translates to:
  /// **'Aceptar y continuar'**
  String get acceptAndContinue;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navServices.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get navServices;

  /// No description provided for @navInstitutions.
  ///
  /// In es, this message translates to:
  /// **'Instituciones'**
  String get navInstitutions;

  /// No description provided for @navHelp.
  ///
  /// In es, this message translates to:
  /// **'Ayuda'**
  String get navHelp;

  /// No description provided for @servicesTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicios Disponibles'**
  String get servicesTitle;

  /// No description provided for @servicesSearchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar trámites o servicios...'**
  String get servicesSearchPlaceholder;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @filterConsular.
  ///
  /// In es, this message translates to:
  /// **'Trámites Consulares'**
  String get filterConsular;

  /// No description provided for @filterEmployment.
  ///
  /// In es, this message translates to:
  /// **'Empleo'**
  String get filterEmployment;

  /// No description provided for @filterDocumentation.
  ///
  /// In es, this message translates to:
  /// **'Documentación'**
  String get filterDocumentation;

  /// No description provided for @filterLegal.
  ///
  /// In es, this message translates to:
  /// **'Orientación Legal'**
  String get filterLegal;

  /// No description provided for @institutionsTitle.
  ///
  /// In es, this message translates to:
  /// **'Directorio de Instituciones'**
  String get institutionsTitle;

  /// No description provided for @institutionsSearchPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Buscar institución...'**
  String get institutionsSearchPlaceholder;

  /// No description provided for @phone.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phone;

  /// No description provided for @address.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get address;

  /// No description provided for @website.
  ///
  /// In es, this message translates to:
  /// **'Sitio web'**
  String get website;

  /// No description provided for @helpTitle.
  ///
  /// In es, this message translates to:
  /// **'Centro de Ayuda y Preguntas Frecuentes'**
  String get helpTitle;

  /// No description provided for @helpSubtitle.
  ///
  /// In es, this message translates to:
  /// **'¿Necesitas asistencia o tienes dudas sobre tus trámites?'**
  String get helpSubtitle;

  /// No description provided for @contactSupport.
  ///
  /// In es, this message translates to:
  /// **'Contactar Soporte'**
  String get contactSupport;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In es, this message translates to:
  /// **'Preguntas Frecuentes'**
  String get frequentlyAskedQuestions;

  /// No description provided for @detailProcedure.
  ///
  /// In es, this message translates to:
  /// **'Pasos para el trámite'**
  String get detailProcedure;

  /// No description provided for @detailRequirements.
  ///
  /// In es, this message translates to:
  /// **'Requisitos'**
  String get detailRequirements;

  /// No description provided for @detailCost.
  ///
  /// In es, this message translates to:
  /// **'Costo'**
  String get detailCost;

  /// No description provided for @free.
  ///
  /// In es, this message translates to:
  /// **'Gratuito'**
  String get free;

  /// No description provided for @situationTitle.
  ///
  /// In es, this message translates to:
  /// **'Cuéntanos tu situación'**
  String get situationTitle;

  /// No description provided for @situationExtranjeroTitle.
  ///
  /// In es, this message translates to:
  /// **'Estoy en el extranjero'**
  String get situationExtranjeroTitle;

  /// No description provided for @situationExtranjeroSub.
  ///
  /// In es, this message translates to:
  /// **'Servicios consulares y trámites a distancia'**
  String get situationExtranjeroSub;

  /// No description provided for @situationRetornadoTitle.
  ///
  /// In es, this message translates to:
  /// **'Soy retornad@/a'**
  String get situationRetornadoTitle;

  /// No description provided for @situationRetornadoSub.
  ///
  /// In es, this message translates to:
  /// **'Reinserción, empleo y documentación'**
  String get situationRetornadoSub;

  /// No description provided for @situationFamiliarTitle.
  ///
  /// In es, this message translates to:
  /// **'Tengo un familiar migrante'**
  String get situationFamiliarTitle;

  /// No description provided for @situationFamiliarSub.
  ///
  /// In es, this message translates to:
  /// **'Localización, apoyo legal y trámites'**
  String get situationFamiliarSub;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es', 'quc'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
    case 'quc':
      return AppLocalizationsQuc();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
