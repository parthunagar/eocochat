//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

// ignore: todo
//TODO:---- All localizations settings----

class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  final String languageNameInEnglish;

  Language(this.id, this.flag, this.name, this.languageCode,
      this.languageNameInEnglish);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇺🇸", "English", "en", "English"),
      Language(9, "🇯🇵", "日本語", "ja", "Japan"),
      Language(2, "🇧🇩", "বাংলা", "bn", "Bengali"),
      Language(3, "🇸🇦", "اَلْعَرَبِيَّةُ", "ar", "Arabic"),
      Language(4, "🇮🇳", "हिंदी", "hi", " Hindi"),
      Language(5, "🇩🇪", "German", "de", "German"),
      Language(6, "🇪🇸", "Espagnol", "es", "Spanish"),
      Language(7, "🇫🇷", "Français", "fr", "French"),
      Language(8, "🇮🇩", "Bahasa", "id", "Indonesian"),
      Language(10, "🇰🇷", "한국어", "ko", "Korean"),
      Language(11, "🇹🇷", "Türk", "tr", "Turkish"),
      Language(12, "🇨🇳", "中文", "zh", "Chinese"),
      Language(13, "🇻🇳", "Tiếng Việt", "vi", "Vietnamese"),
      Language(14, "🇳🇱", "Nederlands", "nl", "Dutch"),
      //---
      Language(15, "🇵🇹", "português", "pt", "Portuguese"),
      Language(16, "🇵🇰", "اردو", "ur", "Urdu"),
      Language(17, "🇷🇺", "русский", "ru", "Russian"),
      Language(18, "🇰🇪", "kiswahili", "sw", "Swahili"),
    ];
  }
}
