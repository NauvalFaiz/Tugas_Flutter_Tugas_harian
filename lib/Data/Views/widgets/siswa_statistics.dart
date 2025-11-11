// lib/Data/Views/widgets/siswa_statistics.dart
import 'package:flutter/material.dart';

class SiswaStatistics extends StatelessWidget {
  final Map<String, int> stats;

  const SiswaStatistics({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade50,
      child: Row(
        children: [
          _buildStatCard('Total', stats['total']!, Colors.blue),
          const SizedBox(width: 12),
          _buildStatCard('Laki-laki', stats['lakiLaki']!, Colors.green),
          const SizedBox(width: 12),
          _buildStatCard('Perempuan', stats['perempuan']!, Colors.pink),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          // ignore: deprecated_member_use
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              count.toString(),
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}