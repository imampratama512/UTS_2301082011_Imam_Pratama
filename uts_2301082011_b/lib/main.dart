import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Peminjaman',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
class Pinjaman {
  final String kode;
  final String nama;
  final String kodePeminjaman;
  final DateTime tanggal;
  final String kodeNasabah;
  final String namaNasabah;
  final double jumlahPinjaman;
  final int lamaPinjaman;
  late final double bunga;
  late final double angsuranPokok;
  late final double angsuranPerBulan;
  late final double totalHutang;

  Pinjaman({
    required this.kode,
    required this.nama,
    required this.kodePeminjaman,
    required this.tanggal,
    required this.kodeNasabah,
    required this.namaNasabah,
    required this.jumlahPinjaman,
    required this.lamaPinjaman,
  }) {
    angsuranPokok = jumlahPinjaman / lamaPinjaman;
    bunga = jumlahPinjaman * 0.12; 
    double bungaPerBulan = bunga / lamaPinjaman;
    angsuranPerBulan = bungaPerBulan + angsuranPokok;
    totalHutang = jumlahPinjaman + bunga;
  }
  

}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Pinjaman> _pinjaman = [];
  

  final _formKey = GlobalKey<FormState>();
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _kodePeminjamanController = TextEditingController();
  final _kodeNasabahController = TextEditingController();
  final _namaNasabahController = TextEditingController();
  final _jumlahPinjamanController = TextEditingController();
  final _lamaPinjamanController = TextEditingController();

  void _tambahPinjaman() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _pinjaman.add(
          Pinjaman(
            kode: _kodeController.text,
            nama: _namaController.text,
            kodePeminjaman: _kodePeminjamanController.text,
            tanggal: DateTime.now(),
            kodeNasabah: _kodeNasabahController.text,
            namaNasabah: _namaNasabahController.text,
            jumlahPinjaman: double.parse(_jumlahPinjamanController.text),
            lamaPinjaman: int.parse(_lamaPinjamanController.text),
          ),
        );
      });
      
    
      _kodeController.clear();
      _namaController.clear();
      _kodePeminjamanController.clear();
      _kodeNasabahController.clear();
      _namaNasabahController.clear();
      _jumlahPinjamanController.clear();
      _lamaPinjamanController.clear();
      
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Peminjaman'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Aplikasi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Tambah Pinjaman'),
              onTap: () {
                Navigator.pop(context);
                _showFormDialog();
              },
            ),
            ListTile(
              title: const Text('Daftar Pinjaman'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _pinjaman.length,
        itemBuilder: (context, index) {
          final pinjaman = _pinjaman[index];
          return Card(
            child: ListTile(
              title: Text('${pinjaman.namaNasabah} - ${pinjaman.kodePeminjaman}'),
              subtitle: Text(
                'Pinjaman: Rp${pinjaman.jumlahPinjaman.toStringAsFixed(2)}\n'
                'Angsuran/bulan: Rp${pinjaman.angsuranPerBulan.toStringAsFixed(2)}',
              ),
              onTap: () => _showDetailDialog(pinjaman),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Pinjaman Baru'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _kodeController,
                  decoration: const InputDecoration(labelText: 'Kode'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi kode';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi nama';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kodePeminjamanController,
                  decoration: const InputDecoration(labelText: 'Kode Peminjaman'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi kode peminjaman';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kodeNasabahController,
                  decoration: const InputDecoration(labelText: 'Kode Nasabah'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi kode nasabah';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _namaNasabahController,
                  decoration: const InputDecoration(labelText: 'Nama Nasabah'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi nama nasabah';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _jumlahPinjamanController,
                  decoration: const InputDecoration(labelText: 'Jumlah Pinjaman'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi jumlah pinjaman';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Harap masukkan angka yang valid';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lamaPinjamanController,
                  decoration: const InputDecoration(labelText: 'Lama Pinjaman (Bulan)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap isi lama pinjaman';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harap masukkan angka yang valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: _tambahPinjaman,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(Pinjaman pinjaman) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detail Pinjaman'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kode: ${pinjaman.kode}'),
            Text('Nama: ${pinjaman.nama}'),
            Text('Kode Peminjaman: ${pinjaman.kodePeminjaman}'),
            Text('Tanggal: ${pinjaman.tanggal.toString().split(' ')[0]}'),
            Text('Kode Nasabah: ${pinjaman.kodeNasabah}'),
            Text('Nama Nasabah: ${pinjaman.namaNasabah}'),
            Text('Jumlah Pinjaman: Rp${pinjaman.jumlahPinjaman.toStringAsFixed(2)}'),
            Text('Lama Pinjaman: ${pinjaman.lamaPinjaman} bulan'),
            Text('Bunga: Rp${pinjaman.bunga.toStringAsFixed(2)}'),
            Text('Angsuran Pokok: Rp${pinjaman.angsuranPokok.toStringAsFixed(2)}'),
            Text('Angsuran per Bulan: Rp${pinjaman.angsuranPerBulan.toStringAsFixed(2)}'),
            Text('Total Hutang: Rp${pinjaman.totalHutang.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}