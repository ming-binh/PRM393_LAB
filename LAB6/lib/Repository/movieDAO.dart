import '../Entities/movie.dart';

class MovieRepository {
  static const List<Movie> allMovies = [
    Movie(
      title: 'Inception',
      year: 2010,
      genres: ['Action', 'Sci-Fi'],
      posterUrl: 'assets/images/inception.jpg',
      rating: 8.8,
    ),
    Movie(
      title: 'The Dark Knight',
      year: 2008,
      genres: ['Action', 'Drama'],
      posterUrl: 'assets/images/darkknight.jpg',
      rating: 9.0,
    ),
    Movie(
      title: 'Interstellar',
      year: 2014,
      genres: ['Sci-Fi', 'Drama'],
      posterUrl: 'assets/images/interstella.jpg',
      rating: 8.6,
    ),
    Movie(
      title: 'The Hangover',
      year: 2009,
      genres: ['Comedy'],
      posterUrl: 'assets/images/hangover.jpg',
      rating: 7.7,
    ),
    Movie(
      title: 'Avengers: Endgame',
      year: 2019,
      genres: ['Action', 'Sci-Fi'],
      posterUrl: 'assets/images/endgame.jpg',
      rating: 8.4,
    ),
    Movie(
      title: 'Forrest Gump',
      year: 1994,
      genres: ['Drama', 'Romance'],
      posterUrl: 'assets/images/forrestgump.jpg',
      rating: 8.8,
    ),
    Movie(
      title: 'The Mask',
      year: 1994,
      genres: ['Comedy', 'Action'],
      posterUrl: 'assets/images/mask.jpg',
      rating: 6.9,
    ),
    Movie(
      title: 'Titanic',
      year: 1997,
      genres: ['Romance', 'Drama'],
      posterUrl: 'assets/images/titanic.jpg',
      rating: 7.9,
    ),
  ];

  static const List<String> allGenres = [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Romance',
  ];
}
