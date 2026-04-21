/// Model representing a collection of countries, states, and cities.
class AurumCountryStateCityModel {
  AurumCountryStateCityModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory AurumCountryStateCityModel.fromJson(Map<String, dynamic> json) {
    return AurumCountryStateCityModel(
      status: json["status"] as bool?,
      statusCode: json["statusCode"] as num?,
      message: json["message"] as String?,
      data: json["data"] != null
          ? (json["data"] as List<dynamic>)
              .map((v) => AurumCountry.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final bool? status;
  final num? statusCode;
  final String? message;
  final List<AurumCountry>? data;

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "statusCode": statusCode,
      "message": message,
      "data": data?.map((v) => v.toJson()).toList(),
    };
  }
}

/// Represents a Country with nested states.
class AurumCountry {
  AurumCountry({
    this.id,
    this.countryCode,
    this.name,
    this.states,
  });

  factory AurumCountry.fromJson(Map<String, dynamic> json) {
    return AurumCountry(
      id: json["id"] as num?,
      countryCode: json["countryCode"] as String?,
      name: json["name"] as String?,
      states: json["states"] != null
          ? (json["states"] as List<dynamic>)
              .map((v) => AurumState.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final num? id;
  final String? countryCode;
  final String? name;
  final List<AurumState>? states;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "countryCode": countryCode,
      "name": name,
      "states": states?.map((v) => v.toJson()).toList(),
    };
  }
}

/// Represents a State with nested cities.
class AurumState {
  AurumState({
    this.id,
    this.name,
    this.stateCode,
    this.cities,
  });

  factory AurumState.fromJson(Map<String, dynamic> json) {
    return AurumState(
      id: json["id"] as num?,
      name: json["name"] as String?,
      stateCode: json["stateCode"] as String?,
      cities: json["cities"] != null
          ? (json["cities"] as List<dynamic>)
              .map((v) => AurumCity.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  final num? id;
  final String? name;
  final String? stateCode;
  final List<AurumCity>? cities;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "stateCode": stateCode,
      "cities": cities?.map((v) => v.toJson()).toList(),
    };
  }
}

/// Represents a City.
class AurumCity {
  AurumCity({
    this.id,
    this.name,
  });

  factory AurumCity.fromJson(Map<String, dynamic> json) {
    return AurumCity(
      id: json["id"] as num?,
      name: json["name"] as String?,
    );
  }

  final num? id;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

/// Response model for pincode details.
class AurumPinCodeModel {
  AurumPinCodeModel({this.status, this.statusCode, this.message, this.data});

  factory AurumPinCodeModel.fromJson(Map<String, dynamic> json) {
    return AurumPinCodeModel(
      status: json["status"] as bool?,
      statusCode: json["statusCode"] as num?,
      message: json["message"] as String?,
      data: json["data"] != null ? AurumPinCodeData.fromJson(json["data"] as Map<String, dynamic>) : null,
    );
  }

  final bool? status;
  final num? statusCode;
  final String? message;
  final AurumPinCodeData? data;

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "statusCode": statusCode,
      "message": message,
      "data": data?.toJson(),
    };
  }
}

/// Detailed location data for a specific pincode.
class AurumPinCodeData {
  AurumPinCodeData({
    this.pinCode,
    this.district,
    this.taluka,
    this.area,
    this.areaList,
    this.stateName,
    this.countryName,
    this.stateId,
    this.countryId,
  });

  factory AurumPinCodeData.fromJson(Map<String, dynamic> json) {
    return AurumPinCodeData(
      pinCode: json["pinCode"]?.toString(),
      district: json["district"] as String?,
      taluka: json["taluka"] as String?,
      area: json["area"] as String?,
      areaList: json["areaList"] != null
          ? (json["areaList"] as List<dynamic>)
              .map((v) => AurumAreaData.fromJson(v as Map<String, dynamic>))
              .toList()
          : null,
      stateName: json["stateName"] as String?,
      countryName: json["countryName"] as String?,
      stateId: json["stateId"] as num?,
      countryId: json["countryId"] as num?,
    );
  }

  final String? pinCode;
  final String? district;
  final String? taluka;
  final String? area;
  final List<AurumAreaData>? areaList;
  final String? stateName;
  final String? countryName;
  final num? stateId;
  final num? countryId;

  Map<String, dynamic> toJson() {
    return {
      "pinCode": pinCode,
      "district": district,
      "taluka": taluka,
      "area": area,
      "areaList": areaList?.map((v) => v.toJson()).toList(),
      "stateName": stateName,
      "countryName": countryName,
      "stateId": stateId,
      "countryId": countryId,
    };
  }
}

/// Represents a specific area/locality.
class AurumAreaData {
  AurumAreaData({
    this.name,
    this.block,
    this.district,
    this.pincode,
  });

  factory AurumAreaData.fromJson(Map<String, dynamic> json) {
    return AurumAreaData(
      name: json["Name"] as String?,
      block: json["Block"] as String?,
      district: json["District"] as String?,
      pincode: json["Pincode"] as String?,
    );
  }

  final String? name;
  final String? block;
  final String? district;
  final String? pincode;

  Map<String, dynamic> toJson() {
    return {
      "Name": name,
      "Block": block,
      "District": district,
      "Pincode": pincode,
    };
  }
}
