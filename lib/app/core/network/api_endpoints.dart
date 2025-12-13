class ApiEndpoints {
  static const String _baseUrl = "https://api.github.com";
  static const String fetchRepositoryUrl =
      "$_baseUrl/search/repositories?q=Flutter&sort=stars&order=desc&per_page=50";
}
