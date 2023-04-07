import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_finder_clean/core/network/network_info.dart';

import 'network_info_test.mocks.dart';


@GenerateNiceMocks([MockSpec<InternetConnectionChecker>()])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group("isConnected",
    () {
      test("should forward the call to InternetConnectionChecker.hasConnection",
        () async {
          final tHasConnection = Future.value(true);

          when(mockInternetConnectionChecker.hasConnection)
            .thenAnswer((_)  => tHasConnection);

          final result = networkInfo.isConnected;

          verify(mockInternetConnectionChecker.hasConnection);

          expect(result, tHasConnection);
        }
      );
    }
  );

}