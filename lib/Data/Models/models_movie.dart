class MovieModel {
  int id;
  String title;
  double? voteAverage;
  String posterPath;
  String overview;
  MovieModel({
    required this.id,
    required this.title,
    this.voteAverage,
    required this.posterPath,
    required this.overview,
  });
}
