import 'package:flutter_technical_test/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('IsConnected', () {
    test("should forward the call to DataConncetionChecker.hasConnection",
        () async {
      // arrange
      final tHasConncetionFuture = Future.value(true);
      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConncetionFuture);
      // act
      final result = networkInfo.isConnected;
      // assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, tHasConncetionFuture);
    });
  });
}
