class ModelsSiswa {
  final int id;
  final String nama;
  final String nisn;
  final String nis;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String jenisKelamin;
  final String alamat;
  final String noTelepon;
  final String kelas;
  final String tahunAjaran;
  final String foto;

  //  Tambahkan field DateTime baru
  final DateTime createdAt;
  final DateTime updatedAt;

  ModelsSiswa({
    required this.id,
    required this.nama,
    required this.nisn,
    required this.nis,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.alamat,
    required this.noTelepon,
    required this.kelas,
    required this.tahunAjaran,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  toJson() {}
}
