import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:uas_project/generate_letter_page.dart';
import 'buatSurat_page.dart';
import 'db/database_helper.dart';
import 'models/surat.dart';
import 'editSurat_page.dart';
// import 'pdf_generator.dart'; // Import the PDF generator

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Surat>> futureSuratList;

  @override
  void initState() {
    super.initState();
    futureSuratList = DatabaseHelper().getSuratList();
    print("Fetching surat list");
  }

  void _refreshSuratList() {
    setState(() {
      futureSuratList = DatabaseHelper().getSuratList();
      print("Surat list refreshed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: FutureBuilder<List<Surat>>(
        future: futureSuratList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Error fetching surat list: ${snapshot.error}");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print("No data available");
            return Center(child: Text('No data available'));
          } else {
            List<Surat> suratList = snapshot.data!;
            print("Surat list fetched: $suratList");
            return ListView.builder(
              itemCount: suratList.length,
              itemBuilder: (context, index) {
                Surat surat = suratList[index];
                return ListTile(
                  title: Text(surat.namaMahasiswa), // Tampilkan nama mahasiswa atau data lain yang diinginkan
                  subtitle: Text(surat.perihalIzin),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditSuratPage(surat: surat),
                            ),
                          );
                          if (result == true) {
                            _refreshSuratList(); // Refresh list after editing
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await DatabaseHelper().deleteSurat(surat.id!);
                          _refreshSuratList();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.file_copy),
                        onPressed: () async {
                          final pdfData = await generateSuratPdf(surat);
                          await Printing.layoutPdf(onLayout: (format) => pdfData);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScreenIzinOrtu()),
          );
          _refreshSuratList();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
