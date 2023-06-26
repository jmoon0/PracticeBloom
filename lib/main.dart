import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practicebloom/pages/goals_page.dart';
import 'package:practicebloom/pages/home_page.dart';
import 'package:practicebloom/pages/log_page.dart';
import 'package:practicebloom/pages/login_page.dart';
import 'package:practicebloom/pages/welcome_page.dart';
import 'package:practicebloom/providers/user_provider.dart';
import 'package:practicebloom/util/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
          useMaterial3: true, 
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.active){
              if(snapshot.hasData){
                return const RootPage();
              }
              else{
                return const WelcomePage();
              }
            } else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'));
            }
            else{
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onBackground,  
                )
              );
            }
          }
        ),
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomePage(),
    const LogPage(),
    const GoalsPage(),
  ];

  @override
  void initState(){
    super.initState();
    addData();
  }
  
  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  void onNavPress(index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            selectedIcon: Icon(Icons.view_list),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.insert_chart_outlined_outlined),
            selectedIcon: Icon(Icons.insert_chart),
            label: 'Goals',
          ),
        ],
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}
