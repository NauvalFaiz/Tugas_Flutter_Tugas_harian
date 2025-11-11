import 'package:flutter/material.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'siswa_card.dart';

class SiswaList extends StatelessWidget {
  final List<ModelsSiswa> filteredSiswa;
  final SiswaController? controller;
  final void Function(ModelsSiswa) onEdit;
  final void Function(ModelsSiswa) onDelete;

  const SiswaList({
    super.key,
    required this.filteredSiswa,
    this.controller,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (filteredSiswa.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Tidak ada siswa ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'Tekan tombol + untuk menambah siswa baru',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: filteredSiswa.length,
      itemBuilder: (context, index) {
        final siswa = filteredSiswa[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SiswaCard(
            siswa: siswa,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}
