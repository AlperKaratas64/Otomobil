import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otomobil/data/src/colors.dart';
import 'package:otomobil/data/src/images.dart';
import 'package:otomobil/data/src/strings.dart';
import 'package:otomobil/views/account/account_page.dart';
import 'package:otomobil/views/info/info_page.dart';
import 'package:otomobil/views/secim/il_model.dart';
import 'package:otomobil/views/secim/il_secme_sayfasi.dart';
import 'package:otomobil/views/secim/ilce_secme_sayfasi.dart';
import 'package:otomobil/views/login/login_page.dart';
import 'package:otomobil/views/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/views/home/home_Page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

void main() {
  runApp(GetMaterialApp(
    home: HomePage(),
  ));
}

class _HomePage extends State<HomePage> {
  bool _yuklemeTamamlandiMi = false;
  late String _secilenIl = "";
  late String _secilenIlce = "";
  bool _ilSecilmisMi = false;
  bool _ilceSecilmisMi = false;
  List<dynamic> _illerListesi = [];
  List<String> _ilIsimleriListesi = [];
  List<String> _ilceIsimleriListesi = [];
  int? _secilenIlIndexi;
  int? _secilenIlceIndexi;
  late String email;

  Future<void> _illeriGetir() async {
    String jsonString = await rootBundle.loadString('json/il-ilce.json');
    final jsonResponse = json.decode(jsonString);
    _illerListesi = jsonResponse.map((x) => Il.fromJson(x)).toList();
  }

  void _ilIsimleriniGetir() {
    _ilIsimleriListesi = [];
    _illerListesi.forEach((element) {
      _ilIsimleriListesi.add(element.ilAdi);
    });
    setState(() {
      _yuklemeTamamlandiMi = true;
    });
  }

  void _secilenIlinIlceleriniGetir(String _secilenIl) {
    _ilceIsimleriListesi = [];
    _illerListesi.forEach((element) {
      if (element.ilAdi == _secilenIl) {
        element.ilceler.forEach((element) {
          _ilceIsimleriListesi.add(element.ilceAdi);
        });
      }
    });
  }

  Future<void> _ilSecmeSayfasinaGit() async {
    if (_yuklemeTamamlandiMi) {
      _secilenIlIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              IlSecimiSayfasi(ilIsimleri: _ilIsimleriListesi, key: UniqueKey()),
        ),
      );

      if (_secilenIlIndexi != null) {
        _secilenIlceIndexi = null;
        _ilSecilmisMi = true;
        _secilenIl = _ilIsimleriListesi[_secilenIlIndexi!];
        _secilenIlinIlceleriniGetir(_illerListesi[_secilenIlIndexi!].ilAdi);
        setState(() {});
      }
    }
  }

  Future<void> _ilceSecmeSayfasinaGit() async {
    if (_ilSecilmisMi) {
      _secilenIlinIlceleriniGetir(_secilenIl);
      _secilenIlceIndexi = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IlceSecmeSayfasi(
            ilceIsimleri: _ilceIsimleriListesi,
            key: UniqueKey(),
          ),
        ),
      );

      if (_secilenIlceIndexi != null) {
        _ilceSecilmisMi = true;
        _secilenIlce = _ilceIsimleriListesi[_secilenIlceIndexi!];
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _illeriGetir().then((value) => _ilIsimleriniGetir());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              Ililcesecimtext,
              style: TextStyle(color: black),
            ),
          ],
        ),
        backgroundColor: teal,
        centerTitle: true,
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      backgroundColor: teal,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSpace(),
            _buildCityNameText(),
            _buildCityText(),
            _buildSpace(),
            _buildCountyNameText(),
            _buildCountyText(),
            _buildDropDownButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _buildDropDownButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Seçilen İl : $_secilenIl",
                style: TextStyle(fontSize: 26),
              ),
              Text(
                "Seçilen İlçe : $_secilenIlce",
                style: TextStyle(fontSize: 26),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCityText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: ElevatedButton(
        child: Center(
          child: Text(
            Ilsecim,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
        ),
        onPressed: () async {
          await _ilSecmeSayfasinaGit();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: white,
        ),
      ),
    );
  }

  Widget _buildCountyText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: ElevatedButton(
        child: Center(
          child: Text(
            Ilcesecim,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: black,
            ),
          ),
        ),
        onPressed: () async {
          await _ilceSecmeSayfasinaGit();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: white,
        ),
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
          _buildTitle(AccountText, Icons.account_balance, _goToAccount),
          _buildDivider(),
          _buildTitle(infoText, Icons.info, _goToInfo),
          _buildDivider(),
          _buildTitle(logoutText, Icons.logout, _goToLogout),
        ],
      ),
      backgroundColor: yellowBack,
    );
  }

  Widget _buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text('Alper'),
      accountEmail: Text('snapshot.data.email'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: white,
        child: Text("A"),
      ),
      decoration: BoxDecoration(color: blueBack),
    );
  }

  Widget _buildCityNameText() {
    return Text(
      Ilsecim,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Checkbox.width,
      ),
    );
  }

  Widget _buildCountyNameText() {
    return Text(
      Ilcesecim,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Checkbox.width,
      ),
    );
  }

  Widget _buildTitle(String text, IconData, Function function) {
    return ListTile(
      title: Text(text),
      leading: Icon(
        IconData,
        color: blue,
      ),
      onTap: () => function(),
    );
  }

  Widget _buildDivider() {
    return Divider();
  }

  void _goToback() {
    Navigator.pop(context);
  }

  void _goToProfile() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  void _goToLogout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void _goToAccount() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => accountPage(),
      ),
    );
  }

  void _goToInfo() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => InfoPage(),
      ),
    );
  }
}
