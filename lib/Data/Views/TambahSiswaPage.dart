// lib/Data/Views/tambah_siswa_page.dart
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';

class TambahSiswaPage extends StatefulWidget {
  final Function(ModelsSiswa) onAdd;

  const TambahSiswaPage({super.key, required this.onAdd});

  @override
  State<TambahSiswaPage> createState() => _TambahSiswaPageState();
}

class _TambahSiswaPageState extends State<TambahSiswaPage> {
  final SiswaController _controller = SiswaController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nisnController = TextEditingController();
  final TextEditingController _nisController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _tahunAjaranController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _jenisKelamin = 'L';
  String? _selectedKelas;

  // Daftar kelas yang sudah ada + opsi tambah baru
  List<String> get _availableKelas {
    final existingKelas = _controller.siswa
        .map((s) => s.kelas)
        .toSet()
        .toList();
    existingKelas.sort();

    // Jika kelas yang dipilih tidak ada di list, tambahkan
    if (_selectedKelas != null &&
        !existingKelas.contains(_selectedKelas) &&
        _selectedKelas!.isNotEmpty) {
      existingKelas.add(_selectedKelas!);
      existingKelas.sort();
    }

    return existingKelas;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime firstDate = DateTime(2000);
    final DateTime lastDate = DateTime(today.year + 5); // 5 tahun dari sekarang

    // Validasi initial date
    DateTime initialDate = _selectedDate;
    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    } else if (initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      if (_selectedKelas == null || _selectedKelas!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pilih atau masukkan kelas'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Cek duplikat NISN
      if (_controller.isNisnDuplicate(_nisnController.text, excludeId: 1)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('NISN sudah terdaftar'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Cek duplikat NIS
      if (_controller.isNisDuplicate(_nisController.text, excludeId: 2)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('NIS sudah terdaftar'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final newSiswa = ModelsSiswa(
        id: _controller.nextId,
        nama: _namaController.text.trim(),
        nisn: _nisnController.text.trim(),
        nis: _nisController.text.trim(),
        tempatLahir: _tempatLahirController.text.trim(),
        tanggalLahir: _selectedDate,
        jenisKelamin: _jenisKelamin,
        alamat: _alamatController.text.trim(),
        noTelepon: _noTeleponController.text.trim(),
        kelas: _selectedKelas!,
        tahunAjaran: _tahunAjaranController.text.trim().isEmpty
            ? '2024/2025'
            : _tahunAjaranController.text.trim(),
        foto: _fotoController.text.trim().isEmpty
            ? 'https://via.placeholder.com/150'
            : _fotoController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      widget.onAdd(newSiswa);
      Navigator.pop(context);
    }
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nisnController.dispose();
    _nisController.dispose();
    _tempatLahirController.dispose();
    _alamatController.dispose();
    _noTeleponController.dispose();
    _tahunAjaranController.dispose();
    _fotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Siswa Baru')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _namaController,
                      decoration: const InputDecoration(
                        labelText: 'Nama *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nisnController,
                      decoration: const InputDecoration(
                        labelText: 'NISN *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NISN harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nisController,
                      decoration: const InputDecoration(
                        labelText: 'NIS *',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'NIS harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tempatLahirController,
                      decoration: const InputDecoration(
                        labelText: 'Tempat Lahir',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      title: Text(
                        'Tanggal Lahir: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jenis Kelamin: *',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Laki-laki'),
                                    leading: Radio<String>(
                                      value: 'L',
                                      groupValue: _jenisKelamin,
                                      onChanged: (value) {
                                        setState(() {
                                          _jenisKelamin = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Perempuan'),
                                    leading: Radio<String>(
                                      value: 'P',
                                      groupValue: _jenisKelamin,
                                      onChanged: (value) {
                                        setState(() {
                                          _jenisKelamin = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ✅ DROPDOWN KELAS YANG SUDAH ADA
                    DropdownButtonFormField<String>(
                      value: _selectedKelas,
                      decoration: const InputDecoration(
                        labelText: 'Kelas *',
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Pilih kelas atau ketik baru'),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Pilih kelas...'),
                        ),
                        ..._availableKelas.map((kelas) {
                          return DropdownMenuItem(
                            value: kelas,
                            child: Text(kelas),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedKelas = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih kelas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ✅ INPUT KELAS BARU (OPSIONAL)
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Kelas Baru (opsional)',
                        border: OutlineInputBorder(),
                        hintText: 'Kosongkan jika sudah memilih di atas',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _selectedKelas = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _tahunAjaranController,
                      decoration: const InputDecoration(
                        labelText: 'Tahun Ajaran',
                        border: OutlineInputBorder(),
                        hintText: 'Contoh: 2024/2025',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _alamatController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _noTeleponController,
                      decoration: const InputDecoration(
                        labelText: 'No. Telepon',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _fotoController,
                      decoration: const InputDecoration(
                        labelText: 'URL Foto',
                        border: OutlineInputBorder(),
                        hintText: 'Kosongkan untuk menggunakan foto default',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _cancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey.shade400),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
