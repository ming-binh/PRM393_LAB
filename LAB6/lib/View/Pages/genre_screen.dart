import 'package:flutter/material.dart';
import '../../Entities/movie.dart';
import '../../Repository/movieDAO.dart';
import '../Widgets/movie_card.dart';
import '../Widgets/genre_chip.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A-Z';

  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> get _visibleMovies {
    List<Movie> result = MovieRepository.allMovies.where((movie) {
      final matchSearch =
          _searchQuery.isEmpty ||
          movie.title.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchGenre =
          _selectedGenres.isEmpty ||
          movie.genres.any((g) => _selectedGenres.contains(g));

      return matchSearch && matchGenre;
    }).toList();

    switch (_selectedSort) {
      case 'A-Z':
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        result.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        result.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return result;
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedGenres.clear();
      _searchQuery = '';
      _searchController.clear();
      _selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = _visibleMovies;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildHeading(),
              const SizedBox(height: 14),

              _buildSearchBar(),
              const SizedBox(height: 12),
              _buildGenreChips(),
              const SizedBox(height: 10),
              _buildSortBar(movies.length),
              const SizedBox(height: 10),

              Expanded(child: _buildMovieList(movies)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;
        return Row(
          children: [
            const Icon(Icons.movie_filter, color: Colors.indigo, size: 32),
            const SizedBox(width: 10),
            Text(
              'Find a Movie',
              style: TextStyle(
                fontSize: isWide ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: const InputDecoration(
          hintText: 'Search movies...',
          prefixIcon: Icon(Icons.search, color: Colors.indigo),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  Widget _buildGenreChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Genres',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            if (_selectedGenres.isNotEmpty) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${_selectedGenres.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MovieRepository.allGenres
              .map(
                (genre) => GenreChip(
                  label: genre,
                  selected: _selectedGenres.contains(genre),
                  onTap: () => _toggleGenre(genre),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSortBar(int count) {
    return Row(
      children: [
        Text(
          '$count movie${count != 1 ? 's' : ''} found',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
        const Spacer(),
        if (_selectedGenres.isNotEmpty || _searchQuery.isNotEmpty)
          TextButton.icon(
            onPressed: _clearFilters,
            icon: const Icon(Icons.clear, size: 16),
            label: const Text('Clear'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red[400],
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        const SizedBox(width: 8),
        const Text('Sort:', style: TextStyle(fontSize: 13)),
        const SizedBox(width: 6),
        DropdownButton<String>(
          value: _selectedSort,
          underline: const SizedBox(),
          isDense: true,
          style: const TextStyle(color: Colors.indigo, fontSize: 13),
          items: _sortOptions
              .map(
                (opt) => DropdownMenuItem(
                  value: opt,
                  child: Text(opt),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => _selectedSort = value);
          },
        ),
      ],
    );
  }

  Widget _buildMovieList(List<Movie> movies) {
    if (movies.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.grey),
            SizedBox(height: 12),
            Text('No movies found', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 800;

        if (isWide) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 2.8,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: movies.map((m) => MovieCard(movie: m)).toList(),
          );
        } else {
          return ListView.separated(
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) => MovieCard(movie: movies[index]),
          );
        }
      },
    );
  }
}
