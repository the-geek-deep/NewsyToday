# newsytoday

A light-weight application built with flutter's bloc architecture to make it interactive.

It provides you with current hot news using news-api and also stores news in the offline storage so that you can view it later. 

Tech-Stack:
  1. Flutter-dart.
  2. Firebase for authentication.
  3. Hive for Local Storage.
  4. FLutter_Bloc package for implementing bloc-architecture.
  5. news-api for fetching current hot news.

 lib
  - data
    - models
      - article_model.dart /
    - repositories
      - news_repository.dart /
  - presentation
    - screens
      - home_screen.dart
      - login_screen.dart
      - offline_screen.dart
    - widgets
      - article_list.dart
  - bloc
    - authentication
      - authentication_bloc.dart
      - authentication_event.dart
      - authentication_state.dart
    - news
      - news_bloc.dart
      - news_event.dart
      - news_state.dart
  - services
    - news_api_service.dart /
  - utils
    - hive_helper.dart /
  - main.dart

