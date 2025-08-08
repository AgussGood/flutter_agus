import 'package:flutter/material.dart';
import 'package:flutter_agus/models/quran_model.dart';
import 'package:flutter_agus/pages/post/quran/detail_quran_screen.dart';
import 'package:flutter_agus/services/quran_service.dart';

class ListQuranScreen extends StatelessWidget {
  const ListQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Latar belakang biru muda
      appBar: AppBar(
        title: const Text('Daftar Surah Al-Qur\'an'),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<QuranModel>>(
        future: QuranService.listQuran(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final surahList = snapshot.data ?? [];

          if (surahList.isEmpty) {
            return const Center(child: Text('Data tidak ditemukan.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: surahList.length,
            itemBuilder: (context, index) {
              final surah = surahList[index];

              return Card(
                color: Colors.lightBlue[100], // Card dengan warna biru muda
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      surah.nomor ?? '-',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    '${surah.nama ?? 'Surah'} (${surah.asma ?? '-'})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${surah.type} • ${surah.ayat} ayat\nArti: ${surah.arti}',
                      style: const TextStyle(height: 1.5, fontSize: 13),
                    ),
                  ),
                  isThreeLine: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuranDetailScreen(surah: surah),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
