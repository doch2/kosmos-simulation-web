import 'package:get/get.dart';

import '../pages/home/binding.dart';
import '../pages/home/page.dart';
import 'routes.dart';

class KOSMOSSimulationWebPages {
  static final pages = [
    GetPage(name: PageRoutes.HOME, page: () => const HomePage(), binding: HomePageBinding(), transition: Transition.noTransition),
  ];
}
