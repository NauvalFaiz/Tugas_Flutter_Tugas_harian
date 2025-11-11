// lib/Data/Views/widgets/siswa_search_filter.dart
import 'package:flutter/material.dart';

class SiswaSearchFilter extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final String selectedKelas;
  final List<String> availableKelas;
  final Function(String) onSearchChanged;
  final Function(String?) onKelasChanged;
  final VoidCallback onResetFilter;

  const SiswaSearchFilter({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.selectedKelas,
    required this.availableKelas,
    required this.onSearchChanged,
    required this.onKelasChanged,
    required this.onResetFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),    
                      onPressed: onResetFilter,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 12),

          // Kelas Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: DropdownButtonFormField<String>(
              value: selectedKelas,
              decoration: InputDecoration(
                labelText: 'Filter Kelas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              isExpanded: true,
              items: [
                const DropdownMenuItem(
                  value: 'Semua',
                  child: Text('Semua Kelas'),
                ),
                ...availableKelas.where((kelas) => kelas != 'Semua').map((
                  kelas,
                ) {
                  return DropdownMenuItem(value: kelas, child: Text(kelas));
                }).toList(),
              ],
              onChanged: onKelasChanged,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
