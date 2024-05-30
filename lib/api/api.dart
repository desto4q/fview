import 'package:dio/dio.dart';

class Info {}

Future getBin() async {
  var response = await Dio()
      .get("https://api.jsonbin.io/v3/b/664bead4ad19ca34f86ca2d8?meta=false");
  print([response, "sos"]);
  return response;
}

Future getPopular(int? page) async {
  try {
    var response = await Dio().get(
        "https://dezz-consument.vercel.app/anime/gogoanime/popular?page=${page ?? 1}");
    return response.data;
  } catch (error) {
    rethrow;
  }
}
