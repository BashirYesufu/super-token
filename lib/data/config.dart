enum Environment { DEV, STAGING, PROD }

class BaseUrl {
  static Map<String, dynamic>?  _config;
  static Environment? _env;

  static void setEnvironment(Environment env) {
    _env = env;
    switch (env) {
      case Environment.DEV:
        _config = _BaseUrlConfig.devConstants;
        break;
      case Environment.STAGING:
        _config = _BaseUrlConfig.stagingConstants;
        break;
      case Environment.PROD:
        _config = _BaseUrlConfig.prodConstants;
        break;
    }
  }

  static Environment? getEnvironment() {
    return _env;
  }

  static get BASE_URL {
    return _config?[_BaseUrlConfig.BASE_URL];
  }
}

class _BaseUrlConfig{
  static const BASE_URL = 'BaseUrl';

  static Map<String, dynamic> devConstants = {
    BASE_URL: "https://localhost:3001",
  };

  static Map<String, dynamic> stagingConstants = {
    BASE_URL: "https://localhost:3001",
  };

  static Map<String, dynamic> prodConstants = {
    BASE_URL: "https://localhost:3001",
  };
}