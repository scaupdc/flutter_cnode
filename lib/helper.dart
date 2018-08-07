String fromNow(String datetime) {
  final _now = new DateTime.now();
  final _datetime = DateTime.parse(datetime);
  final _diff = _now.difference(_datetime);
  if (_diff.inMinutes < 60) {
    return '${_diff.inMinutes}分钟前';
  } else if (_diff.inHours < 10) {
    return '${_diff.inHours}小时前';
  } else {
    return '${_datetime.year}年${_datetime.month}月${_datetime.day}日 ${_datetime.hour}:${_datetime.minute}:${_datetime.second}';
  }
}
