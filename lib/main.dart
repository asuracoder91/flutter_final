import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // runApp 실행전 모든 binding을 초기화하는 명령어

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    const ProviderScope(child: FinalApp()),
  );
}

class FinalApp extends ConsumerWidget {
  const FinalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Mood Tracker',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansKrTextTheme(),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF6750A4),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xff6750a4),
          onPrimary: Color(0xffc3c3d2),
          primaryContainer: Color(0xffeaddff),
          onPrimaryContainer: Color(0xff131214),
          secondary: Color(0xffA69CCE),
          onSecondary: Color(0xffffffff),
          secondaryContainer: Color(0xFFF2F4F7),
          onSecondaryContainer: Color(0xff131214),
          tertiary: Color(0xff7d5260),
          onTertiary: Color(0xffffffff),
          tertiaryContainer: Color(0xffffd8e4),
          onTertiaryContainer: Color(0xff141213),
          error: Color(0xffb00020),
          onError: Color(0xffffffff),
          errorContainer: Color(0xfffcd8df),
          onErrorContainer: Color(0xff141213),
          background: Color(0xFFE8DEF8),
          onBackground: Color(0xff090909),
          surface: Color(0xfff9f8fb),
          onSurface: Color(0xff090909),
          surfaceVariant: Color(0xfff4f2f8),
          onSurfaceVariant: Color(0xff131213),
          outline: Color(0xff344054),
          shadow: Color(0xff000000),
          inverseSurface: Color(0xff141316),
          onInverseSurface: Color(0xffede7f5),
          inversePrimary: Color(0xff4d3c93),
          surfaceTint: Color(0xff6750a4),
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.white,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        useMaterial3: true,
      ),
    );
  }
}
