import 'package:flutter/material.dart';
import 'package:flutter_agus/models/produk_model.dart';
import 'package:flutter_agus/services/produk_service.dart';

class ProdukDetailScreen extends StatelessWidget {
  final int id;
  final ProdukService _produkService = ProdukService();

  ProdukDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.lightBlue.shade300,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Produk>(
        future: _produkService.fetchProdukById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final produk = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                color: Colors.lightBlue.shade50, // Warna biru lembut
                elevation: 3,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar produk
                      Center(
                        child: produk.image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  produk.image!,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(Icons.image, size: 80),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),

                      // Judul
                      Text(
                        produk.title ?? 'Tanpa Nama',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Harga
                      Text(
                        _formatRupiah(produk.price),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Kategori
                      Row(
                        children: [
                          const Icon(Icons.category, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            produk.category ?? 'Tanpa Kategori',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Rating
                      if (produk.rating != null)
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${produk.rating!.rate} dari ${produk.rating!.count} ulasan',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      const SizedBox(height: 16),

                      // Deskripsi
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        produk.description ?? 'Tidak ada deskripsi',
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('❌ Gagal memuat detail produk'),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // Format harga jadi Rupiah tanpa intl
  String _formatRupiah(double? price) {
    if (price == null) return 'Rp 0';
    final str = price.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    final formatted = str.replaceAllMapped(reg, (match) => '.');
    return 'Rp $formatted';
  }
}
