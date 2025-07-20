import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

enum SortOption { none, priceLowToHigh, priceHighToLow, rating }

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String? _error;
  SortOption _currentSort = SortOption.none;

  List<Product> get products => _filteredProducts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  SortOption get currentSort => _currentSort;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _products = await ApiService.getProducts();
      _filteredProducts = [..._products];
      _applySorting();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void sortProducts(SortOption option) {
    _currentSort = option;
    _applySorting();
    notifyListeners();
  }

  void _applySorting() {
    switch (_currentSort) {
      case SortOption.priceLowToHigh:
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.rating:
        _filteredProducts.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        break;
      case SortOption.none:
        _filteredProducts = [..._products];
        break;
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = [..._products];
    } else {
      _filteredProducts = _products.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    _applySorting();
    notifyListeners();
  }
}