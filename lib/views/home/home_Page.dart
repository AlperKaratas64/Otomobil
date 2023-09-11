import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otomobil/data/src/colors.dart';
import 'package:otomobil/data/src/images.dart';
import 'package:otomobil/data/src/strings.dart';
import 'package:otomobil/views/login/login_page.dart';
import 'package:otomobil/views/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/views/home/home_Page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeAppBarText),
        backgroundColor: teal,
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
      backgroundColor: mainColor,
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemBuilder: (_, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: _buildCard(index),
      ),
      itemCount: 5,
    );
  }

  Widget _buildCard(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('Not $index'),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildTitle(homeAppBarText, Icons.home, _goToback),
          _buildDivider(),
          _buildTitle(profiletext, Icons.person, _goToProfile),
          _buildDivider(),
          _buildTitle(logoutText, Icons.logout, _goToLogout),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text('Alper'),
      accountEmail: Text('Alperk6420@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(Logo),
      ),
      decoration: BoxDecoration(color: mainColor),
    );
  }

  Widget _buildTitle(String text, IconData, Function function) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        IconData,
        color: mainColor,
      ),
      onTap: () => function(),
    );
  }

  Widget _buildDivider() {
    return Divider();
  }

  void _goToback() {
    Get.back();
  }

  void _goToProfile() {
    Get.toNamed(ProfilePage.routeName);
  }

  void _goToLogout() {
    Get.offAndToNamed(LoginPage.routeName);
  }
}
