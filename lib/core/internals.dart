import 'package:extensions_runtime/extensions_runtime.dart';

abstract class EInternals {
  static Future<void> initialize({
    required final ERuntimeOptions runtime,
  }) async {
    await ERuntimeManager.initialize(runtime);
  }

  static Future<void> dispose() async {
    await ERuntimeManager.dispose();
  }
}
