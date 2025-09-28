void main() {
  // Panjang dan lebar dimasukkan langsung melalui variabel
  double panjang = 10;
  double lebar = 5;

  // Hitung luas dan keliling
  double luas = panjang * lebar;
  double keliling = 2 * (panjang + lebar);

  // Tampilkan hasil dengan format rapi (bilangan bulat)
  print("Panjang = ${panjang.toInt()}");
  print("Lebar = ${lebar.toInt()}");
  print("Luas = ${luas.toInt()}");
  print("Keliling = ${keliling.toInt()}");
}