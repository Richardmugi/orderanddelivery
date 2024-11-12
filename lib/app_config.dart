var this_year = DateTime.now().year.toString();

class AppConfig {
  static String copyright_text =
      "@ ECwestminister " + this_year; //this shows in the splash screen
  static String app_name = "O&D"; //this shows in the splash screen

  static String purchase_code =
      "7b4348d3-c3cd-4a8c-813c-c5d9f5397cfd"; //enter your purchase code for the app from codecanyon
  static String system_key =
      r"$2y$10$.V5Vvjjdb1lrBRdlDgIWDuYLREesdROcyZoL6jcz0yuYshmkz/Bbm"; //enter your purchase code for the app from codecanyon

  //Default language config
  static String default_language = "en";
  static String mobile_app_code = "en";
  static bool app_language_rtl = false;

  //configure this
  static const bool HTTPS = true;

  static const DOMAIN_PATH = "ec.westminister.tech"; //localhost

  //do not configure these below
  static const String API_ENDPATH = "api/v2";
  static const String PROTOCOL = HTTPS ? "https://" : "http://";
  static const String RAW_BASE_URL = "${PROTOCOL}${DOMAIN_PATH}";
  static const String BASE_URL = "${RAW_BASE_URL}/${API_ENDPATH}";

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
