// lib/Data/Controllers/Siswa_controler.dart
import 'package:belajar_flutter_r7/Data/Array/data_siswa/siswa_data.dart';
import 'package:belajar_flutter_r7/Data/Models/models_sisiwa.dart';
import 'package:belajar_flutter_r7/Data/Models/deleted_siswa_info.dart';

class SiswaController {
  static final SiswaController _instance = SiswaController._internal();
  factory SiswaController() => _instance;
  SiswaController._internal() {
    // ✅ INISIALISASI DATA DARI SISWA_DATA.DART
    _initializeData();
  }

  List<ModelsSiswa> siswa = [];
  List<DeletedSiswaInfo> deletedSiswa = [];

  // ✅ METHOD: INISIALISASI DATA DARI FILE TERPISAH
  void _initializeData() {
    siswa = List.from(SiswaData.initialData);
    print('✅ Data siswa berhasil diinisialisasi: ${siswa.length} siswa');
  }

  // ✅ METHOD: Reset data ke initial state (untuk testing)
  void resetToInitialData() {
    siswa = List.from(SiswaData.initialData);
    deletedSiswa.clear();
    print('✅ Data direset ke initial state: ${siswa.length} siswa');
  }

  // ✅ GETTER untuk mendapatkan ID berikutnya
  int get nextId {
    if (siswa.isEmpty) return 1;
    return siswa.map((s) => s.id).reduce((a, b) => a > b ? a : b) + 1;
  }

  // ✅ METHOD: Tambah siswa baru
  void addSiswa(ModelsSiswa newSiswa) {
    siswa.add(newSiswa);
    print('✅ Siswa baru ditambahkan: ${newSiswa.nama}');
  }

  // ✅ METHOD: Update siswa dengan validasi
  bool updateSiswa(ModelsSiswa updatedSiswa) {
    try {
      print('🔄 UPDATE SISWA DIPANGGIL - ID: ${updatedSiswa.id}');

      final index = siswa.indexWhere((s) => s.id == updatedSiswa.id);
      print('📊 INDEX DITEMUKAN: $index');

      if (index != -1) {
        siswa[index] = ModelsSiswa(
          id: updatedSiswa.id,
          nama: updatedSiswa.nama,
          nisn: updatedSiswa.nisn,
          nis: updatedSiswa.nis,
          tempatLahir: updatedSiswa.tempatLahir,
          tanggalLahir: updatedSiswa.tanggalLahir,
          jenisKelamin: updatedSiswa.jenisKelamin,
          alamat: updatedSiswa.alamat,
          noTelepon: updatedSiswa.noTelepon,
          kelas: updatedSiswa.kelas,
          tahunAjaran: updatedSiswa.tahunAjaran,
          foto: updatedSiswa.foto,
          createdAt: siswa[index].createdAt,
          updatedAt: DateTime.now(),
        );

        print('✅ DATA BERHASIL DIUPDATE: ${updatedSiswa.nama}');
        return true;
      }

      print('❌ DATA TIDAK DITEMUKAN');
      return false;
    } catch (e) {
      print('❌ ERROR UPDATE SISWA: $e');
      return false;
    }
  }

  // ✅ METHOD: Get siswa by ID
  ModelsSiswa? getSiswaById(int id) {
    try {
      return siswa.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // ✅ METHOD: Delete siswa dengan menyimpan index asli
  bool deleteSiswa(ModelsSiswa siswaToDelete) {
    try {
      final index = siswa.indexWhere((s) => s.id == siswaToDelete.id);
      if (index != -1) {
        siswa.removeAt(index);

        deletedSiswa.add(
          DeletedSiswaInfo(siswa: siswaToDelete, originalIndex: index),
        );

        print('✅ Siswa dihapus: ${siswaToDelete.nama} (index: $index)');
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting siswa: $e');
      return false;
    }
  }

  // ✅ METHOD: Restore siswa ke index asli
  bool restoreSiswa(int id) {
    try {
      final deletedInfoIndex = deletedSiswa.indexWhere(
        (info) => info.siswa.id == id,
      );
      if (deletedInfoIndex == -1) {
        print('Data siswa dengan id $id tidak ditemukan di deletedSiswa');
        return false;
      }

      final deletedInfo = deletedSiswa[deletedInfoIndex];

      final alreadyExists = siswa.any((s) => s.id == id);
      if (alreadyExists) {
        print('Siswa dengan ID $id sudah ada di list aktif');
        return false;
      }

      if (deletedInfo.originalIndex <= siswa.length) {
        siswa.insert(deletedInfo.originalIndex, deletedInfo.siswa);
      } else {
        siswa.add(deletedInfo.siswa);
      }

      deletedSiswa.removeAt(deletedInfoIndex);
      print(
        '✅ Siswa dikembalikan: ${deletedInfo.siswa.nama} ke index ${deletedInfo.originalIndex}',
      );
      return true;
    } catch (e) {
      print('Error restoring siswa: $e');
      return false;
    }
  }

  // ✅ METHOD: Hapus permanen dengan validasi
  bool permanentlyDeleteSiswa(int id) {
    try {
      final initialLength = deletedSiswa.length;
      deletedSiswa.removeWhere((info) => info.siswa.id == id);
      final success = deletedSiswa.length < initialLength;
      if (success) {
        print('✅ Siswa dihapus permanen: ID $id');
      }
      return success;
    } catch (e) {
      print('Error permanently deleting siswa: $e');
      return false;
    }
  }

  // ✅ METHOD: Get list siswa yang dihapus (untuk UI)
  List<ModelsSiswa> get deletedSiswaList {
    return deletedSiswa.map((info) => info.siswa).toList();
  }

  // ✅ METHOD: Get original index by siswa ID
  int? getOriginalIndex(int siswaId) {
    try {
      final deletedInfo = deletedSiswa.firstWhere(
        (info) => info.siswa.id == siswaId,
      );
      return deletedInfo.originalIndex;
    } catch (e) {
      return null;
    }
  }

  // ✅ METHOD: Get statistics
  Map<String, int> getStatistics() {
    return {
      'total': siswa.length,
      'deleted': deletedSiswa.length,
      'lakiLaki': siswa.where((s) => s.jenisKelamin == 'L').length,
      'perempuan': siswa.where((s) => s.jenisKelamin == 'P').length,
    };
  }

  // Di SiswaController tambahkan:
  bool isNisnDuplicate(String nisn, {required int excludeId}) {
    return siswa.any((s) => s.nisn == nisn);
  }

  bool isNisDuplicate(String nis, {required int excludeId}) {
    return siswa.any((s) => s.nis == nis);
  }
}
