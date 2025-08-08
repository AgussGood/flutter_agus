import 'package:flutter/material.dart';
import 'package:flutter_agus/models/produk_model.dart';
import 'package:flutter_agus/services/produk_service.dart';
import 'produk_detail_screen.dart';

class ProdukListScreen extends StatelessWidget {
  final ProdukService _produkService = ProdukService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.lightBlue.shade300,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Produk>>(
        future: _produkService.fetchProduk(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final produkList = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: produkList.length,
              itemBuilder: (context, index) {
                final produk = produkList[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.lightBlue[50], // Card biru muda
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProdukDetailScreen(id: produk.id!),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar Produk
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          child: produk.image != null
                              ? Image.network(
                                  produk.image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image, size: 40),
                                )
                              : Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 40),
                                ),
                        ),
                        const SizedBox(width: 10),
                        // Info Produk
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produk.title ?? 'Tanpa Judul',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _formatRupiah(produk.price),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.teal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                if (produk.rating?.rate != null)
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 16, color: Colors.amber),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${produk.rating!.rate} (${produk.rating!.count})',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                '❌ Gagal memuat produk',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
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
