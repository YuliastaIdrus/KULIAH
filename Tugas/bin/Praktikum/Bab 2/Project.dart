
enum JenisIbadah { Sholat, Ngaji, Dzikir, Sedekah, Puasa }


mixin CatatanWaktu {
  DateTime waktuDicatat = DateTime.now();

  void tampilkanWaktu() {
    print("📅 Dicatat pada: $waktuDicatat");
  }
}

abstract class Ibadah {
  void lakukanIbadah(); 
}


class CatatanIbadah extends Ibadah with CatatanWaktu {
  // ATRIBUT
  String nama;
  JenisIbadah jenis;
  int durasi; // durasi dalam menit
  bool _selesai = false; // contoh atribut privat (pakai getter/setter)

  CatatanIbadah(this.nama, this.jenis, this.durasi);

  bool get selesai => _selesai;
  set selesai(bool value) {
    if (value == true) {
      print("✅ Ibadah ${jenis.name} telah selesai!");
    }
    _selesai = value;
  }

  // METHOD
  @override
  void lakukanIbadah() {
    print("🙏 $nama sedang melakukan ibadah ${jenis.name} selama $durasi menit...");
  }

  void tampilkanInfo() {
    print("Nama Ibadah  : ${jenis.name}");
    print("Durasi       : $durasi menit");
    print("Status       : ${selesai ? 'Selesai' : 'Belum selesai'}");
    tampilkanWaktu(); 
  }
}


class CatatanIbadahKhusus extends CatatanIbadah {
  String lokasi;

  CatatanIbadahKhusus({
    required String nama,
    required JenisIbadah jenis,
    required int durasi,
    required this.lokasi,
  }) : super(nama, jenis, durasi);

  // METHOD tambahan
  void tampilkanLokasi() {
    print("📍 Lokasi Ibadah: $lokasi");
  }

  @override
  void lakukanIbadah() {
    print("✨ $nama sedang melakukan ibadah ${jenis.name} di $lokasi selama $durasi menit.");
  }
}

void main() {
  // Menggunakan positional argument
  var ibadah1 = CatatanIbadah("Yuli", JenisIbadah.Sholat, 10);
  ibadah1.lakukanIbadah();
  ibadah1.selesai = true;
  ibadah1.tampilkanInfo();

  print("\n----------------------\n");

  // Menggunakan named argument
  var ibadah2 = CatatanIbadahKhusus(
    nama: "Yuli",
    jenis: JenisIbadah.Ngaji,
    durasi: 30,
    lokasi: "Masjid Al-Hidayah",
  );

  ibadah2.lakukanIbadah();
  ibadah2.selesai = true;
  ibadah2.tampilkanInfo();
  ibadah2.tampilkanLokasi();
}
