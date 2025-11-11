import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:flutter/material.dart';

class SiswaDetailModal {
  static void show(BuildContext context, ModelsSiswa siswa) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan icon
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.blue.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        siswa.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  siswa.kelas,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(color: Colors.grey.shade300),
                const SizedBox(height: 8),

                // Informasi detail
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.badge, 'NISN', siswa.nisn),
                        _buildInfoRow(Icons.school, 'NIS', siswa.nis),
                        _buildInfoRow(
                          Icons.place,
                          'Tempat Lahir',
                          siswa.tempatLahir,
                        ),
                        _buildInfoRow(
                          Icons.cake,
                          'Tanggal Lahir',
                          '${siswa.tanggalLahir.day}/${siswa.tanggalLahir.month}/${siswa.tanggalLahir.year}',
                        ),
                        _buildInfoRow(
                          siswa.jenisKelamin == 'L' ? Icons.male : Icons.female,
                          'Jenis Kelamin',
                          siswa.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan',
                        ),
                        _buildInfoRow(Icons.class_, 'Kelas', siswa.kelas),
                        _buildInfoRow(
                          Icons.location_on,
                          'Alamat',
                          siswa.alamat,
                        ),
                        _buildInfoRow(
                          Icons.phone,
                          'No. Telepon',
                          siswa.noTelepon,
                        ),
                        _buildInfoRow(
                          Icons.calendar_today,
                          'Tahun Ajaran',
                          siswa.tahunAjaran,
                        ),
                      ],
                    ),
                  ),
                ),

                // Actions
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Tutup'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : '-',
                  style: const TextStyle(fontSize: 16),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Alternatif: Modal Bottom Sheet version
  static void showBottomSheet(BuildContext context, ModelsSiswa siswa) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Content (sama seperti di atas)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ... (sama seperti content di atas)
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.blue.shade700,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              siswa.nama,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        siswa.kelas,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey.shade300),
                      const SizedBox(height: 8),

                      // Info rows
                      _buildInfoRow(Icons.badge, 'NISN', siswa.nisn),
                      _buildInfoRow(Icons.school, 'NIS', siswa.nis),
                      _buildInfoRow(
                        Icons.place,
                        'Tempat Lahir',
                        siswa.tempatLahir,
                      ),
                      _buildInfoRow(
                        Icons.cake,
                        'Tanggal Lahir',
                        '${siswa.tanggalLahir.day}/${siswa.tanggalLahir.month}/${siswa.tanggalLahir.year}',
                      ),
                      _buildInfoRow(
                        siswa.jenisKelamin == 'L' ? Icons.male : Icons.female,
                        'Jenis Kelamin',
                        siswa.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan',
                      ),
                      _buildInfoRow(Icons.class_, 'Kelas', siswa.kelas),
                      _buildInfoRow(Icons.location_on, 'Alamat', siswa.alamat),
                      _buildInfoRow(
                        Icons.phone,
                        'No. Telepon',
                        siswa.noTelepon,
                      ),
                      _buildInfoRow(
                        Icons.calendar_today,
                        'Tahun Ajaran',
                        siswa.tahunAjaran,
                      ),
                    ],
                  ),
                ),
              ),

              // Close button
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
