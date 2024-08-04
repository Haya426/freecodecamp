class CountryListModel {
  CountryListModel({
      this.flags, 
      this.name, 
      this.region,});

  CountryListModel.fromJson(dynamic json) {
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    region = json['region'];
  }
  Flags? flags;
  Name? name;
  String? region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (flags != null) {
      map['flags'] = flags?.toJson();
    }
    if (name != null) {
      map['name'] = name?.toJson();
    }
    map['region'] = region;
    return map;
  }

}

class Name {
  Name({
      this.common, 
      this.official, 
      this.nativeName,});

  Name.fromJson(dynamic json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null ? NativeName.fromJson(json['nativeName']) : null;
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
      this.ron,});

  NativeName.fromJson(dynamic json) {
    ron = json['ron'] != null ? Ron.fromJson(json['ron']) : null;
  }
  Ron? ron;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ron != null) {
      map['ron'] = ron?.toJson();
    }
    return map;
  }

}

class Ron {
  Ron({
      this.official, 
      this.common,});

  Ron.fromJson(dynamic json) {
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
      this.alt,});

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