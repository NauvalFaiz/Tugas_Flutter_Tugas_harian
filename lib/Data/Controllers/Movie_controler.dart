import '../Models/models_movie.dart';

class MovieController {
  List<MovieModel> movie = [
    MovieModel(
      id: 1,
      title: "Movie 1",
      posterPath:
          "https://i.pinimg.com/736x/df/98/61/df9861e29f0133bf5e3988fd2ee8cd70.jpg",
      voteAverage: 8.5,
      overview: 'Film ini dengan misteri Gunung Kidul Yang sangat angker dan.....',
    ),
    MovieModel(
      id: 2,
      title: "Movie 2",
      posterPath:
          "https://i.pinimg.com/736x/df/98/61/df9861e29f0133bf5e3988fd2ee8cd70.jpg",
      voteAverage: 9.0,
      overview: 'halo',
    ),
  ];
}
