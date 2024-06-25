import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ai/constant/constant.dart';
import 'package:flutter_ai/model/chat_message.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'api/service.dart';
import 'ui/chat_page.dart';

Future<void> main() async {
  Gemini.init(
    apiKey: AIService.apiKey,
    enableDebugging: true,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ChatMessageAdapter());
  await Hive.openBox<ChatMessage>('chat_messages');
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.white),
          actionsIconTheme: const IconThemeData(color: AppColors.white),
          // titleSpacing: 0,
          titleTextStyle: GoogleFonts.siemreap(
              fontSize: FontSize.fontSizeTitle,
              color: Colors.white,
              fontWeight: FontWeight.bold),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light,
          ),
        ),
        cardColor: AppColors.secondary,
        cardTheme: CardTheme(
          color: AppColors.secondary,
          margin: EdgeInsets.zero,
          elevation: 0,
          surfaceTintColor: AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.regular,
          ),
        ),
        textTheme: ThemeData.light()
            .textTheme
            .apply(fontFamily: "Siemreap", bodyColor: AppColors.primaryText),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(background: AppColors.primary),
      ),
      home: const AIChatPage(),
    );
  }
}
