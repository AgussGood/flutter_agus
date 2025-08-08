import 'package:flutter/material.dart';
import 'package:flutter_agus/models/product_model.dart';
import 'package:flutter_agus/pages/product/product_create_screen.dart';
import 'package:flutter_agus/pages/product/product_detail_screen.dart';
import 'package:flutter_agus/services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _futureProducts = ProductService.fetchProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _loadProducts();
    });
  }

  String formatRupiah(double number) {
    return 'Rp ' +
        number.toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]}.',
            );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.lightBlue.shade300,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue.shade300,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProductCreateScreen()),
          );
          _refreshProducts(); // refresh setelah kembali
        },
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("Tidak ada produk"));

          return RefreshIndicator(
            onRefresh: _refreshProducts,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final product = snapshot.data![index];
                return Card(
                  color: Colors.lightBlue[50], // <== Warna biru lembut
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'http://127.0.0.1:8000/storage/${product.image}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.image_not_supported, size: 40),
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      formatRupiah(product.price),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailScreen(productId: product.id),
                        ),
                      );
                      _refreshProducts(); // refresh setelah kembali dari detail/edit
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
