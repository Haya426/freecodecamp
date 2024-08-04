class CountryDetailModel {
  CountryDetailModel({
    this.flags,
    this.name,
    this.capital,
    this.region,
    this.subregion,
    this.population,
  });

  CountryDetailModel.fromJson(dynamic json) {
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    capital = json['capital'] != null ? json['capital'].cast<String>() : [];
    region = json['region'];
    subregion = json['subregion'];
    population = json['population'];
  }

  Flags? flags;
  Name? name;
  List<String>? capital;
  String? region;
  String? subregion;
  num? population;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (flags != null) {
      map['flags'] = flags?.toJson();
    }
    if (name != null) {
      map['name'] = name?.toJson();
    }
    map['capital'] = capital;
    map['region'] = region;
    map['subregion'] = subregion;
    map['population'] = population;
    return map;
  }
}

class Name {
  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  Name.fromJson(dynamic json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  String? common;
  String? official;
  NativeName? nativeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['common'] = common;
    map['official'] = official;
    if (nativeName != null) {
      map['nativeName'] = nativeName?.toJson();
    }
    return map;
  }
}

class NativeName {
  NativeName({
    this.mya,
  });

  NativeName.fromJson(dynamic json) {
    mya = json['mya'] != null ? Mya.fromJson(json['mya']) : null;
  }

  Mya? mya;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mya != null) {
      map['mya'] = mya?.toJson();
    }
    return map;
  }
}

class Mya {
  Mya({
    this.official,
    this.common,
  });

  Mya.fromJson(dynamic json) {
    official = json['official'];
    common = json['common'];
  }

  String? official;
  String? common;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['official'] = official;
    map['common'] = common;
    return map;
  }
}

class Flags {
  Flags({
    this.png,
    this.svg,
    this.alt,
  });

  Flags.fromJson(dynamic json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }

  String? png;
  String? svg;
  String? alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['png'] = png;
    map['svg'] = svg;
    map['alt'] = alt;
    return map;
  }
}