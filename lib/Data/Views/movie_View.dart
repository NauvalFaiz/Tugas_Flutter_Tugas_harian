import 'package:belajar_flutter_r7/Data/Controllers/Movie_controler.dart';
import 'package:belajar_flutter_r7/Data/Models/models_movie.dart';
import 'package:belajar_flutter_r7/Data/Views/Modal_widget.dart';
import 'package:flutter/material.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  final formKey = GlobalKey<FormState>();
  MovieController movie = MovieController();
  TextEditingController title = TextEditingController();
  TextEditingController gambar = TextEditingController();
  TextEditingController voteAverage = TextEditingController();
  TextEditingController overview = TextEditingController();

  List<String> buttonChoice = ["Update", "Hapus"];
  List<MovieModel>? film;
  int? film_id;

  getFilm() {
    setState(() {
      film = movie.movie;
    });
  }

  @override
  void initState() {
    super.initState();
    getFilm();
  }

  // 🔥 Fungsi baru: Hapus semua data
  void _hapusSemuaData() {
    if (film == null || film!.isEmpty) {
      // Tidak ada data untuk dihapus
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Tidak ada data untuk dihapus.")));
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Apakah Anda yakin ingin menghapus semua data film?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Batal
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                // Hapus semua data
                movie.movie.clear(); // Hapus data dari controller
                getFilm(); // Perbarui state

                // Tutup dialog
                Navigator.pop(context);

                // Tampilkan pesan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Semua data film telah dihapus.")),
                );
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.4),
      appBar: AppBar(
        title: Text("Movie"),
        actions: [
          // 🔥 Tambahkan tombol Hapus Semua
          IconButton(
            onPressed: _hapusSemuaData,
            icon: Icon(Icons.delete_sweep),
            tooltip: "Hapus Semua Data",
          ),
          IconButton(
            onPressed: () {
              // 🔥 Tambahkan pengecekan mounted
              if (!mounted) return;

              setState(() {
                film_id = null;
              });
              title.text = '';
              gambar.text = '';
              voteAverage.text = '';
              overview.text = '';
              ModalWidget().showFullModal(context, addItem(null));
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: film?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Poster Image
                Container(
                  width: 100,
                  height: 135,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 4),
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 5.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(film![index].posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Title + Rating + Overview
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        film![index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      // Bintang Rating
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              i < (film![index].voteAverage?.floor() ?? 0)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          SizedBox(width: 8),
                          Text(
                            "${film![index].voteAverage?.toStringAsFixed(1) ?? '0.0'}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      // Overview
                      Text(
                        film![index].overview,
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // ... bagian sebelumnya sama ...
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "Update") {
                      if (film == null) return;

                      setState(() {
                        film_id = film![index].id;
                      });
                      title.text = film![index].title;
                      gambar.text = film![index].posterPath;
                      voteAverage.text =
                          film![index].voteAverage?.toString() ?? '';
                      overview.text = film![index].overview;
                      ModalWidget().showFullModal(context, addItem(index));
                    } else if (value == "Hapus") {
                      // 🔥 Ambil data sebelum dihapus
                      final filmDihapus = film![index];

                      // Hapus data
                      film!.removeWhere((item) => item.id == filmDihapus.id);
                      getFilm(); // Perbarui tampilan

                      // 🟩 Gunakan data yang sudah diambil untuk pesan
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Film '${filmDihapus.title}' telah dihapus.",
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return buttonChoice.map((choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                  icon: Icon(Icons.more_horiz),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget addItem(int? index) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: title,
              decoration: InputDecoration(labelText: "Title"),
              validator: (value) {
                if (value!.isEmpty) return 'Harus diisi';
                return null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: gambar,
              decoration: InputDecoration(labelText: "Gambar (URL)"),
              validator: (value) {
                if (value!.isEmpty) return 'Harus diisi';
                return null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: voteAverage,
              decoration: InputDecoration(
                labelText: "Vote Average (0.0 - 10.0)",
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value!.isEmpty) return 'Harus diisi';
                final num = double.tryParse(value);
                if (num == null || num < 0 || num > 10) {
                  return 'Masukkan angka antara 0.0 - 10.0';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: overview,
              decoration: InputDecoration(labelText: "Overview"),
              maxLines: 3,
              validator: (value) {
                if (value!.isEmpty) return 'Harus diisi';
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // 🔥 Gunakan tryParse dan cek nilainya
                  final newVote = double.tryParse(voteAverage.text);
                  if (newVote == null) {
                    // 🟩 Tidak akan terjadi karena validator sudah memeriksa
                    // Tapi tetap aman untuk handle
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("VoteAverage harus angka!")),
                    );
                    return;
                  }

                  if (index != null) {
                    // Update
                    if (film == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data film tidak ditemukan.")),
                      );
                      return;
                    }
                    film![index].id = film_id!;
                    film![index].title = title.text;
                    film![index].posterPath = gambar.text;
                    film![index].voteAverage = newVote;
                    film![index].overview = overview.text;
                  } else {
                    // Tambah
                    if (film == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data film tidak ditemukan.")),
                      );
                      return;
                    }
                    int _id_film = film!.length + 1;
                    film!.add(
                      MovieModel(
                        id: _id_film,
                        title: title.text,
                        posterPath: gambar.text,
                        voteAverage: newVote,
                        overview: overview.text,
                      ),
                    );
                  }

                  getFilm();
                  Navigator.pop(context); // Tutup modal setelah simpan
                }
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
