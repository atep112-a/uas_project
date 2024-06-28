class Surat {
  int? id;
  final String nama;
  final String jabatan;
  final String perusahaan;
  final String namaPenerima;
  final String jabatanPenerima;
  final String namaMahasiswa;
  final String nim;
  final String kelas;
  final String namaUniv;
  final String perihalIzin;
  final String izinMulai;
  final String izinSelesai;
  final String tempatTerbit;
  final String tanggalTerbit;
  final String uploadTTD;

  Surat({
    this.id,
    required this.nama,
    required this.jabatan,
    required this.perusahaan,
    required this.namaPenerima,
    required this.jabatanPenerima,
    required this.namaMahasiswa,
    required this.nim,
    required this.kelas,
    required this.namaUniv,
    required this.perihalIzin,
    required this.izinMulai,
    required this.izinSelesai,
    required this.tempatTerbit,
    required this.tanggalTerbit,
    required this.uploadTTD,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'jabatan': jabatan,
      'perusahaan': perusahaan,
      'namaPenerima': namaPenerima,
      'jabatanPenerima': jabatanPenerima,
      'namaMahasiswa': namaMahasiswa,
      'nim': nim,
      'kelas': kelas,
      'namaUniv': namaUniv,
      'perihalIzin': perihalIzin,
      'izinMulai': izinMulai,
      'izinSelesai': izinSelesai,
      'tempatTerbit': tempatTerbit,
      'tanggalTerbit': tanggalTerbit,
      'uploadTTD': uploadTTD,
    };
  }

  factory Surat.fromMap(Map<String, dynamic> map) {
    return Surat(
      id: map['id'],
      nama: map['nama'] ?? '',
      jabatan: map['jabatan'] ?? '',
      perusahaan: map['perusahaan'] ?? '',
      namaPenerima: map['namaPenerima'] ?? '',
      jabatanPenerima: map['jabatanPenerima'] ?? '',
      namaMahasiswa: map['namaMahasiswa'] ?? '',
      nim: map['nim'] ?? '',
      kelas: map['kelas'] ?? '',
      namaUniv: map['namaUniv'] ?? '',
      perihalIzin: map['perihalIzin'] ?? '',
      izinMulai: map['izinMulai'] ?? '',
      izinSelesai: map['izinSelesai'] ?? '',
      tempatTerbit: map['tempatTerbit'] ?? '',
      tanggalTerbit: map['tanggalTerbit'] ?? '',
      uploadTTD: map['uploadTTD'] ?? '',
    );
  }
}
