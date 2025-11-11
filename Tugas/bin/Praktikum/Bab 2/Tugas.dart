// 1. Kelas ProdukDigital dengan diskon khusus
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;
  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon() {
    if (kategori == "NetworkAutomation") harga *= 0.9;
    print("Produk: $namaProduk | Harga: $harga");
  }
}

// 2. Kelas abstrak & subclass Karyawan
abstract class Karyawan {
  String nama;
  int umur;
  String peran;
  bool aktif = true;
  Karyawan(this.nama, this.umur, this.peran);
  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String n, int u, String p) : super(n, u, p);
  void bekerja() => print("$nama bekerja penuh waktu.");
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String n, int u, String p) : super(n, u, p);
  void bekerja() => print("$nama bekerja kontrak.");
}

// 3. Positional & named arguments
class DataKaryawan {
  String nama;
  int umur;
  String peran;
  DataKaryawan(this.nama, {required this.umur, required this.peran});
  void info() => print("Nama: $nama | Umur: $umur | Peran: $peran");
}

// 4. Mixin untuk produktivitas
mixin Kinerja {
  double produktivitas = 80;
  void tingkatkanProduktivitas(int hari) {
    if (hari >= 30) produktivitas += 5;
    if (this is Manager && produktivitas < 85) produktivitas = 85;
    print("Produktivitas: $produktivitas%");
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String n, int u) : super(n, u, "Manager");
  void bekerja() => print("$nama memimpin tim proyek.");
}

// 5. Enum fase proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  void lanjutFase() {
    if (fase == FaseProyek.Perencanaan) fase = FaseProyek.Pengembangan;
    else if (fase == FaseProyek.Pengembangan) fase = FaseProyek.Evaluasi;
    print("Fase saat ini: $fase");
  }
}

// 6. Batasan jumlah karyawan aktif
class Perusahaan {
  List<Karyawan> aktif = [], nonAktif = [];
  static const int batas = 20;

  void tambah(Karyawan k) =>
      (aktif.length < batas) ? aktif.add(k) : print("Batas aktif tercapai");
  void resign(Karyawan k) {
    if (aktif.remove(k)) {
      k.aktif = false;
      nonAktif.add(k);
    }
  }
  void status() => print("Aktif: ${aktif.length} | Non-Aktif: ${nonAktif.length}");
}

// Main untuk uji semua fitur
void main() {
  var p1 = ProdukDigital("Cisco Packet Tracer", 500000, "NetworkAutomation");
  var p2 = ProdukDigital("MS Word", 250000, "Office");
  p1.terapkanDiskon(); p2.terapkanDiskon();

  var tetap = KaryawanTetap("Andi", 30, "Programmer");
  var kontrak = KaryawanKontrak("Budi", 25, "Tester");
  tetap.bekerja(); kontrak.bekerja();

  var data = DataKaryawan("Citra", umur: 27, peran: "Designer"); data.info();

  var mgr = Manager("Dina", 35); mgr.tingkatkanProduktivitas(30);

  var proyek = Proyek(); proyek.lanjutFase(); proyek.lanjutFase();

  var pt = Perusahaan();
  pt.tambah(tetap); pt.tambah(kontrak); pt.tambah(mgr);
  pt.resign(kontrak); pt.status();
}