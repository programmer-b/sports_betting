
import 'package:nb_utils/nb_utils.dart';
import 'package:html/dom.dart' as dom;

Future<void> stractureAndApplyWebdata({required dom.Document html}) async {

  final time = html
      .querySelectorAll(
          '#item-28874 > div:nth-child(3) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(1) > strong:nth-child(1) > span:nth-child(1)')
      .map((e) => e.innerHtml.trim())
      .toList();
  log('TIME: $time');
}
