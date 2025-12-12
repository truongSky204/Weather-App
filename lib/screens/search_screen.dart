import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  bool _isSearching = false;
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search city'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'City name',
                errorText: _errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSearching ? null : _search,
              child: _isSearching
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (provider.currentWeather != null)
              Text(
                'Current city: ${provider.currentWeather!.cityName}',
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _search() async {
    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() => _errorText = 'Please enter a city name');
      return;
    }

    setState(() {
      _errorText = null;
      _isSearching = true;
    });

    try {
      await context.read<WeatherProvider>().fetchWeatherByCity(city);
      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      setState(() => _errorText = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }
}
