import 'dart:math';

class Utils{

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = diff.inHours.toString() + ' ' + 'saat önce';
      } else if (diff.inMinutes > 0) {
        time = diff.inMinutes.toString() + ' ' + 'dakika önce';
      } else if (diff.inSeconds > 0) {
        time = 'şimdi';
      } else if (diff.inMilliseconds > 0) {
        time = 'şimdi';
      } else if (diff.inMicroseconds > 0) {
        time = 'şimdi';
      } else {
        time = 'şimdi';
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      time = diff.inDays.toString() + ' ' + 'gün önce';
    } else if (diff.inDays > 6) {
      time = (diff.inDays / 7).floor().toString() + ' ' + 'hafta önce';
    } else if (diff.inDays > 29) {
      time = (diff.inDays / 30).floor().toString() + ' ' + 'ay önce';
    } else if (diff.inDays > 365) {
      time = '${date.month} ${date.day}, ${date.year}';
    }
    return time;
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }
}