class DirectusApiConfig {
  final String host, project, email, password;

  const DirectusApiConfig(this.host, this.project, this.email, this.password);

  Map getAuthCredentials() => {
    'email': email,
    'password': password
  };
}