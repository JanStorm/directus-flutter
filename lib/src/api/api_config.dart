class DirectusApiConfig {
  final String host, project, email, password;
  final bool useHttps;

  const DirectusApiConfig(this.host, this.project, this.email, this.password, [this.useHttps = true]);

  Map getAuthCredentials() => {'email': email, 'password': password};
}
