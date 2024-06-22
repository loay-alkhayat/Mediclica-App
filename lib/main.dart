import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/core/services/cache_storage_services.dart';
import 'package:mediclica/core/services/dio_services.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Auth/bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/main_screen.dart';
import 'package:mediclica/screens/OnBoarding/get_started_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bloc_observer/bloc_observer.dart';

Widget? home;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: Center(
          child: Text("Something Went wrong"),
        ),
      );
  Bloc.observer = MyBlocObserver();
  await DioServices().init();
  await CacheHelper.init();

  var barrierToken = CacheHelper.getData(key: "barrierToken");
  print(barrierToken);
  if (barrierToken != null) {
    home = MainScreen();
  } else {
    home = GetStartedScreen();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => LayoutCubit()
              ..getCategories()
              ..getDoctors()
              ..getProfile(),
          ),
        ],
        child: ResponsiveSizer(
          builder: (context, orientation, screenType) {
            return MaterialApp(
              theme: ThemeData(
                  useMaterial3: false,
                  scaffoldBackgroundColor: ColorManager.white,
                  appBarTheme: AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: ColorManager.white),
                  )),
              debugShowCheckedModeBanner: false,
              home: home,
            );
          },
        ));
  }
}
