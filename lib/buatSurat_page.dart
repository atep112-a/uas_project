import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uas_project/Datepicker.dart';
import 'db/database_helper.dart';
import 'models/surat.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;

  const TextFieldItem({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
      ),
    );
  }
}

class ScreenIzinOrtu extends StatefulWidget {
  const ScreenIzinOrtu({Key? key}) : super(key: key);

  @override
  State<ScreenIzinOrtu> createState() => _ScreenIzinOrtuState();
}

class _ScreenIzinOrtuState extends State<ScreenIzinOrtu> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  var nama = TextEditingController();
  var jabatan = TextEditingController();
  var perusahaan = TextEditingController();
  var namaPenerima = TextEditingController();
  var jabatanPenerima = TextEditingController();
  var namaMahasiswa = TextEditingController();
  var nim = TextEditingController();
  var kelas = TextEditingController();
  var namaUniv = TextEditingController();
  var perihalIzin = TextEditingController();
  var izinMulai = TextEditingController();
  var izinSelesai = TextEditingController();
  var tempatTerbit = TextEditingController();
  var tanggalTerbit = TextEditingController();
  var uploadTTD = TextEditingController();

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 5 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Future<void> _saveData() async {
  if (_formKey.currentState!.validate()) {
    Surat newSurat = Surat(
      nama: nama.text,
      jabatan: jabatan.text,
      perusahaan: perusahaan.text,
      namaPenerima: namaPenerima.text,
      jabatanPenerima: jabatanPenerima.text,
      namaMahasiswa: namaMahasiswa.text,
      nim: nim.text,
      kelas: kelas.text,
      namaUniv: namaUniv.text,
      perihalIzin: perihalIzin.text,
      izinMulai: izinMulai.text,
      izinSelesai: izinSelesai.text,
      tempatTerbit: tempatTerbit.text,
      tanggalTerbit: tanggalTerbit.text,
      uploadTTD: uploadTTD.text,
    );
    await DatabaseHelper().insertSurat(newSurat);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: const Text('Surat Izin Mahasiswa', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              children: [
                Stepper(
                  type: StepperType.vertical,
                  currentStep: _currentStep,
                  physics: const ScrollPhysics(),
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: const Text('Data Pembuat Surat'),
                      content: Column(
                        children: [
                          TextFieldItem(controller: nama, hintText: 'John Wick', label: 'Nama Lengkap'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: jabatan, hintText: 'Penanggung Jawab Kegiatan', label: 'Jabatan'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: perusahaan, hintText: 'Microsoft Corp', label: 'Perusahaan/Instansi/Organisasi'),
                          const SizedBox(height: 5),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Data Penerima Surat'),
                      content: Column(
                        children: [
                          TextFieldItem(controller: namaPenerima, hintText: 'John Wick', label: 'Nama Penerima'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: jabatanPenerima, hintText: 'Penanggung Jawab Kegiatan', label: 'Jabatan Penerima'),
                          const SizedBox(height: 5),
                         
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Data Mahasiswa'),
                      content: Column(
                        children: [
                          TextFieldItem(controller: namaMahasiswa, hintText: 'Cris Jhon', label: 'Nama Lengkap'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: nim, hintText: '341231231', label: 'Nomor Induk Mahasiswa'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: kelas, hintText: 'MI22B', label: 'Kelas'),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: namaUniv, hintText: 'Politeknik Negeri Saranjana', label: 'Nama Perguruan Tinggi'),
                          const SizedBox(height: 5),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 3 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Perihal Izin'),
                      content: Column(
                        children: [
                          TextFieldItem(controller: perihalIzin, hintText: 'Mengikuti Volunteer', label: 'Perihal Izin'),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 4 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Waktu dan Tempat'),
                      content: Column(
                        children: [
                          DatePicker(controller: izinMulai, label: 'Izin dari mulai', hintText: DateTime.now().toString()),
                          const SizedBox(height: 5),
                          DatePicker(controller: izinSelesai, label: 'Sampai', hintText: DateTime.now().toString()),
                          const SizedBox(height: 5),
                          TextFieldItem(controller: tempatTerbit, hintText: 'Jawa Tengah', label: 'Tempat Diterbitkan Surat'),
                          const SizedBox(height: 5),
                          DatePicker(controller: tanggalTerbit, label: 'Tanggal Terbit Surat', hintText: DateTime.now().toString()),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 5 ? StepState.complete : StepState.disabled,
                    ),
                    Step(
                      title: const Text('Upload Tanda Tangan'),
                      content: Column(
                        children: [
                          ImagePickerField(controller: uploadTTD, label: 'Upload Tanda Tangan'),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 6 ? StepState.complete : StepState.disabled,
                    ),
                  ],
                ),
               ElevatedButton(
                    onPressed: () async {
                      await _saveData();
                      Navigator.pop(context); // Kembali ke halaman sebelumnya setelah menyimpan data
                    },
                    child: const Text('Simpan'),
                  )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImagePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const ImagePickerField({Key? key, required this.controller, required this.label}) : super(key: key);

  @override
  _ImagePickerFieldState createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      widget.controller.text = image.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'No file selected',
            suffixIcon: IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: _pickImage,
            ),
          ),
        ),
      ],
    );
  }
}
