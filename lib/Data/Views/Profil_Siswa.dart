// lib/views/siswa_profile_page.dart
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:belajar_flutter_r7/Data/Views/edit_siswa.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';
import 'package:intl/intl.dart'; // ✅ Tambahkan import untuk DateFormat

class SiswaProfilePage extends StatefulWidget {
  final ModelsSiswa siswa;

  const SiswaProfilePage({super.key, required this.siswa});

  @override
  State<SiswaProfilePage> createState() => _SiswaProfilePageState();
}

class _SiswaProfilePageState extends State<SiswaProfilePage> {
  final SiswaController _controller = SiswaController();
  late ModelsSiswa _currentSiswa;

  @override
  void initState() {
    super.initState();
    _currentSiswa = widget.siswa;
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Yakin ingin menghapus data siswa ${_currentSiswa.nama}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                _controller.deleteSiswa(_currentSiswa);
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _handleUpdate(ModelsSiswa updatedSiswa) {
    // ✅ UPDATE DATA DI CONTROLLER
    final success = _controller.updateSiswa(updatedSiswa);

    if (success) {
      // ✅ UPDATE STATE UNTUK REFRESH UI
      setState(() {
        _currentSiswa = updatedSiswa;
      });

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
  }

  // ✅ METHOD: Build Info Chip
  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ✅ METHOD: Build Info Section
  Widget _buildInfoSection(String title, List<Widget> children) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  // ✅ METHOD: Build Info Row
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Siswa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditSiswaPage(
                    siswa: _currentSiswa,
                    onUpdate: _handleUpdate,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(_currentSiswa.foto),
                            backgroundColor: Colors.grey[200],
                            onBackgroundImageError: (exception, stackTrace) {
                              // Handle error loading image
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: _currentSiswa.jenisKelamin == 'L'
                                    ? Colors.blue
                                    : Colors.pink,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _currentSiswa.jenisKelamin == 'L'
                                    ? Icons.male
                                    : Icons.female,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _currentSiswa.nama,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentSiswa.kelas,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoChip(
                            'NISN: ${_currentSiswa.nisn}',
                            Colors.blue,
                          ),
                          const SizedBox(width: 8),
                          _buildInfoChip(
                            'NIS: ${_currentSiswa.nis}',
                            Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Personal Information
              _buildInfoSection('Informasi Pribadi', [
                _buildInfoRow('Tempat Lahir', _currentSiswa.tempatLahir),
                _buildInfoRow(
                  'Tanggal Lahir',
                  '${_currentSiswa.tanggalLahir.day}/${_currentSiswa.tanggalLahir.month}/${_currentSiswa.tanggalLahir.year}',
                ),
                _buildInfoRow(
                  'Jenis Kelamin',
                  _currentSiswa.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan',
                ),
              ]),

              // Contact Information
              _buildInfoSection('Informasi Kontak', [
                _buildInfoRow('Alamat', _currentSiswa.alamat),
                _buildInfoRow('No. Telepon', _currentSiswa.noTelepon),
              ]),

              // Academic Information
              _buildInfoSection('Informasi Akademik', [
                _buildInfoRow('Kelas', _currentSiswa.kelas),
                _buildInfoRow('Tahun Ajaran', _currentSiswa.tahunAjaran),
              ]),

              // System Information
              _buildInfoSection('Informasi Sistem', [
                _buildInfoRow(
                  'Dibuat Pada',
                  DateFormat(
                    'dd/MM/yyyy HH:mm',
                  ).format(_currentSiswa.createdAt),
                ),
                _buildInfoRow(
                  'Diupdate Pada',
                  DateFormat(
                    'dd/MM/yyyy HH:mm',
                  ).format(_currentSiswa.updatedAt),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
