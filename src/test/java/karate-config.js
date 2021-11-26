function fn() {
  var env = karate.env; // get java system property 'karate.env'
  if (!env) {
      env = 'dev'; // a custom 'intelligent' default
  }
  karate.log('karate.env system property was:', env);

  var config = { // base config JSON
    baseUrl: 'http://127.0.0.1:18080',
  };

  // don't waste time waiting for a connection or if servers don't respond within 60 seconds
  karate.configure('connectTimeout', 60000);
  karate.configure('readTimeout', 60000);
  return config;
}