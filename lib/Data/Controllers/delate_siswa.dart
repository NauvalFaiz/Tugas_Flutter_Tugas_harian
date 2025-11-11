// lib/Data/Views/deleted_siswa_page.dart
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';


class DeletedSiswaPage extends StatefulWidget {
  const DeletedSiswaPage({super.key});

  @override
  State<DeletedSiswaPage> createState() => _DeletedSiswaPageState();
}

class _DeletedSiswaPageState extends State<DeletedSiswaPage> {
  final SiswaController _controller = SiswaController();

  void _refresh() => setState(() {});

  Future<void> _confirmRestore(BuildContext context, ModelsSiswa siswa) async {
    final originalIndex = _controller.getOriginalIndex(siswa.id);
    
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kembalikan Siswa'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yakin ingin mengembalikan data ${siswa.nama}?'),
              if (originalIndex != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Akan dikembalikan ke posisi index: $originalIndex',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: const Text('Kembalikan'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final success = _controller.restoreSiswa(siswa.id);
      
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              originalIndex != null 
                ? '${siswa.nama} berhasil dikembalikan ke index $originalIndex'
                : '${siswa.nama} berhasil dikembalikan'
            ),
            backgroundColor: Colors.green,
          ),
        );
        _refresh();
      }
    }
  }

  Future<void> _confirmPermanentDelete(BuildContext context, ModelsSiswa siswa) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Permanen'),
          content: Text('Yakin ingin menghapus permanen data ${siswa.nama}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus Permanen'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final success = _controller.permanentlyDeleteSiswa(siswa.id);
      if (success) _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deletedList = _controller.deletedSiswaList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siswa yang Dihapus'),
        backgroundColor: Colors.red[50],
      ),
      body: deletedList.isEmpty
          ? const Center(child: Text('Tidak ada data yang dihapus.'))
          : ListView.builder(
              itemCount: deletedList.length,
              itemBuilder: (context, index) {
                final siswa = deletedList[index];
                final originalIndex = _controller.getOriginalIndex(siswa.id);
                
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(siswa.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NISN: ${siswa.nisn} | Kelas: ${siswa.kelas}'),
                        if (originalIndex != null)
                          Text(
                            'Index asli: $originalIndex',
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.restore, color: Colors.green),
                          onPressed: () => _confirmRestore(context, siswa),
                          tooltip: 'Kembalikan',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_forever, color: Colors.red),
                          onPressed: () => _confirmPermanentDelete(context, siswa),
                          tooltip: 'Hapus Permanen',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}