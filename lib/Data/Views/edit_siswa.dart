// lib/Data/Views/edit_siswa.dart
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:belajar_flutter_r7/Data/Controllers/Siswa_controler.dart';

class EditSiswaPage extends StatefulWidget {
  final ModelsSiswa siswa;
  final Function(ModelsSiswa) onUpdate;

  const EditSiswaPage({super.key, required this.siswa, required this.onUpdate});

  @override
  State<EditSiswaPage> createState() => _EditSiswaPageState();
}

class _EditSiswaPageState extends State<EditSiswaPage> {
  final SiswaController _controller = SiswaController();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _nisnController;
  late TextEditingController _nisController;
  late TextEditingController _tempatLahirController;
  late DateTime _selectedDate;
  late TextEditingController _alamatController;
  late TextEditingController _noTeleponController;
  late TextEditingController _kelasController;
  late TextEditingController _tahunAjaranController;
  late TextEditingController _fotoController;
  late String _jenisKelamin;

  // Variabel untuk dropdown kelas
  String? _selectedKelasDropdown;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.siswa.nama);
    _nisnController = TextEditingController(text: widget.siswa.nisn);
    _nisController = TextEditingController(text: widget.siswa.nis);
    _tempatLahirController = TextEditingController(
      text: widget.siswa.tempatLahir,
    );
    _selectedDate = widget.siswa.tanggalLahir;
    _alamatController = TextEditingController(text: widget.siswa.alamat);
    _noTeleponController = TextEditingController(text: widget.siswa.noTelepon);
    _kelasController = TextEditingController(text: widget.siswa.kelas);
    _tahunAjaranController = TextEditingController(
      text: widget.siswa.tahunAjaran,
    );
    _fotoController = TextEditingController(text: widget.siswa.foto);
    _jenisKelamin = widget.siswa.jenisKelamin;

    // Set nilai dropdown dari data siswa
    _selectedKelasDropdown = widget.siswa.kelas;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nisnController.dispose();
    _nisController.dispose();
    _tempatLahirController.dispose();
    _alamatController.dispose();
    _noTeleponController.dispose();
    _kelasController.dispose();
    _tahunAjaranController.dispose();
    _fotoController.dispose();
    super.dispose();
  }

  // Method untuk mendapatkan daftar kelas yang tersedia
  List<String> _getAvailableKelas() {
    final existingKelas = _controller.siswa
        .map((s) => s.kelas)
        .toSet()
        .toList();
    existingKelas.sort();

    // Tambahkan kelas saat ini jika belum ada
    if (_kelasController.text.isNotEmpty &&
        !existingKelas.contains(_kelasController.text)) {
      existingKelas.add(_kelasController.text);
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
    // Validasi input
    if (_namaController.text.isEmpty) {
      _showErrorDialog('Nama harus diisi');
      return;
    }
    if (_nisnController.text.isEmpty) {
      _showErrorDialog('NISN harus diisi');
      return;
    }
    if (_nisController.text.isEmpty) {
      _showErrorDialog('NIS harus diisi');
      return;
    }

    // Gunakan nilai dari dropdown atau input manual
    final String kelasValue;
    if (_selectedKelasDropdown != null && _selectedKelasDropdown!.isNotEmpty) {
      kelasValue = _selectedKelasDropdown!;
    } else if (_kelasController.text.isNotEmpty) {
      kelasValue = _kelasController.text;
    } else {
      _showErrorDialog('Kelas harus diisi');
      return;
    }

    // Buat objek updated siswa
    final updatedSiswa = ModelsSiswa(
      id: widget.siswa.id,
      nama: _namaController.text.trim(),
      nisn: _nisnController.text.trim(),
      nis: _nisController.text.trim(),
      tempatLahir: _tempatLahirController.text.trim(),
      tanggalLahir: _selectedDate,
      jenisKelamin: _jenisKelamin,
      alamat: _alamatController.text.trim(),
      noTelepon: _noTeleponController.text.trim(),
      kelas: kelasValue,
      tahunAjaran: _tahunAjaranController.text.trim(),
      foto: _fotoController.text.trim(),
      createdAt: widget.siswa.createdAt,
      updatedAt: DateTime.now(),
    );

    // Panggil callback onUpdate
    widget.onUpdate(updatedSiswa);

    // Tampilkan feedback sukses
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil diperbarui'),
        backgroundColor: Colors.green,
      ),
    );

    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }

  void _cancel() {
    // Konfirmasi jika ada perubahan
    if (_hasChanges()) {
      _showCancelConfirmation();
    } else {
      Navigator.pop(context);
    }
  }

  bool _hasChanges() {
    return _namaController.text != widget.siswa.nama ||
        _nisnController.text != widget.siswa.nisn ||
        _nisController.text != widget.siswa.nis ||
        _tempatLahirController.text != widget.siswa.tempatLahir ||
        _selectedDate != widget.siswa.tanggalLahir ||
        _jenisKelamin != widget.siswa.jenisKelamin ||
        _alamatController.text != widget.siswa.alamat ||
        _noTeleponController.text != widget.siswa.noTelepon ||
        (_selectedKelasDropdown ?? _kelasController.text) !=
            widget.siswa.kelas ||
        _tahunAjaranController.text != widget.siswa.tahunAjaran ||
        _fotoController.text != widget.siswa.foto;
  }

  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Batalkan Perubahan'),
          content: const Text(
            'Ada perubahan yang belum disimpan. Yakin ingin keluar?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Lanjut Edit'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Batalkan'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Siswa')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // FORM CONTENT
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
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nisnController,
                      decoration: const InputDecoration(
                        labelText: 'NISN *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nisController,
                      decoration: const InputDecoration(
                        labelText: 'NIS *',
                        border: OutlineInputBorder(),
                      ),
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
                              'Jenis Kelamin:',
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
                      value: _selectedKelasDropdown,
                      decoration: const InputDecoration(
                        labelText: 'Pilih Kelas *',
                        border: OutlineInputBorder(),
                        helperText: 'Pilih dari daftar kelas yang sudah ada',
                      ),
                      items: [
                        const DropdownMenuItem(
                          value: null,
                          child: Text('Pilih Kelas...'),
                        ),
                        ..._getAvailableKelas().map((kelas) {
                          return DropdownMenuItem(
                            value: kelas,
                            child: Text(kelas),
                          );
                        }).toList(),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedKelasDropdown = value;
                          // Juga update text controller untuk konsistensi
                          if (value != null) {
                            _kelasController.text = value;
                          }
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
                      controller: _kelasController,
                      decoration: const InputDecoration(
                        labelText: 'Kelas Baru (opsional)',
                        border: OutlineInputBorder(),
                        helperText:
                            'Kosongkan jika sudah memilih dari dropdown di atas',
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            _selectedKelasDropdown = null;
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
                      ),
                    ),

                    // Informasi Sistem
                    Card(
                      margin: const EdgeInsets.only(top: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Sistem:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Dibuat: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.siswa.createdAt)}',
                            ),
                            Text(
                              'Terakhir Update: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.siswa.updatedAt)}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // BOTTOM BUTTONS
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
