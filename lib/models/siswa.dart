class Siswa {
  final String id;
  final String nisn;
  final String namaLengkap;
  final String jenisKelamin;
  final String agama;
  final String tempatLahir;
  final DateTime tanggalLahir;
  final String noHp;
  final String nik;
  final Alamat alamat;
  final OrangTua orangTua;

  Siswa({
    required this.id,
    required this.nisn,
    required this.namaLengkap,
    required this.jenisKelamin,
    required this.agama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.noHp,
    required this.nik,
    required this.alamat,
    required this.orangTua,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nisn': nisn,
      'namaLengkap': namaLengkap,
      'jenisKelamin': jenisKelamin,
      'agama': agama,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir.toIso8601String(),
      'noHp': noHp,
      'nik': nik,
      'alamat': alamat.toJson(),
      'orangTua': orangTua.toJson(),
    };
  }

  factory Siswa.fromJson(Map<String, dynamic> json) {
    return Siswa(
      id: json['id'],
      nisn: json['nisn'],
      namaLengkap: json['namaLengkap'],
      jenisKelamin: json['jenisKelamin'],
      agama: json['agama'],
      tempatLahir: json['tempatLahir'],
      tanggalLahir: DateTime.parse(json['tanggalLahir']),
      noHp: json['noHp'],
      nik: json['nik'],
      alamat: Alamat.fromJson(json['alamat']),
      orangTua: OrangTua.fromJson(json['orangTua']),
    );
  }

  Siswa copyWith({
    String? id,
    String? nisn,
    String? namaLengkap,
    String? jenisKelamin,
    String? agama,
    String? tempatLahir,
    DateTime? tanggalLahir,
    String? noHp,
    String? nik,
    Alamat? alamat,
    OrangTua? orangTua,
  }) {
    return Siswa(
      id: id ?? this.id,
      nisn: nisn ?? this.nisn,
      namaLengkap: namaLengkap ?? this.namaLengkap,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      agama: agama ?? this.agama,
      tempatLahir: tempatLahir ?? this.tempatLahir,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      noHp: noHp ?? this.noHp,
      nik: nik ?? this.nik,
      alamat: alamat ?? this.alamat,
      orangTua: orangTua ?? this.orangTua,
    );
  }
}

class Alamat {
  final String jalan;
  final String rtRw;
  final String dusun;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;
  final String kodePos;

  Alamat({
    required this.jalan,
    required this.rtRw,
    required this.dusun,
    required this.desa,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
    required this.kodePos,
  });

  Map<String, dynamic> toJson() {
    return {
      'jalan': jalan,
      'rtRw': rtRw,
      'dusun': dusun,
      'desa': desa,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
      'provinsi': provinsi,
      'kodePos': kodePos,
    };
  }

  factory Alamat.fromJson(Map<String, dynamic> json) {
    return Alamat(
      jalan: json['jalan'],
      rtRw: json['rtRw'],
      dusun: json['dusun'],
      desa: json['desa'],
      kecamatan: json['kecamatan'],
      kabupaten: json['kabupaten'],
      provinsi: json['provinsi'],
      kodePos: json['kodePos'],
    );
  }

  Alamat copyWith({
    String? jalan,
    String? rtRw,
    String? dusun,
    String? desa,
    String? kecamatan,
    String? kabupaten,
    String? provinsi,
    String? kodePos,
  }) {
    return Alamat(
      jalan: jalan ?? this.jalan,
      rtRw: rtRw ?? this.rtRw,
      dusun: dusun ?? this.dusun,
      desa: desa ?? this.desa,
      kecamatan: kecamatan ?? this.kecamatan,
      kabupaten: kabupaten ?? this.kabupaten,
      provinsi: provinsi ?? this.provinsi,
      kodePos: kodePos ?? this.kodePos,
    );
  }
}

class OrangTua {
  final String namaAyah;
  final String namaIbu;
  final String namaWali;
  final String alamatWali;

  OrangTua({
    required this.namaAyah,
    required this.namaIbu,
    required this.namaWali,
    required this.alamatWali,
  });

  Map<String, dynamic> toJson() {
    return {
      'namaAyah': namaAyah,
      'namaIbu': namaIbu,
      'namaWali': namaWali,
      'alamatWali': alamatWali,
    };
  }

  factory OrangTua.fromJson(Map<String, dynamic> json) {
    return OrangTua(
      namaAyah: json['namaAyah'],
      namaIbu: json['namaIbu'],
      namaWali: json['namaWali'],
      alamatWali: json['alamatWali'],
    );
  }

  OrangTua copyWith({
    String? namaAyah,
    String? namaIbu,
    String? namaWali,
    String? alamatWali,
  }) {
    return OrangTua(
      namaAyah: namaAyah ?? this.namaAyah,
      namaIbu: namaIbu ?? this.namaIbu,
      namaWali: namaWali ?? this.namaWali,
      alamatWali: alamatWali ?? this.alamatWali,
    );
  }
}

