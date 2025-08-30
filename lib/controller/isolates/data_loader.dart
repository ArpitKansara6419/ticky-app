import 'dart:async';
import 'dart:isolate';

class DataLoader {
  /// Runs the provided function in an isolate and returns its result.
  static Future<T> runInIsolate<T>(FutureOr<T> Function() function) async {
    final receivePort = ReceivePort(); // Port to receive messages from the isolate
    final completer = Completer<T>();

    // Spawn the isolate
    await Isolate.spawn(_isolateEntryPoint, [function, receivePort.sendPort]);

    // Listen for the result
    receivePort.listen((data) {
      if (data is T) {
        // Complete with the result
        completer.complete(data);
        receivePort.close(); // Close the port
      } else if (data is ErrorResult) {
        // Handle errors if any
        completer.completeError(data.error, data.stackTrace);
        receivePort.close();
      }
    });

    return completer.future;
  }

  /// Isolate entry point (runs the function in the isolate)
  static void _isolateEntryPoint(List<dynamic> args) async {
    final function = args[0] as FutureOr Function();
    final sendPort = args[1] as SendPort;

    try {
      // Execute the function and send the result back
      final result = await function();
      sendPort.send(result);
    } catch (e, stackTrace) {
      // Send the error and stack trace back to the main isolate
      sendPort.send(ErrorResult(e, stackTrace));
    }
  }
}

/// A wrapper class for sending error details from an isolate
class ErrorResult {
  final Object error;
  final StackTrace stackTrace;

  ErrorResult(this.error, this.stackTrace);
}
