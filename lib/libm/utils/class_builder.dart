import '../screens/Website.dart';
import '../screens/Home_Page.dart';
import '../screens/Downloads.dart';
import '../screens/Feedback.dart';
import '../screens/Credits.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomePage>(() => HomePage());
    register<PreArticleWebsite>(() => PreArticleWebsite());
    register<Downloads>(() => Downloads());
    register<Feedback>(() => Feedback());
    register<Credits>(() => Credits());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}
