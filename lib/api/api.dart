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

Future getTop(int? page) async {
  try {
    var response = await Dio().get(
        "https://dezz-consument.vercel.app/anime/gogoanime/top-airing?page=${page ?? 1}");
    return response.data;
  } catch (error) {
    rethrow;
  }
}

Future getid(String? id) async {
  try {
    var response = await Dio().get(
        "https://dezz-consument.vercel.app/anime/gogoanime/info/${id ?? "naruto"}");
    return response.data;
  } catch (error) {
    rethrow;
  }
}

Future getEpisode(String? id) async {
  try {
    var response = await Dio().get(
        "https://dezz-consument.vercel.app/anime/gogoanime/watch/$id?server=gogocdn");
    return response.data;
  } catch (error) {
    rethrow;
  }
}

Future getRecent(int? page) async {
  try {
    var response = await Dio().get(
        "https://dezz-consument.vercel.app/anime/gogoanime/recent-episodes?page=${page ?? 1}");
    return response.data;
  } catch (error) {
    rethrow;
  }
}

Future getApi(int? page, String? query) async {
  try {
    var response = await Dio().get(
      "https://dezz-consument.vercel.app/anime/gogoanime/${query ?? "naruto"}?page=${page ?? 1}",
    );
    return response.data;
  } catch (err) {
    rethrow;
  }
}

Future getGenrelist() async {
  try {
    var response = await Dio()
        .get("https://dezz-consument.vercel.app/anime/gogoanime/genre/list");
    return response.data;
  } catch (err) {
    rethrow;
  }
}
