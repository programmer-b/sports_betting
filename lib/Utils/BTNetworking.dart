import 'package:sports_betting/Commons/BTColors.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:html/dom.dart' as dom;

Future<dom.Document> fetchHtml({required String url}) async {
  final data = await _fetchWebData(uri: Uri.parse(url));
  return dom.Document.html(data.body);
}

Future<Response> _fetchWebData({required Uri uri}) async {
  try {
    final data = await http.get(uri);
    return data;
  } catch (e) {
    toast("$e", bgColor: btErrorColor, gravity: ToastGravity.TOP);
    rethrow;
  }
}
