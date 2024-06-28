import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/surat.dart';

class EditSuratPage extends StatefulWidget {
  final Surat surat;

  EditSuratPage({required this.surat});

  @override
  _EditSuratPageState createState() => _EditSuratPageState();
}

class _EditSuratPageState extends State<EditSuratPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _namaController;
  late TextEditingController _jabatanController;
  late TextEditingController _perusahaanController;
  late TextEditingController _namaPenerimaController;
  late TextEditingController _jabatanPenerimaController;
  late TextEditingController _namaMahasiswaController;
  late TextEditingController _nimController;
  late TextEditingController _kelasController;
  late TextEditingController _namaUnivController;
  late TextEditingController _perihalIzinController;
  late TextEditingController _izinMulaiController;
  late TextEditingController _izinSelesaiController;
  late TextEditingController _tempatTerbitController;
  late TextEditingController _tanggalTerbitController;
  late TextEditingController _uploadTTDController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.surat.nama);
    _jabatanController = TextEditingController(text: widget.surat.jabatan);
    _perusahaanController = TextEditingController(text: widget.surat.perusahaan);
    _namaPenerimaController = TextEditingController(text: widget.surat.namaPenerima);
    _jabatanPenerimaController = TextEditingController(text: widget.surat.jabatanPenerima);
    _namaMahasiswaController = TextEditingController(text: widget.surat.namaMahasiswa);
    _nimController = TextEditingController(text: widget.surat.nim);
    _kelasController = TextEditingController(text: widget.surat.kelas);
    _namaUnivController = TextEditingController(text: widget.surat.namaUniv);
    _perihalIzinController = TextEditingController(text: widget.surat.perihalIzin);
    _izinMulaiController = TextEditingController(text: widget.surat.izinMulai);
    _izinSelesaiController = TextEditingController(text: widget.surat.izinSelesai);
    _tempatTerbitController = TextEditingController(text: widget.surat.tempatTerbit);
    _tanggalTerbitController = TextEditingController(text: widget.surat.tanggalTerbit);
    _uploadTTDController = TextEditingController(text: widget.surat.uploadTTD);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _jabatanController.dispose();
    _perusahaanController.dispose();
    _namaPenerimaController.dispose();
    _jabatanPenerimaController.dispose();
    _namaMahasiswaController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    _namaUnivController.dispose();
    _perihalIzinController.dispose();
    _izinMulaiController.dispose();
    _izinSelesaiController.dispose();
    _tempatTerbitController.dispose();
    _tanggalTerbitController.dispose();
    _uploadTTDController.dispose();
    super.dispose();
  }

  Future<void> _saveSurat() async {
    if (_formKey.currentState!.validate()) {
      final updatedSurat = Surat(
        id: widget.surat.id,
        nama: _namaController.text,
        jabatan: _jabatanController.text,
        perusahaan: _perusahaanController.text,
        namaPenerima: _namaPenerimaController.text,
        jabatanPenerima: _jabatanPenerimaController.text,
        namaMahasiswa: _namaMahasiswaController.text,
        nim: _nimController.text,
        kelas: _kelasController.text,
        namaUniv: _namaUnivController.text,
        perihalIzin: _perihalIzinController.text,
        izinMulai: _izinMulaiController.text,
        izinSelesai: _izinSelesaiController.text,
        tempatTerbit: _tempatTerbitController.text,
        tanggalTerbit: _tanggalTerbitController.text,
        uploadTTD: _uploadTTDController.text,
      );

      await DatabaseHelper().updateSurat(updatedSurat);
      Navigator.pop(context, true); // Return true to indicate the edit was successful
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Surat'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jabatanController,
                decoration: InputDecoration(labelText: 'Jabatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jabatan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _perusahaanController,
                decoration: InputDecoration(labelText: 'Perusahaan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Perusahaan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaPenerimaController,
                decoration: InputDecoration(labelText: 'Nama Penerima'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter nama penerima';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jabatanPenerimaController,
                decoration: InputDecoration(labelText: 'Jabatan Penerima'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Perusahaan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaMahasiswaController,
                decoration: InputDecoration(labelText: 'Nama Mahasiswa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nama Mahasiswa';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NIM';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kelasController,
                decoration: InputDecoration(labelText: 'Kelas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Kelas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaUnivController,
                decoration: InputDecoration(labelText: 'Nama Universitas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nama Universitas';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _perihalIzinController,
                decoration: InputDecoration(labelText: 'Perihal Izin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Perihal Izin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _izinMulaiController,
                decoration: InputDecoration(labelText: 'Izin Mulai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Izin Mulai';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _izinSelesaiController,
                decoration: InputDecoration(labelText: 'Izin Selesai'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Izin Selesai';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tempatTerbitController,
                decoration: InputDecoration(labelText: 'Tempat Terbit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Tempat Terbit';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tanggalTerbitController,
                decoration: InputDecoration(labelText: 'Tanggal Terbit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Tanggal Terbit';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _uploadTTDController,
                decoration: InputDecoration(labelText: 'Upload TTD'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Upload TTD';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSurat,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
