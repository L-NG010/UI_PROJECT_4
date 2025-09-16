import 'package:flutter/material.dart';
import '../models/siswa.dart'; 

class SiswaCrudPage extends StatefulWidget {
  @override
  _SiswaCrudPageState createState() => _SiswaCrudPageState();
}

class _SiswaCrudPageState extends State<SiswaCrudPage> {
  List<Siswa> siswaList = [];
  List<Siswa> filteredSiswaList = [];
  TextEditingController searchController = TextEditingController();
  bool isFormVisible = false;
  Siswa? editingSiswa;

  // Form Controllers
  final formKey = GlobalKey<FormState>();
  final nisnController = TextEditingController();
  final namaLengkapController = TextEditingController();
  final jenisKelaminController = TextEditingController();
  final agamaController = TextEditingController();
  final tempatLahirController = TextEditingController();
  final tanggalLahirController = TextEditingController();
  final noHpController = TextEditingController();
  final nikController = TextEditingController();
  
  // Alamat Controllers
  final jalanController = TextEditingController();
  final rtRwController = TextEditingController();
  final dusunController = TextEditingController();
  final desaController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kabupatenController = TextEditingController();
  final provinsiController = TextEditingController();
  final kodePosController = TextEditingController();
  
  // Orang Tua Controllers
  final namaAyahController = TextEditingController();
  final namaIbuController = TextEditingController();
  final namaWaliController = TextEditingController();
  final alamatWaliController = TextEditingController();

  DateTime? selectedDate;
  String? selectedJenisKelamin;
  String? selectedAgama;

  @override
  void initState() {
    super.initState();
    filteredSiswaList = siswaList;
    searchController.addListener(_filterSiswa);
  }

  void _filterSiswa() {
    setState(() {
      filteredSiswaList = siswaList.where((siswa) {
        return siswa.namaLengkap.toLowerCase().contains(searchController.text.toLowerCase()) ||
               siswa.nisn.contains(searchController.text);
      }).toList();
    });
  }

  void _resetForm() {
    nisnController.clear();
    namaLengkapController.clear();
    tempatLahirController.clear();
    noHpController.clear();
    nikController.clear();
    jalanController.clear();
    rtRwController.clear();
    dusunController.clear();
    desaController.clear();
    kecamatanController.clear();
    kabupatenController.clear();
    provinsiController.clear();
    kodePosController.clear();
    namaAyahController.clear();
    namaIbuController.clear();
    namaWaliController.clear();
    alamatWaliController.clear();
    
    selectedDate = null;
    selectedJenisKelamin = null;
    selectedAgama = null;
    editingSiswa = null;
  }

  void _fillForm(Siswa siswa) {
    nisnController.text = siswa.nisn;
    namaLengkapController.text = siswa.namaLengkap;
    selectedJenisKelamin = siswa.jenisKelamin;
    selectedAgama = siswa.agama;
    tempatLahirController.text = siswa.tempatLahir;
    selectedDate = siswa.tanggalLahir;
    noHpController.text = siswa.noHp;
    nikController.text = siswa.nik;
    
    jalanController.text = siswa.alamat.jalan;
    rtRwController.text = siswa.alamat.rtRw;
    dusunController.text = siswa.alamat.dusun;
    desaController.text = siswa.alamat.desa;
    kecamatanController.text = siswa.alamat.kecamatan;
    kabupatenController.text = siswa.alamat.kabupaten;
    provinsiController.text = siswa.alamat.provinsi;
    kodePosController.text = siswa.alamat.kodePos;
    
    namaAyahController.text = siswa.orangTua.namaAyah;
    namaIbuController.text = siswa.orangTua.namaIbu;
    namaWaliController.text = siswa.orangTua.namaWali;
    alamatWaliController.text = siswa.orangTua.alamatWali;
  }

  void _submitForm() {
    if (formKey.currentState!.validate() && selectedDate != null) {
      final alamat = Alamat(
        jalan: jalanController.text,
        rtRw: rtRwController.text,
        dusun: dusunController.text,
        desa: desaController.text,
        kecamatan: kecamatanController.text,
        kabupaten: kabupatenController.text,
        provinsi: provinsiController.text,
        kodePos: kodePosController.text,
      );

      final orangTua = OrangTua(
        namaAyah: namaAyahController.text,
        namaIbu: namaIbuController.text,
        namaWali: namaWaliController.text,
        alamatWali: alamatWaliController.text,
      );

      final siswa = Siswa(
        id: editingSiswa?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        nisn: nisnController.text,
        namaLengkap: namaLengkapController.text,
        jenisKelamin: selectedJenisKelamin!,
        agama: selectedAgama!,
        tempatLahir: tempatLahirController.text,
        tanggalLahir: selectedDate!,
        noHp: noHpController.text,
        nik: nikController.text,
        alamat: alamat,
        orangTua: orangTua,
      );

      setState(() {
        if (editingSiswa != null) {
          int index = siswaList.indexWhere((s) => s.id == editingSiswa!.id);
          siswaList[index] = siswa;
        } else {
          siswaList.add(siswa);
        }
        isFormVisible = false;
        _resetForm();
        _filterSiswa();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(editingSiswa != null ? 'Data siswa berhasil diupdate!' : 'Data siswa berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _editSiswa(Siswa siswa) {
    setState(() {
      editingSiswa = siswa;
      isFormVisible = true;
    });
    _fillForm(siswa);
  }

  void _deleteSiswa(Siswa siswa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus data ${siswa.namaLengkap}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                siswaList.removeWhere((s) => s.id == siswa.id);
                _filterSiswa();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Data siswa berhasil dihapus!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: Column(
              children: [
                // Header
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Data Siswa',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Kelola data siswa dengan mudah',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isFormVisible = true;
                              _resetForm();
                            });
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Tambah Siswa', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Data List/Form
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: isFormVisible ? _buildForm() : _buildDataList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Form Header
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  editingSiswa != null ? 'Edit Data Siswa' : 'Tambah Data Siswa',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFormVisible = false;
                      _resetForm();
                    });
                  },
                  icon: Icon(Icons.close, color: Colors.grey[400]),
                ),
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Data Pribadi Section
                    _buildSectionHeader('Data Pribadi', Icons.person, Colors.blue[600]!),
                    SizedBox(height: 16),
                    _buildFormGrid([
                      _buildTextFormField('NISN', nisnController, required: true),
                      _buildTextFormField('Nama Lengkap', namaLengkapController, required: true),
                      _buildDropdownFormField(
                        'Jenis Kelamin',
                        selectedJenisKelamin,
                        ['Laki-laki', 'Perempuan'],
                        (value) => setState(() => selectedJenisKelamin = value),
                        required: true,
                      ),
                      _buildDropdownFormField(
                        'Agama',
                        selectedAgama,
                        ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'],
                        (value) => setState(() => selectedAgama = value),
                        required: true,
                      ),
                      _buildTextFormField('Tempat Lahir', tempatLahirController, required: true),
                      _buildDateFormField(),
                      _buildTextFormField('No HP', noHpController, required: true),
                      _buildTextFormField('NIK', nikController, required: true),
                    ]),

                    SizedBox(height: 32),

                    // Alamat Section
                    _buildSectionHeader('Alamat', Icons.location_on, Colors.green[600]!),
                    SizedBox(height: 16),
                    _buildFormGrid([
                      _buildTextFormField('Jalan', jalanController, required: true, fullWidth: true),
                      _buildTextFormField('RT/RW', rtRwController, required: true),
                      _buildTextFormField('Dusun', dusunController),
                      _buildTextFormField('Desa', desaController, required: true),
                      _buildTextFormField('Kecamatan', kecamatanController, required: true),
                      _buildTextFormField('Kabupaten', kabupatenController, required: true),
                      _buildTextFormField('Provinsi', provinsiController, required: true),
                      _buildTextFormField('Kode Pos', kodePosController, required: true),
                    ]),

                    SizedBox(height: 32),

                    // Orang Tua Section
                    _buildSectionHeader('Data Orang Tua/Wali', Icons.people, Colors.purple[600]!),
                    SizedBox(height: 16),
                    _buildFormGrid([
                      _buildTextFormField('Nama Ayah', namaAyahController, required: true),
                      _buildTextFormField('Nama Ibu', namaIbuController, required: true),
                      _buildTextFormField('Nama Wali', namaWaliController),
                      _buildTextFormField('Alamat Wali', alamatWaliController),
                    ]),

                    SizedBox(height: 32),

                    // Form Actions
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey[200]!)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isFormVisible = false;
                                _resetForm();
                              });
                            },
                            child: Text('Batal'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
                          SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _submitForm,
                            icon: Icon(Icons.save, color: Colors.white),
                            label: Text(
                              editingSiswa != null ? 'Update' : 'Simpan',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataList() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: filteredSiswaList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 64, color: Colors.grey[400]),
                    SizedBox(height: 16),
                    Text(
                      searchController.text.isNotEmpty
                          ? 'Tidak ada data siswa yang ditemukan'
                          : 'Belum ada data siswa',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 32,
                  headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
                  columns: [
                    DataColumn(
                      label: Text('NISN', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Nama Lengkap', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Tempat Lahir', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('No HP', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    DataColumn(
                      label: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                  rows: filteredSiswaList.map((siswa) {
                    return DataRow(
                      cells: [
                        DataCell(Text(siswa.nisn, style: TextStyle(fontWeight: FontWeight.w500))),
                        DataCell(Text(siswa.namaLengkap)),
                        DataCell(Text(siswa.jenisKelamin)),
                        DataCell(Text(siswa.tempatLahir)),
                        DataCell(Text(siswa.noHp)),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Tooltip(
                                message: 'Edit',
                                child: IconButton(
                                  onPressed: () => _editSiswa(siswa),
                                  icon: Icon(Icons.edit, color: Colors.blue[600]),
                                ),
                              ),
                              Tooltip(
                                message: 'Hapus',
                                child: IconButton(
                                  onPressed: () => _deleteSiswa(siswa),
                                  icon: Icon(Icons.delete, color: Colors.red[600]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color, size: 20),
            radius: 16,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormGrid(List<Widget> children) {
    return Wrap(
      spacing: 18,
      runSpacing: 18,
      children: children,
    );
  }

  Widget _buildTextFormField(
    String label,
    TextEditingController controller, {
    bool required = false,
    bool fullWidth = false,
  }) {
    return SizedBox(
      width: fullWidth ? double.infinity : 320,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label wajib diisi';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDropdownFormField(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged, {
    bool required = false,
  }) {
    return SizedBox(
      width: 320,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return '$label wajib dipilih';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildDateFormField() {
    return SizedBox(
      width: 320,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: 'Tanggal Lahir *',
          hintText: selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : 'Pilih tanggal lahir',
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) {
            setState(() {
              selectedDate = date;
            });
          }
        },
        validator: (value) {
          if (selectedDate == null) {
            return 'Tanggal lahir wajib dipilih';
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    nisnController.dispose();
    namaLengkapController.dispose();
    tempatLahirController.dispose();
    noHpController.dispose();
    nikController.dispose();
    jalanController.dispose();
    rtRwController.dispose();
    dusunController.dispose();
    desaController.dispose();
    kecamatanController.dispose();
    kabupatenController.dispose();
    provinsiController.dispose();
    kodePosController.dispose();
    namaAyahController.dispose();
    namaIbuController.dispose();
    namaWaliController.dispose();
    alamatWaliController.dispose();
    super.dispose();
  }
}