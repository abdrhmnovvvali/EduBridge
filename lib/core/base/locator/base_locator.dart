class BaseLocator {
  // Private constructor
  BaseLocator._();

  // Singleton instance
  static final BaseLocator _instance = BaseLocator._();

  // Factory method to get the singleton instance
  static BaseLocator get instance => _instance;

  // Maps to store the registered services
  final Map<Type, dynamic> _singletonInstances = {};
  final Map<Type, Function> _factories = {};
  final Map<Type, Function> _paramFactories = {};

  // Register a singleton with eager initialization (non-lazy)
  void registerSingleton<T>(T instance) {
    _singletonInstances[T] = instance;
  }

  // Register a singleton with lazy initialization
  void registerLazySingleton<T>(T Function() factory) {
    _factories[T] = () {
      if (!_singletonInstances.containsKey(T)) {
        _singletonInstances[T] = factory();
      }
      return _singletonInstances[T];
    };
  }

  // Register a factory
  void registerFactory<T>(T Function() factory) {
    _factories[T] = factory;
  }

  // Register a factory with parameters (up to 2 params)
  void registerFactoryParam<T, P1, P2>(
    T Function(P1, P2) factory,
  ) {
    _paramFactories[T] = factory;
  }

  // Overloaded call operator to retrieve an instance (no params or with param1/param2)
  T call<T>({dynamic param1, dynamic param2}) {
    if (_singletonInstances.containsKey(T)) {
      return _singletonInstances[T] as T;
    } else if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    } else if (_paramFactories.containsKey(T)) {
      return Function.apply(_paramFactories[T]!, [param1, param2]) as T;
    } else {
      throw Exception('Service of type $T is not registered');
    }
  }

  // Retrieve an instance explicitly (without params)
  T get<T>() {
    if (_singletonInstances.containsKey(T)) {
      return _singletonInstances[T] as T;
    } else if (_factories.containsKey(T)) {
      return _factories[T]!() as T;
    } else {
      throw Exception('Service of type $T is not registered');
    }
  }

  // Clear all registered services
  void reset() {
    _singletonInstances.clear();
    _factories.clear();
    _paramFactories.clear();
  }
}
