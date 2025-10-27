
abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar; // private
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas); 

  double get tarifDasar => _tarifDasar; 

  double hitungTarif(int jumlahPenumpang); 
  void tampilInfo() {
    print("ID       : $id");
    print("Nama     : $nama");
    print("Tarif    : $_tarifDasar");
    print("Kapasitas: $kapasitas");
  }
}


class Taksi extends Transportasi {
  double jarak; // km

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => tarifDasar * jarak;

  @override
  void tampilInfo() { 
    super.tampilInfo();
    print("Jarak    : $jarak km");
  }
}

class Bus extends Transportasi {
  bool adaWifi;

  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) =>
      (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Wifi     : ${adaWifi ? "Ada" : "Tidak ada"}");
  }
}


class Pesawat extends Transportasi {
  String kelas; 

  Pesawat(
      String id, String nama, double tarifDasar, int kapasitas, this.kelas)
      : super(id, nama, tarifDasar, kapasitas);

  @override 
  double hitungTarif(int jumlahPenumpang) =>
      tarifDasar *
          jumlahPenumpang *
          (kelas == "Bisnis" ? 1.5 : 1.0);

  @override
  void tampilInfo() {
    super.tampilInfo();
    print("Kelas    : $kelas");
  }
}


class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi,
      this.jumlahPenumpang, this.totalTarif);

  void cetakStruk() {
    print("===== STRUK PEMESANAN =====");
    print("Kode      : $idPemesanan");
    print("Nama      : $namaPelanggan");
    print("Kendaraan : ${transportasi.nama}");
    print("Penumpang : $jumlahPenumpang org");
    print("Total     : Rp $totalTarif");
  }

  Map<String, dynamic> toMap() {
    return { 
      "idPemesanan": idPemesanan,
      "namaPelanggan": namaPelanggan,
      "transportasi": transportasi.nama,
      "jumlahPenumpang": jumlahPenumpang,
      "totalTarif": totalTarif,
    };
  }
}


Pemesanan buatPemesanan(
    Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  return Pemesanan(DateTime.now().millisecondsSinceEpoch.toString(),
      nama, t, jumlahPenumpang, total);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  print("===== DAFTAR PEMESANAN =====");
  for (var p in daftar) {
    p.cetakStruk();
    print("----------------------");
  }
}


void main() {
  
  var taksi = Taksi("T01", "BlueBird", 8000, 4, 10);
  var bus = Bus("B01", "TransJakarta", 3500, 40, true);
  var pesawat = Pesawat("P01", "Garuda Indonesia", 800000, 180, "Bisnis");

  
  List<Pemesanan> daftarPemesanan = [];

 
  daftarPemesanan.add(buatPemesanan(taksi, "Yuli", 1));
  daftarPemesanan.add(buatPemesanan(bus, "Khairul", 5));
  daftarPemesanan.add(buatPemesanan(pesawat, "Asty", 2));

  tampilSemuaPemesanan(daftarPemesanan);
}