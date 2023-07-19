import 'package:chat/Core/Base/BaseState.dart';
import 'package:chat/Core/DI/di.dart';
import 'package:chat/Core/Providers/AppConfigProvider.dart';
import 'package:chat/Core/Theme/MyTheme.dart';
import 'package:chat/Domain/UseCase/SignOutUseCase.dart';
import 'package:chat/Presintation/Create%20Room/CreateRoomView.dart';
import 'package:chat/Presintation/Home/HomeNavigator.dart';
import 'package:chat/Presintation/Home/HomeViewModel.dart';
import 'package:chat/Presintation/Login/LoginView.dart';
import 'package:chat/Presintation/Search/SearchView.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {

  @override
  HomeViewModel initialViewModel() {
    return HomeViewModel(SignOutUseCase(injectAuthRepo()));
  }
  @override
  void initState() {
    super.initState();
    viewModel!.provider = Provider.of<AppConfigProvider>(context , listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) => Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: MyTheme.white,
            ),
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/images/bgShape.png',
                fit: BoxFit.cover,
              ),
            ),
            Scaffold(
              appBar: AppBar(
                title: Text(
                  "Home",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: MyTheme.white),
                ),
                actions: [
                  InkWell(
                      onTap: value.goToSearchScreen,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(
                          EvaIcons.search,
                          color: MyTheme.white,
                        ),
                      ))
                ],
              ),
              drawer: Drawer(
                shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 200,
                      decoration: const BoxDecoration(
                        color: MyTheme.blue,
                      ),
                      child: Text(
                        viewModel!.provider?.user?.displayName??"UnFound Name" ,
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(color: MyTheme.white),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: value.onSignOutPress,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(Colors.red)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Out" ,
                                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: MyTheme.white),
                              ),
                              const SizedBox(width: 10,),
                              const Icon(EvaIcons.logOut , color: MyTheme.white,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: value.goToCreateRoomScreen,
                backgroundColor: MyTheme.blue,
                child: const Icon(
                  EvaIcons.plus,
                  color: MyTheme.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  goToSearchScreen() {
    Navigator.pushNamed(context, SearchView.routeName);
  }

  @override
  goToCreateRoomScreen() {
    Navigator.pushNamed(context, CreateRoomView.routeName);
  }

  @override
  goToLoginScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
