import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_agus/models/product_model.dart';
import 'package:flutter_agus/pages/menu_screen.dart';
import 'package:flutter_agus/services/product_service.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;
  const ProductEditScreen({super.key, required this.product});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _priceController;

  Uint8List? _imageBytes;
  String? _imageName;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _descController = TextEditingController(text: widget.product.description);
    _priceController = TextEditingController(
      text: widget.product.price.toString(),
    );
    super.initState();
  }

  Future pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imageName = picked.name;
      });
    }
  }

  void submit() async {
    final success = await ProductService.updateProduct(
      widget.product.id,
      _nameController.text,
      _descController.text,
      double.tryParse(_priceController.text) ?? 0.0,
      _imageBytes,
      _imageName,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MenuScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui produk')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
        backgroundColor: Colors.lightBlue.shade300,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Description
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Price
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                  prefixText: "Rp ",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Image picker
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pick New Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade300,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Preview image
              if (_imageBytes != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(_imageBytes!, height: 150),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'http://127.0.0.1:8000/storage/${widget.product.image}', // ✅ Sesuai dengan model
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Text("No Image"),
                  ),
                ),

              const SizedBox(height: 30),

              // Submit button
              ElevatedButton(
                onPressed: submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    "Update Product",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
