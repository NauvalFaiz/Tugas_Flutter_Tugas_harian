// lib/Data/Views/widgets/siswa_card.dart
import 'package:belajar_flutter_r7/Data/Views/Profil_Siswa.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';

class SiswaCard extends StatelessWidget {
  final ModelsSiswa siswa;
  final Function(ModelsSiswa) onEdit;
  final Function(ModelsSiswa) onDelete;
  final Function(BuildContext, ModelsSiswa)? onShowEditOptions;

  const SiswaCard({
    super.key,
    required this.siswa,
    required this.onEdit,
    required this.onDelete,
    this.onShowEditOptions,
  });

  void _showEditOptions(BuildContext context, ModelsSiswa siswa) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text('Lihat Profil'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SiswaProfilePage(siswa: siswa),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.orange),
                title: const Text('Edit Data'),
                onTap: () {
                  Navigator.pop(context);
                  onEdit(siswa);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Hapus'),
                onTap: () {
                  Navigator.pop(context);
                  onDelete(siswa);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvatar(ModelsSiswa siswa) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          siswa.foto,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: Colors.grey.shade400, size: 30),
            );
          },
        ),
      ),
    );
  }

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

  Widget _buildActionButtons(BuildContext context, ModelsSiswa siswa) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Jenis Kelamin Icon
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: siswa.jenisKelamin == 'L'
                ? Colors.blue.shade50
                : Colors.pink.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(
            siswa.jenisKelamin == 'L' ? Icons.male : Icons.female,
            color: siswa.jenisKelamin == 'L'
                ? Colors.blue.shade600
                : Colors.pink.shade600,
            size: 18,
          ),
        ),
        const SizedBox(height: 8),

        // Edit Button
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: () => onEdit(siswa),
          color: Colors.orange,
          tooltip: 'Edit',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),

        // Delete Button
        IconButton(
          icon: const Icon(Icons.delete, size: 20),
          onPressed: () => onDelete(siswa),
          color: Colors.red,
          tooltip: 'Hapus',
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SiswaProfilePage(siswa: siswa),
            ),
          );
        },
        onLongPress: () => _showEditOptions(context, siswa),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar
              _buildAvatar(siswa),
              const SizedBox(width: 16),

              // Info Siswa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      siswa.nama,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildInfoChip('NISN: ${siswa.nisn}', Colors.blue),
                        const SizedBox(width: 8),
                        _buildInfoChip(siswa.kelas, Colors.green),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${siswa.tempatLahir}, ${_formatDate(siswa.tanggalLahir)}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              _buildActionButtons(context, siswa),
            ],
          ),
        ),
      ),
    );
  }
}
