// import 'package:mocktail/mocktail.dart';
// import 'package:posts_task/layers/data/app_repository_impl.dart';
// import 'package:posts_task/layers/data/source/local/local_storage.dart';
// import 'package:posts_task/layers/data/source/remote/app_api.dart';
// import 'package:posts_task/layers/data/source/remote/network_info.dart';
//  import 'package:posts_task/layers/domain/models/posts_model.dart';
// import 'package:test/test.dart';
//
// import '../../fixtures/fixtures.dart';
//
// class MockApi extends Mock implements AppServiceClient {}
//

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:posts_task/layers/data/app_repository_impl.dart';
import 'package:test/test.dart';
import 'package:posts_task/layers/data/dto/recipe_model.dart';
import 'package:posts_task/layers/data/source/local/local_storage.dart';
import 'package:posts_task/layers/data/source/remote/app_api.dart';
import 'package:posts_task/layers/data/source/remote/failure/error_handler.dart';
import 'package:posts_task/layers/data/source/remote/failure/failure.dart';
import 'package:posts_task/layers/data/source/remote/network_info.dart';
import 'package:posts_task/layers/domain/models/posts_model.dart';
import 'package:posts_task/layers/domain/repository/app_repository.dart';

class MockAppServiceClient extends Mock implements AppServiceClient {
}

class MockNetworkInfo extends Mock implements NetworkInfo {}
List<RecipeModel> mockRecipes = [
  RecipeModel(
      id: "533143aaff604d567f8b4571",
      fats: "8 g",
      name: "Crispy Fish Goujons ",
      time: "PT35M",
      image: "https://img.hellofresh.com/w_1080,f_webp,q_auto/hellofresh_s3/image/zartes-kokos-fischfilet-76aba609.jpg",
      weeks: [
      "2014-W20"
      ],
      carbos: "47 g",
      fibers: "",
      country: "GB",
      headline: "with Sweet Potato Wedges and Minted Snap Peas",
      products: [
      "family-box"
      ],
      proteins: "43 g",
      favorites: 1,
      difficulty: 0,
      description: "There’s nothing like the simple things in life - the smell of freshly cut grass, sitting outside on a nice sunny day, spending time with friends and family. Well here is a recipe that delivers simple culinary pleasures - some nice fresh fish with a crispy crust, crunchy potato wedges and some delightfully sweet sugar snap peas flavoured with cooling mint. Slip into something comfortable and relax into a delicious dinner!",
      highlighted: true,
      ingredients: [
      "375g Sweet Potatoes",
      "1 Tsp Paprika",
      "2 Tbsps Parmesan Cheese",
      "1 Lemon",
      "A Few Sprigs Thyme",
      "25g Panko Breadcrumbs",
      "1 Tbsp Butter",
      "2 Cod Fillets",
      "150g Sugar Snap Peas",
      "A Few Sprigs Mint",
      "75ml Sour Cream"
      ],

  )
];


void main() {
  late AppRepositoryImpl repository;
  late MockAppServiceClient mockApi;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockApi = MockAppServiceClient();
    mockNetworkInfo = MockNetworkInfo();
    repository = AppRepositoryImpl(api: mockApi, networkInfo: mockNetworkInfo);
  });

  group('getRecipesData', () {
    test('should return Right(response) when connected to internet and API call is successful', () async {
      // Arrange
      when(() => mockApi.getRecipesApiCall()).thenAnswer((_) async => mockRecipes);

      // Act
      final result = await repository.getRecipesData();

      // Assert
      expect(result, Right(mockRecipes));
      verify(() => mockApi.getRecipesApiCall()).called(1);
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockApi);
    });

    test('should return Left(Failure) when connected to internet but API call fails', () async {
      // Arrange
      when(() =>mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() =>mockApi.getRecipesApiCall()).thenThrow(Exception());

      // Act
      final result = await repository.getRecipesData();

      // Assert
      expect(result, isA<Left<Failure, List<RecipeModel>>>());
      verify(() =>mockNetworkInfo.isConnected);
      verify(() =>mockApi.getRecipesApiCall());
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockApi);
    });

    test('should return Left(DataSource.NO_INTERNET_CONNECTION.getFailure()) when not connected to internet', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      verify(() => mockNetworkInfo.isConnected);
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyZeroInteractions(mockApi);
    });
  });
}
