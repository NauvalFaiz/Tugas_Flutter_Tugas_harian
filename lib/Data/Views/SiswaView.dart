import 'package:belajar_flutter_r7/Data/Controllers/delate_siswa.dart';
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';
import 'package:belajar_flutter_r7/Data/Views/TambahSiswaPage.dart';
import 'package:belajar_flutter_r7/Data/Views/edit_siswa.dart';
import 'widgets/siswa_search_filter.dart';
import 'widgets/siswa_statistics.dart';
import 'widgets/siswa_list.dart';

class SiswaView extends StatefulWidget {
  const SiswaView({super.key});

  @override
  State<SiswaView> createState() => _SiswaViewState();
}

class _SiswaViewState extends State<SiswaView> {
  final SiswaController _controller = SiswaController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedKelas = 'Semua';
  

  List<ModelsSiswa> get _filteredSiswa {
    var filtered = _controller.siswa;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered
          .where(
            (siswa) =>
                siswa.nama.toLowerCase().contains(query) ||
                siswa.nisn.toLowerCase().contains(query) ||
                siswa.kelas.toLowerCase().contains(query) ||
                siswa.tempatLahir.toLowerCase().contains(query),
          )
          .toList();
    }

    if (_selectedKelas != 'Semua') {
      filtered = filtered
          .where((siswa) => siswa.kelas == _selectedKelas)
          .toList();
    }

    return filtered;
  }

  List<String> get _availableKelas {
    final kelas = _controller.siswa.map((s) => s.kelas).toSet().toList();
    kelas.sort();
    return ['Semua'] + kelas;
  }

  // ✅ Hapus siswa dengan snackbar + undo
  void _deleteSiswa(ModelsSiswa siswa) {
    final success = _controller.deleteSiswa(siswa);

    if (success) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${siswa.nama} berhasil dihapus'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () {
              _controller.restoreSiswa(siswa.id);
              setState(() {});
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghapus data siswa'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // ✅ Dialog konfirmasi hapus
  void _showDeleteConfirmation(BuildContext context, ModelsSiswa siswa) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Siswa'),
          content: Text('Yakin ingin menghapus data ${siswa.nama}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteSiswa(siswa);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // ✅ Edit siswa
  void _editSiswa(ModelsSiswa siswa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSiswaPage(
          siswa: siswa,
          onUpdate: (updatedSiswa) {
            final success = _controller.updateSiswa(updatedSiswa);
            if (success) {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data berhasil diperbarui'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Gagal memperbarui data'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  // ✅ Tambah siswa
  void _tambahSiswa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TambahSiswaPage(
          onAdd: (newSiswa) {
            _controller.addSiswa(newSiswa);
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${newSiswa.nama} berhasil ditambahkan'),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stats = _controller.getStatistics();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Siswa'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Tombol tambah siswa
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _tambahSiswa,
            tooltip: 'Tambah Siswa Baru',
          ),

          // Tombol daftar siswa yang dihapus (jika ada)
          if (_controller.deletedSiswa.isNotEmpty)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DeletedSiswaPage(),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  tooltip: 'Siswa yang dihapus',
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _controller.deletedSiswa.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          // Statistik siswa
          SiswaStatistics(stats: stats),

          // Search dan Filter
          SiswaSearchFilter(
            searchController: _searchController,
            searchQuery: _searchQuery,
            selectedKelas: _selectedKelas,
            availableKelas: _availableKelas,
            onSearchChanged: (value) => setState(() => _searchQuery = value),
            onKelasChanged: (value) =>
                setState(() => _selectedKelas = value ?? 'Semua'),
            onResetFilter: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
                _selectedKelas = 'Semua';
              });
            },
          ),

          // Jumlah hasil pencarian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredSiswa.length} siswa ditemukan',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_searchQuery.isNotEmpty || _selectedKelas != 'Semua')
                  TextButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _searchQuery = '';
                        _selectedKelas = 'Semua';
                      });
                    },
                    child: const Text('Reset Filter'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Daftar siswa
          Expanded(
            child: SiswaList(
              filteredSiswa: _filteredSiswa,
              controller: _controller,
              onEdit: _editSiswa,
              onDelete: (siswa) => _showDeleteConfirmation(context, siswa),
            ),
          ),
        ],
      ),
    );
  }
}
