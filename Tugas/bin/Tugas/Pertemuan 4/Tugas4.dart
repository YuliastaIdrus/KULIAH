import 'dart:io';

void main() {
  List<Map<String, dynamic>> menu = [
    {'nama': 'Nasi Goreng', 'harga': 15000},
    {'nama': 'Mie Ayam', 'harga': 12000},
    {'nama': 'Bakso', 'harga': 13000},
    {'nama': 'Sate Ayam', 'harga': 18000},
    {'nama': 'Ayam Geprek', 'harga': 17000},
    {'nama': 'Es Teh', 'harga': 5000},
    {'nama': 'Es Jeruk', 'harga': 6000},
    {'nama': 'Jus Alpukat', 'harga': 10000},
    {'nama': 'Air Mineral', 'harga': 4000},
    {'nama': 'Kopi Hitam', 'harga': 8000},
  ];

  double saldo = 0;
  bool lanjut = true;
  bool pertama = true;

  List<Map<String, dynamic>> pesanan = []; // 🧾 daftar pesanan pelanggan
  double totalBelanja = 0;

  while (lanjut) {
    print("\n=== MENU RESTORAN ===");
    for (int i = 0; i < menu.length; i++) {
      print("${i + 1}. ${menu[i]['nama']} - Rp${menu[i]['harga']}");
    }

    stdout.write("Pilih menu (1-10): ");
    int? pilihan = int.tryParse(stdin.readLineSync() ?? '');
    if (pilihan == null || pilihan < 1 || pilihan > 10) {
      print("Pilihan tidak valid!");
      continue;
    }

    var item = menu[pilihan - 1];
    double harga = item['harga'].toDouble();
    print("Anda memilih: ${item['nama']} dengan harga Rp$harga");

    // Jika pertama kali, minta masukkan uang dulu
    if (pertama) {
      stdout.write("Masukkan jumlah pembayaran pertama (Rp): ");
      double? bayarPertama = double.tryParse(stdin.readLineSync() ?? '');
      if (bayarPertama == null || bayarPertama <= 0) {
        print("Input tidak valid. Transaksi dibatalkan.");
        break;
      }
      saldo = bayarPertama;
      pertama = false;
    }

    // Cek apakah saldo cukup untuk membeli
    if (saldo >= harga) {
      saldo -= harga;
      pesanan.add({'nama': item['nama'], 'harga': harga}); // simpan pesanan
      totalBelanja += harga;
      print("Pembayaran berhasil! Sisa saldo Anda: Rp$saldo");
    } else {
      double kekurangan = harga - saldo;
      print("Maaf, uang Anda tidak cukup. Kekurangan: Rp$kekurangan");

      stdout.write("Apakah Anda ingin menambahkan saldo? (y/n): ");
      String? tambah = stdin.readLineSync()?.toLowerCase();

      if (tambah == 'y') {
        stdout.write("Masukkan jumlah saldo tambahan (Rp): ");
        double? tambahan = double.tryParse(stdin.readLineSync() ?? '');
        if (tambahan != null && tambahan > 0) {
          saldo += tambahan;
          if (saldo >= harga) {
            saldo -= harga;
            pesanan.add({'nama': item['nama'], 'harga': harga});
            totalBelanja += harga;
            print("Pembayaran berhasil! Sisa saldo Anda: Rp$saldo");
          } else {
            print("Uang Anda masih kurang. Transaksi dibatalkan untuk menu ini.");
          }
        } else {
          print("Input tidak valid. Transaksi dibatalkan.");
        }
      } else {
        print("Terima kasih telah belanja di restoran kami ❤️");
        break;
      }
    }

    // Tawarkan lanjut pesan jika saldo masih ada
    if (saldo > 0) {
      stdout.write("Masih mau pesan lagi? (y/n): ");
      String? jawab = stdin.readLineSync()?.toLowerCase();
      if (jawab != 'y') {
        lanjut = false;
      }
    } else {
      print("Saldo habis. Terima kasih telah belanja di restoran kami ❤️");
      lanjut = false;
    }
  }

  // === DAFTAR PESANAN DI AKHIR PROGRAM ===
  if (pesanan.isNotEmpty) {
    print("\n=== DAFTAR PESANAN ANDA ===");
    for (var p in pesanan) {
      print("- ${p['nama']} (Rp${p['harga']})");
    }
    print("Total belanja: Rp$totalBelanja");
    print("Sisa saldo: Rp$saldo");
  }

  print("\n=== TERIMA KASIH TELAH BELANJA DI RESTORAN KAMI ❤️ ===");
}
