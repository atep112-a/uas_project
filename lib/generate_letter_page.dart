import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'models/surat.dart';
import 'package:uas_project/utils/base64_utils.dart';

Future<Uint8List> generateSuratPdf(Surat surat) async {
  final pdf = pw.Document();

  Uint8List imageBytes = decodeBase64Image(surat.uploadTTD);

  // Debug print to check if imageBytes is populated
  print('Image bytes length: ${imageBytes.length}');

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('PT Alim Bati Palai Rugi', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 20),
          pw.Text('Hal: Surat Izin Mahasiswa', style: pw.TextStyle(fontSize: 16)),
          pw.SizedBox(height: 20),
          pw.Text('Yth. Ibu/Bapak : ${surat.namaPenerima}'),
          pw.Text('${surat.jabatanPenerima} ${surat.namaUniv}'),
          pw.Text('Di tempat'),
          pw.SizedBox(height: 20),
          pw.Text('Saya yang bertanda tangan dibawah ini :'),
          pw.Text('Nama : ${surat.nama}'),
          pw.Text('Jabatan : ${surat.jabatan}'),
          pw.Text('Perusahaan : ${surat.perusahaan}'),
          pw.SizedBox(height: 20),
          pw.Text('Bahwa mahasiswa dengan data dibawah ini:'),
          pw.Text('Nama : ${surat.namaMahasiswa}'),
          pw.Text('NIM : ${surat.nim}'),
          pw.Text('Perguruan Tinggi : ${surat.namaUniv}'),
          pw.SizedBox(height: 20),
          pw.Text('Memohon izin untuk tidak mengikuti perkuliahan seperti biasa dikarenakan ${surat.perihalIzin} dari mulai ${surat.izinMulai} sampai ${surat.izinSelesai}. Mohon bapak/ibu dapat memakluminya.'),
          pw.SizedBox(height: 20),
          pw.Text('Demikian, atas perhatian dan kebijaksanaan bapak/ibu dosen, saya ucapkan terima kasih.'),
          pw.SizedBox(height: 40),
          pw.Text('${surat.tempatTerbit}, ${surat.tanggalTerbit}'),
          pw.SizedBox(height: 20),
          if (imageBytes.isNotEmpty)
            pw.Image(pw.MemoryImage(imageBytes), width: 50, height: 50),
          
          pw.SizedBox(height: 20),
          pw.Text('${surat.nama}'),
        ],
      ),
    ),
  );

  return pdf.save();
}