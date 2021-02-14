import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  int localeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: supportedLocales,
      locale: supportedLocales[localeIndex],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData.from(
        colorScheme: currentPage == 1
            ? theColorScheme
            : currentPage == 2
                ? monotoneColorScheme
                : ColorScheme.light(),
        textTheme:
            currentPage == 2 ? theTextTheme : Typography.material2018().black,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Drawerが開けなくなるのでleadingはコメントアウト。
            // leading: Icon(Icons.assignment_late),
            title: Text('My Awesome App'),
            actions: [
              IconButton(
                  icon: Icon(Icons.airline_seat_recline_normal_rounded),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.baby_changing_station_outlined),
                  onPressed: () {}),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: FlutterLogo(),
            ),
            bottom: TabBar(tabs: [
              Tab(icon: Icon(Icons.add_location_sharp)),
              Tab(text: 'tab'),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.admin_panel_settings_sharp),
            onPressed: () {},
          ),
          drawer: Drawer(
              child: ListView(children: [
            DrawerHeader(child: Text('DrawerHeader')),
            for (int i = 0; i < 3; i++)
              ListTile(
                leading: Icon(Icons.wifi_rounded),
                title: Text('ListTile Title'),
                subtitle: Text('ListTile Subtitle'),
                trailing: Icon(Icons.adjust_rounded),
                onTap: () {},
              ),
            AboutListTile(
              applicationName: 'ApplicationName',
              applicationLegalese: 'ApplicationLegalese',
              applicationIcon: Icon(Icons.announcement),
              applicationVersion: 'v1.0.0',
              icon: Icon(Icons.admin_panel_settings),
              child: Text('AboutListTile Child'),
              aboutBoxChildren: [
                Text('AboutBoxChildren 1'),
                Text('AboutBoxChildren 2'),
              ],
            ),
          ])),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (value) {
              setState(() {
                currentPage = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_rounded), label: 'default'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard), label: 'colorScheme'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.timer), label: 'textTheme'),
            ],
          ),
          body: Column(
            children: [
              Text('This is a sentence in English.'),
              Text('日本語で書かれた文です。'),
              Text('นี่คือประโยคที่เขียนเป็นภาษาไทย'),
              Builder(
                builder: (context) {
                  final materialLocalization =
                      Localizations.of<MaterialLocalizations>(
                          context, MaterialLocalizations);
                  return Text('locale: ${Localizations.localeOf(context)}\n'
                      'MaterialLocalization: ${materialLocalization.runtimeType}\n'
                      'ScriptCategory: ${materialLocalization.scriptCategory}');
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: Text('ElevatedButton')),
                  ElevatedButton(
                      onPressed: null, child: Text('ElevatedButton')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Builder(
                    builder: (context) => OutlinedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text('AlertDialog Title'),
                                    content: Text('AlertDialog Content'),
                                    actions: [
                                      TextButton(
                                          child: Text('Action1'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                      TextButton(
                                          child: Text('Action2'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  ));
                        },
                        child: Text('show a dialog')),
                  ),
                  TextButton(
                    child: Text('change locale'),
                    onPressed: () {
                      setState(() {
                        localeIndex =
                            (localeIndex + 1) % supportedLocales.length;
                      });
                    },
                  ),
                ],
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Card'),
              )),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'must be less than 3 characters■'),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) =>
                    value.length < 3 ? null : 'input is invalid',
              ),
              Expanded(
                child: ListView(children: [
                  for (int i = 0; i < 7; i++)
                    ListTile(
                      leading: Icon(Icons.translate),
                      title: Text('ListTile Title'),
                      subtitle: Text('ListTile Subtitle'),
                      trailing: Icon(Icons.alarm_on_rounded),
                      onTap: () {},
                    ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// 実験用ColorSchemeです。
/// どこにも使われていないと思われるものはColors.brownにしています。
final ColorScheme theColorScheme = ColorScheme(
  primary: Colors.teal[300], // appBarの背景、ElevatedButtonの色など
  primaryVariant: Colors.brown,
  secondary: Colors.red[200], // FloatingActionButtonの色など
  secondaryVariant: Colors.brown,
  surface: Colors.green[300], // Cardの色など
  background: Colors.orange[100], // Scaffoldのbodyの背景色など
  error: Colors.red, // TextFormFieldのvalidation失敗時の色など
  onPrimary: Colors.yellow, // ElevatedButtonのテキストの色など
  onSecondary: Colors.orange[900], // FloatingActionButtonのchildの色など
  onSurface: Colors.brown,
  onBackground: Colors.brown,
  onError: Colors.brown,
  brightness: Brightness.light,
);

/// 実験用TextThemeです。
/// どこにも使われていないと思われるものはColors.brownにしています。
final TextTheme theTextTheme =
    GoogleFonts.abrilFatfaceTextTheme(Typography.material2018().black.copyWith(
          headline1: TextStyle(color: Colors.brown),
          headline2: TextStyle(color: Colors.brown),
          headline3: TextStyle(color: Colors.brown),
          headline4: TextStyle(color: Colors.brown),
          headline5:
              TextStyle(color: Colors.teal), // AboutDialogのapplicationNameなど
          headline6: TextStyle(color: Colors.cyan), // AlertDialogのtitleなど
          subtitle1: TextStyle(color: Colors.orange), // ListTileのtitleなど
          subtitle2: TextStyle(color: Colors.brown),
          bodyText1:
              TextStyle(color: Colors.pink[200]), // Drawer内のListTileのtitleなど
          bodyText2: TextStyle(color: Colors.red), // 通常のTextなど
          // ボタンの色はprimaryColorやonPrimaryで上書きされるため、下の.copyWithでフォントを指定してわかるようにします。
          button: TextStyle(color: Colors.brown),
          caption: TextStyle(color: Colors.purple), // ListTileのsubtitleなど
          overline: TextStyle(color: Colors.brown),
        )).copyWith(
  button: GoogleFonts.sofia(), // ElevatedButtonのテキストなど
);

/// 色のないColorScheme
/// これを使った時に色がついている場所は、ColorScheme以外の由来で色がついているのだとわかります。
final ColorScheme monotoneColorScheme = ColorScheme(
  primary: Colors.white,
  primaryVariant: Colors.white,
  secondary: Colors.black,
  secondaryVariant: Colors.black,
  surface: Colors.grey[500],
  background: Colors.grey[400],
  error: Colors.black,
  onPrimary: Colors.black,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.light,
);

final List<Locale> supportedLocales = [
  Locale('en'),
  Locale('ja'),
  Locale('th'),
];
