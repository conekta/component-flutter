import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Intercepts `dart:io` HttpClient calls and returns a minimal valid SVG.
///
/// CardForm renders several `SvgPicture.network(...)` widgets (card brand
/// and CVV icons). In `flutter_test` those network calls fail with status
/// 400 by default and throw `HttpException`, which fails tests even though
/// the failure is unrelated to the code under test.
///
/// Install via `HttpOverrides.runZoned` with `createHttpClient`:
/// ```dart
/// await HttpOverrides.runZoned<Future<void>>(
///   () async { /* test body */ },
///   createHttpClient: (_) => FakeHttpClient(),
/// );
/// ```
final Uint8List _fakeSvgBytes = Uint8List.fromList(
  utf8.encode('<svg xmlns="http://www.w3.org/2000/svg" width="1" height="1"/>'),
);

class FakeHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration? connectionTimeout;
  @override
  Duration idleTimeout = const Duration(seconds: 15);
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeHttpClientRequest();

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async =>
      _FakeHttpClientRequest();

  @override
  void close({bool force = false}) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpClientRequest implements HttpClientRequest {
  @override
  final HttpHeaders headers = _FakeHttpHeaders();

  @override
  Future<HttpClientResponse> close() async => _FakeHttpClientResponse();

  @override
  Future<HttpClientResponse> get done async => _FakeHttpClientResponse();

  @override
  Future<void> addStream(Stream<List<int>> stream) => stream.drain<void>();

  @override
  Future<void> flush() async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeHttpClientResponse extends Stream<List<int>>
    implements HttpClientResponse {
  @override
  int statusCode = 200;

  @override
  int get contentLength => _fakeSvgBytes.length;

  @override
  HttpClientResponseCompressionState get compressionState =>
      HttpClientResponseCompressionState.notCompressed;

  @override
  HttpHeaders get headers => _FakeHttpHeaders();

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_fakeSvgBytes]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
