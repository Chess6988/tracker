// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Inter', // Utilisation d'une police inspirée de Figma
      ),
      home: ExpenseTrackerHome(),
    );
  }
}

class ExpenseTrackerHome extends StatefulWidget {
  @override
  _ExpenseTrackerHomeState createState() => _ExpenseTrackerHomeState();
}

class _ExpenseTrackerHomeState extends State<ExpenseTrackerHome> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<Color?> _appBarColorAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _appBarColorAnimation = ColorTween(begin: Colors.white, end: Colors.blue).animate(_animationController);

    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColorAnimation.value,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: _animationController,
              color: Colors.blue,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text('Personal Expense Tracker', style: TextStyle(color: Colors.blue)),
        actions: [
          IconButton(icon: Icon(Icons.person, color: Colors.blue), onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contact'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FadeTransition(
              opacity: _animationController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(_animationController),
                child: Text(
                  'Welcome Back, John!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This Month\'s Expenses', style: TextStyle(color: Colors.white, fontSize: 18)),
                    SizedBox(height: 8),
                    Text(
                      '\$1,200.00',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.attach_money, color: Colors.white, size: 40),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 10,
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(1, 0),
                    end: Offset(0, 0),
                  ).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(0.1 * index, 0.9, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.fastfood, color: Colors.blue),
                            SizedBox(width: 10),
                            Text('Food', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Text('-\$50.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Add Expense Modal
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );

  }
}