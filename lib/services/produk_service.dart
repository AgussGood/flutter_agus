import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_agus/models/produk_model.dart';

class ProdukService {
  final String baseUrl = 'https://fakestoreapi.com/products';

  // Ambil semua produk
  Future<List<Produk>> fetchProduk() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Produk.fromJson(item)).toList();
    } else {
      throw Exception('Gagal mengambil data produk');
    }
  }

  // Ambil produk berdasarkan ID
  Future<Produk> fetchProdukById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Produk.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengambil produk');
    }
  }
}
  