import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'theme.dart';
import 'views/standard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await windowManager.setTitleBarStyle(TitleBarStyle.hidden);

  await windowManager.setMinimumSize(const Size(336, 509));
  runApp(const MainWindow());
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(32),
            child: WindowCaption(
              title: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 1, 0, 0),
                  child: Text('Calculator',
                      style: AppTheme.current.appTitleBarFont)),
              backgroundColor: AppTheme.current.surface,
              brightness: Brightness.dark,
            ),
          ),
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: DefaultTextStyle(
              style: AppTheme.current.surfaceDefaultFont,
              child: Container(
                  color: AppTheme.current.surface,
                  padding: const EdgeInsets.fromLTRB(3, 2, 3, 3),
                  child: const StandardView()),
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
