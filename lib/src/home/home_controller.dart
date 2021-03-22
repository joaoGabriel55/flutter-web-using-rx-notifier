import 'package:flutter_web_app/src/domain/apollo_eleven.dart';
import 'package:flutter_web_app/src/home/home_service.dart';
import 'package:rx_notifier/rx_notifier.dart';

class HomeController {
  final _loading = RxNotifier<bool>(true);
  final _apolloElevenImages = RxNotifier<List<ApolloEleven>>([]);
  final _homeService = HomeService();

  HomeController() {
    loadApolloElevenImages();
  }

  loadApolloElevenImages() async {
    try {
      this._loading.value = true;
      var result = await _homeService.getApolloElevenImages();
      this._apolloElevenImages.value = result;
      this._loading.value = false;
    } catch (e) {
      this._loading.value = false;
    }
  }

  getApolloElevenImages() => this._apolloElevenImages.value;

  isLoading() => this._loading.value;

  bool get isEmpty => this._apolloElevenImages.value.isEmpty;
}
