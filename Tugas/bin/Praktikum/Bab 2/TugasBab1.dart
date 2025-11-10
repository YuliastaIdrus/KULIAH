 import 'dart:async';

// Enum untuk peran user
enum Role { Admin, Customer }

// Class Product untuk data produk
class Product {
  String name;
  double price;
  bool inStock;

  Product(this.name, this.price, this.inStock);
}

// Class User (induk)
class User {
  String name;
  int age;
  Role? role;              // nullable type
  late List<Product> list; // diinisialisasi setelah objek dibuat

  User(this.name, this.age, this.role);

  void lihatProduk(Map<String, Product> daftar) {
    print("\nDaftar Produk:");
    daftar.forEach((key, value) {
      print("- ${value.name} : Rp${value.price} (${value.inStock ? 'Tersedia' : 'Habis'})");
    });
  }
}

// AdminUser (turunan dari User)
class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age, Role.Admin) {
    list = [];
  }

  void tambahProduk(Map<String, Product> daftar, Product p) {
    try {
      if (!p.inStock) {
        throw Exception("Produk '${p.name}' sedang habis stok!");
      }
      daftar[p.name] = p;
      print("Produk '${p.name}' berhasil ditambahkan!");
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  void hapusProduk(Map<String, Product> daftar, String namaProduk) {
    if (daftar.remove(namaProduk) != null) {
      print("Produk '$namaProduk' berhasil dihapus!");
    } else {
      print("Produk '$namaProduk' tidak ditemukan!");
    }
  }
}

// CustomerUser (turunan dari User)
class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age, Role.Customer) {
    list = [];
  }

  void lihatProdukCustomer(Map<String, Product> daftar) {
    lihatProduk(daftar);
  }
}

// Fungsi async untuk simulasi ambil data
Future<void> fetchProductDetails(String nama) async {
  print("\nMengambil detail produk '$nama'...");
  await Future.delayed(Duration(seconds: 2));
  print("Detail produk '$nama' berhasil diambil!");
}

// Fungsi utama (main)
void main() async {
  Map<String, Product> daftarProduk = {}; // Menyimpan produk (pakai Map)
  Set<String> produkUnik = {};            // Untuk memastikan produk tidak ganda

  var admin = AdminUser("Aldi", 25);
  var customer = CustomerUser("Mira", 20);

  // Admin menambah produk
  admin.tambahProduk(daftarProduk, Product("Laptop", 8500000, true));
  admin.tambahProduk(daftarProduk, Product("Mouse", 150000, true));
  admin.tambahProduk(daftarProduk, Product("Keyboard", 200000, false)); // stok habis

  // Admin hapus produk
  admin.hapusProduk(daftarProduk, "Mouse");

  // Customer melihat produk
  customer.lihatProdukCustomer(daftarProduk);

  // Ambil detail produk secara async
  await fetchProductDetails("Laptop");

  // Tambahkan ke Set untuk produk unik
  daftarProduk.forEach((key, value) => produkUnik.add(key));
  print("\nProduk unik di sistem: $produkUnik");
}