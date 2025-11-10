
void main() async {
  print('=== Aplikasi Pencatat Ibadah Harian (IbadahTracker) ===');

  // --------- Bagian 1: Tipe Data & Variabel ---------
  String nama = "Yuli";
  int targetIbadah = 5;
  double waktuNgaji = 1.5;
  bool sudahSholat = false;

  List<String> ibadah = ["Sholat", "Ngaji", "Sedekah"];
  Map<String, int> durasi = {"Sholat": 10, "Ngaji": 20, "Sedekah": 5};
  Set<String> ibadahUnik = {"Sholat", "Ngaji", "Sedekah"}; // koleksi tambahan

  print('\nNama: $nama');
  print('Target Ibadah: $targetIbadah kali');
  print('Durasi Ibadah: $durasi');
  print('Ibadah unik: $ibadahUnik');

  // --------- Bagian 2: Final, Const, Late ---------
  final tanggal = DateTime.now();
  const appName = "IbadahTracker";
  late String mood;

  mood = "Semangat";
  print('\n$appName dijalankan pada: $tanggal');
  print('Mood saat ini: $mood');

  // --------- Bagian 3: Fungsi ---------
  salam(); // tanpa parameter dan tanpa return
  tampilkanPesan("Tetap semangat beribadah!(✿◡‿◡)"); // dengan parameter
  int total = hitungTotalIbadah(3, 2);
  print('Total ibadah hari ini: $total');

  // --------- Bagian 4: Conditional Expression ---------
  String statusSholat = sudahSholat ? "Sudah sholat ✅" : "Belum sholat ❌";
  print('Status sholat: $statusSholat');

  // --------- Bagian 5: Asynchronous Programming ---------
  print('\nSedang menyimpan data ke server...');
  await simpanDataAsync();

  print('\nStream contoh (menampilkan setiap ibadah secara bertahap):');
  await for (var i in tampilkanIbadahStream(ibadah)) {
    print('Ibadah: $i');
  }

  // --------- Bagian 6: Error Handling ---------
  try {
    int hasil = bagi(10, 0);
    print('Hasil pembagian: $hasil');
  } on IntegerDivisionByZeroException {
    print('Terjadi kesalahan: Tidak bisa membagi dengan nol.');
  } catch (e) {
    print('Error tak terduga: $e');
  }

  print('\nProgram selesai dijalankan ✅');
}

// ================== Fungsi ==================

// Fungsi tanpa parameter & tanpa return
void salam() {
  print('\nAssalamualaikum!');
}

// Fungsi dengan parameter
void tampilkanPesan(String pesan) {
  print('Pesan: $pesan');
}

// Fungsi dengan return
int hitungTotalIbadah(int sholat, int ngaji) {
  return sholat + ngaji;
}

// Fungsi asynchronous
Future<void> simpanDataAsync() async {
  await Future.delayed(Duration(seconds: 2));
  print('Data berhasil disimpan!');
}

// Stream (async* dan yield)
Stream<String> tampilkanIbadahStream(List<String> daftar) async* {
  for (var item in daftar) {
    await Future.delayed(Duration(milliseconds: 500));
    yield item;
  }
}

// Exception example
int bagi(int a, int b) {
  return a ~/ b;
}
