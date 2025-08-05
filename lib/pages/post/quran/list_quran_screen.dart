import 'package:flutter/material.dart';
import 'package:flutter_agus/models/quran_model.dart';
import 'package:flutter_agus/pages/post/quran/detail_quran_screen.dart';
import 'package:flutter_agus/services/quran_service.dart';

class ListQuranScreen extends StatelessWidget {
  const ListQuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surah Al-Qur\'an'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<QuranModel>>(
        future: QuranService.listQuran(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }

          final surahList = snapshot.data ?? [];

          if (surahList.isEmpty) {
            return const Center(child: Text('Data tidak ditemukan.'));
          }

          return ListView.builder(
            itemCount: surahList.length,
            itemBuilder: (context, index) {
              final surah = surahList[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(
                      surah.nomor ?? '-',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    '${surah.nama ?? 'Surah'} (${surah.asma ?? '-'})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${surah.type} • ${surah.ayat} ayat\nArti: ${surah.arti}',
                    style: const TextStyle(height: 1.4),
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
