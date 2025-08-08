import 'package:flutter/material.dart';
import 'package:flutter_agus/models/quran_model.dart';

class QuranDetailScreen extends StatelessWidget {
  final QuranModel surah;

  const QuranDetailScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // latar belakang biru muda
      appBar: AppBar(
        title: Text('Surah ${surah.nama ?? '-'}'),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ikon
            Center(
              child: Icon(Icons.menu_book_rounded,
                  size: 60, color: Colors.lightBlue),
            ),
            const SizedBox(height: 16),

            // Nama Arab
            Center(
              child: Text(
                surah.asma ?? '',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri', // Gaya tulisan arab
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Arti
            Center(
              child: Text(
                '"${surah.arti ?? '-'}"',
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Divider(thickness: 1),

            // Informasi dasar
            const Text(
              'Informasi Surah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 12),
            InfoTile(title: 'Nama Latin', value: surah.nama),
            InfoTile(title: 'Nomor Surah', value: surah.nomor),
            InfoTile(title: 'Jumlah Ayat', value: surah.ayat?.toString()),
            InfoTile(title: 'Tipe Surah', value: surah.type),
            InfoTile(title: 'Urutan Wahyu', value: surah.urut),
            InfoTile(title: 'Rukuk', value: surah.rukuk),

            const SizedBox(height: 24),

            // Keterangan
            if (surah.keterangan != null && surah.keterangan!.isNotEmpty) ...[
              const Text(
                'Keterangan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                surah.keterangan!,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String? value;

  const InfoTile({
    super.key,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value ?? '-',
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
