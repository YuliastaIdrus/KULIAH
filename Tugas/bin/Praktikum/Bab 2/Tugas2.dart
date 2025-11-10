// -----------------------------------------------
// SISTEM MANAJEMEN PERUSAHAAN "TechNova"
// Implementasi OOP - Bab 2
// -----------------------------------------------

// ENUM: Jenis produk dan peran karyawan
enum KategoriProduk { DataManagement, NetworkAutomation }
enum Peran { Developer, NetworkEngineer, Manager }

// MIXIN: Untuk menambah fitur kinerja
mixin Kinerja {
  int _produktivitas = 80;
  DateTime _terakhirUpdate = DateTime.now();

  void tingkatkanProduktivitas(int nilai) {
    if (DateTime.now().difference(_terakhirUpdate).inDays >= 30) {
      _produktivitas = (_produktivitas + nilai).clamp(0, 100);
      _terakhirUpdate = DateTime.now();
      print("✅ Produktivitas diperbarui: $_produktivitas");
    } else {
      print("⚠️ Produktivitas hanya dapat diperbarui setiap 30 hari.");
    }
  }

  int get produktivitas => _produktivitas;
}

// CLASS ABSTRAK: Kerangka umum karyawan
abstract class Karyawan {
  String nama;
  int umur;
  Peran peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja(); // method abstrak
}

// SUBCLASS: Karyawan Tetap
class KaryawanTetap extends Karyawan with Kinerja {
  double gajiBulanan;

  KaryawanTetap(String nama, {required int umur, required Peran peran, required this.gajiBulanan})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("👨‍💻 $nama sedang bekerja penuh waktu sebagai $peran dengan gaji $gajiBulanan");
  }
}

// SUBCLASS: Karyawan Kontrak
class KaryawanKontrak extends Karyawan with Kinerja {
  int durasiKontrak; // dalam bulan

  KaryawanKontrak(String nama, {required int umur, required Peran peran, required this.durasiKontrak})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("🧑‍🔧 $nama bekerja sebagai $peran selama $durasiKontrak bulan.");
  }
}

// CLASS PRODUK DIGITAL
class ProdukDigital {
  String namaProduk;
  double harga;
  KategoriProduk kategori;
  int terjual;

  ProdukDigital(this.namaProduk, this.harga, this.kategori, {this.terjual = 0});

  void terapkanDiskon() {
    if (kategori == KategoriProduk.NetworkAutomation && terjual > 50) {
      double hargaBaru = harga * 0.85;
      if (hargaBaru < 200000) {
        hargaBaru = 200000;
      }
      harga = hargaBaru;
      print("💰 Diskon diterapkan! Harga baru: $harga");
    }
  }
}

// CLASS PERUSAHAAN
class Perusahaan {
  String namaPerusahaan;
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  List<ProdukDigital> daftarProduk = [];

  Perusahaan(this.namaPerusahaan);

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      karyawanAktif.add(karyawan);
      print("✅ Karyawan ${karyawan.nama} ditambahkan ke perusahaan.");
    } else {
      print("⚠️ Jumlah karyawan aktif sudah mencapai batas (20).");
    }
  }

  void resignKaryawan(String nama) {
    var karyawan = karyawanAktif.firstWhere(
        (k) => k.nama == nama,
        orElse: () => throw Exception("Karyawan tidak ditemukan"));
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
    print("👋 Karyawan ${karyawan.nama} telah resign.");
  }

  void tambahProduk(ProdukDigital produk) {
    daftarProduk.add(produk);
    print("🛒 Produk ${produk.namaProduk} ditambahkan ke katalog.");
  }

  void tampilkanData() {
    print("\n=== DATA PERUSAHAAN $namaPerusahaan ===");
    print("Jumlah karyawan aktif : ${karyawanAktif.length}");
    print("Jumlah produk          : ${daftarProduk.length}");
  }
}

// ENUM FASE PROYEK
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawan = 0;
  int lamaHari = 0;

  void lanjutFase() {
    switch (fase) {
      case FaseProyek.Perencanaan:
        if (jumlahKaryawan >= 5) {
          fase = FaseProyek.Pengembangan;
          print("🚀 Beralih ke fase Pengembangan!");
        } else {
          print("⚠️ Minimal 5 karyawan dibutuhkan untuk lanjut.");
        }
        break;
      case FaseProyek.Pengembangan:
        if (lamaHari > 45) {
          fase = FaseProyek.Evaluasi;
          print("✅ Beralih ke fase Evaluasi!");
        } else {
          print("⚠️ Proyek belum berjalan cukup lama (minimal 45 hari).");
        }
        break;
      case FaseProyek.Evaluasi:
        print("🏁 Proyek sudah di fase akhir (Evaluasi).");
        break;
    }
  }
}

// ------------------------------------------------
// MAIN PROGRAM
// ------------------------------------------------
void main() {
  print("=== SISTEM MANAJEMEN PERUSAHAAN TECHNOVA ===\n");

  // Membuat perusahaan
  var perusahaan = Perusahaan("TechNova");

  // Menambahkan produk
  var produk1 = ProdukDigital("Data Analyzer", 180000, KategoriProduk.DataManagement, terjual: 20);
  var produk2 = ProdukDigital("Network Optimizer", 250000, KategoriProduk.NetworkAutomation, terjual: 60);
  produk2.terapkanDiskon();

  perusahaan.tambahProduk(produk1);
  perusahaan.tambahProduk(produk2);

  // Menambahkan karyawan
  var k1 = KaryawanTetap("Aisyah", umur: 27, peran: Peran.Manager, gajiBulanan: 5000000);
  var k2 = KaryawanKontrak("Budi", umur: 24, peran: Peran.Developer, durasiKontrak: 6);

  perusahaan.tambahKaryawan(k1);
  perusahaan.tambahKaryawan(k2);

  // Simulasi kerja dan peningkatan produktivitas
  k1.bekerja();
  k2.bekerja();
  k1.tingkatkanProduktivitas(10);

  // Proyek perusahaan
  var proyek = Proyek()
    ..jumlahKaryawan = 5
    ..lamaHari = 60;
  proyek.lanjutFase();
  proyek.lanjutFase();

  perusahaan.tampilkanData();
}
