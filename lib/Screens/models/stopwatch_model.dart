import 'package:get/get.dart';

class StopwatchModel {
  final Stopwatch stopwatch = Stopwatch();
  final RxList<String> _laps = <String>[].obs;

  String get formattedTime {
    final duration = Duration(milliseconds: stopwatch.elapsedMilliseconds);
    return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}.${(duration.inMilliseconds % 1000).toString().padLeft(3, '0')}';
  }

  List<String> get laps => _laps.toList();

  void start() {
    stopwatch.start();
    _laps.clear();
  }

  void stop() {
    stopwatch.stop();
  }

  void reset() {
    stopwatch.reset();
    _laps.clear();
  }

  void lap({required String sessionID, required String exerciseId}) {
    final lapTime = formattedTime;
    _laps.insert(0, lapTime);
  }
}
