import 'package:flutter/material.dart';
import 'package:flutter_agus/models/quran_model.dart';

class QuranDetailScreen extends StatelessWidget {
  final QuranModel surah;

  const QuranDetailScreen({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${surah.nama ?? '-'}'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Arab
            Center(
              child: Text(
                surah.asma ?? '',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Amiri', // Optional: font Arabic
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
            const Divider(),

            // Informasi dasar
            InfoTile(title: 'Nama Latin', value: surah.nama),
            InfoTile(title: 'Nomor Surah', value: surah.nomor),
            InfoTile(title: 'Jumlah Ayat', value: surah.ayat?.toString()),
            InfoTile(title: 'Tipe', value: surah.type),
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
                ),
              ),
              const SizedBox(height: 8),
              Text(
                surah.keterangan!,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, height: 1.5),
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
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 5,
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
