void main() {
    String nama = "Yuliasta";
    int jamKerja = 24;
    double upahPerjam = 100000;
    bool statusTetap = true;
    double gajiKotor = jamKerja * upahPerjam;

    double pajak;
    if (statusTetap) {
        pajak = gajiKotor * 0.10;
    } else {
        pajak = gajiKotor * 0.05;
    }

    double gajiBersih = gajiKotor - pajak;

    print("**********************Slip Gaji Karyawan********************");
    print("Nama Karyawan : $nama");
    print("Jam Kerja : $jamKerja jam");
    print("Upah per jam : Rp $upahPerjam");
    print("Gaji Kotor : Rp $gajiKotor");
    print("pajak : $pajak");
    print("Gaji Bersih : Rp $gajiBersih");
}