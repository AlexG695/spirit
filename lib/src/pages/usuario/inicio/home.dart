import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:integradora/src/model/user.dart';
import 'package:integradora/src/pages/usuario/inicio/home_controller.dart';
import 'package:integradora/src/utils/mycolors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  HomeController _con = HomeController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    key:
    _con.key;
    body:
    Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.67,
            child: _googleMaps()),
        SafeArea(
          // en caso de notch no ocupe esa area
          child: Column(
            children: [
              //_buttonCenterPosition(),
              Spacer(),
              _cardInfo(),
            ],
          ),
        ),
      ],
    );
    drawer:
    _drawer();
  }

  Widget _iconMyLocation() {
    return Image.asset(
      'assets/img/map_pin.png',
      width: 65,
      height: 65,
    );
  }

  Widget _cardInfo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.33,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ]),
        child: Column(
          children: [
            _UserInfo(),
          ],
        ));
  }

  Widget _UserInfo() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Row(
          children: [
            Container(margin: EdgeInsets.only(left: 10), child: Text('')),
            Spacer(),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.grey[200]),
                child: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.phone, color: Colors.black)))
          ],
        ));
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: MyColors.primaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userImg(),
                const SizedBox(width: 20),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ])
              ],
            ),
          ),
          ListTile(
            title: Text('Mis contactos'),
            onTap: _goToMyContacts,
            leading: Icon(Icons.group_outlined),
          ),
          ListTile(
            title: Text('Buy me a coffee (beta)'),
            // onTap: _gotoAboutUs,
            leading: Icon(Icons.coffee),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          _con.user != null
              ? _con.user.roles.length > 1
                  ? ListTile(
                      onTap: _con.goToRoles,
                      title: Text('Cambiar de rol'),
                      leading: Icon(Icons.person_outline),
                    )
                  : Container()
              : Container(),
          ListTile(
            title: Text('Soporte'),
            onTap: _con.goToSupport,
            leading: Icon(Icons.support_agent_outlined),
          ),
          ListTile(
            title: Text('Acerca de'),
            onTap: _con.goToAbout,
            leading: Icon(Icons.info_outline),
          ),
          Divider(
            color: Colors.grey[400],
          ),
          const SizedBox(height: 5),
          _buttonLogout(),
        ],
      ),
    );
  }

  Widget _buttonLogout() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: ElevatedButton(
        onPressed: _con.logout,
        child: const Text('Cerrar sesión'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void _gotoAboutUs() {
    Navigator.pushNamed(context, 'aboutUs');
  }

  void _goToMyContacts() {
    Navigator.pushNamed(context, 'usuario/friends');
  }

  Widget _userImg() {
    return Container(
      child: GestureDetector(
        child: CircleAvatar(
          backgroundImage: _con.imageFile != null
              ? FileImage(_con.imageFile)
              : _con.user?.image != null
                  ? NetworkImage(_con.user?.image)
                  : AssetImage('assets/img/user_profile.png'),
          radius: 50,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _userImgOpenMenu() {
    return Container(
      margin: EdgeInsets.only(left: 10),
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: _con.openDrawer,
        child: CircleAvatar(
          backgroundImage: _con.imageFile != null
              ? FileImage(_con.imageFile)
              : _con.user?.image != null
                  ? NetworkImage(_con.user?.image)
                  : AssetImage('assets/img/user_profile.png'),
          radius: 18,
          backgroundColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buttonAlert() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 65, vertical: 25),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          'Solicitar ayuda',
        ),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: Colors.red),
      ),
    );
  }

  Widget _cardAddress() {
    return Container(
      child: Card(
        color: Colors.grey[800],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            _con.addressName ?? '',
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onCameraMove: (position) {
        _con.initialPosition = position;
      },
      onCameraIdle: () async {
        await _con.setLocationDraggableInfo();
      },
    );
  }

  void refresh() {
    setState(() {});
  }
}
