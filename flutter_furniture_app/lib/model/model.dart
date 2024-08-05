import 'dart:convert';

// JSON'u AppModel'e dönüştüren ve AppModel'i JSON'a dönüştüren yardımcı işlevler
AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));
String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel {
  AppModel({
    required this.searchMetadata,
    required this.searchParameters,
    required this.searchInformation,
    required this.products,
    required this.filters,
    required this.pagination,
    required this.serpapiPagination,
  });

  final SearchMetadata? searchMetadata;
  final SearchParameters? searchParameters;
  final SearchInformation? searchInformation;
  final List<Product> products;
  final List<Filter> filters;
  final Pagination? pagination;
  final Pagination? serpapiPagination;

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
    searchMetadata: json["search_metadata"] == null ? null : SearchMetadata.fromJson(json["search_metadata"]),
    searchParameters: json["search_parameters"] == null ? null : SearchParameters.fromJson(json["search_parameters"]),
    searchInformation: json["search_information"] == null ? null : SearchInformation.fromJson(json["search_information"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    filters: json["filters"] == null ? [] : List<Filter>.from(json["filters"].map((x) => Filter.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    serpapiPagination: json["serpapi_pagination"] == null ? null : Pagination.fromJson(json["serpapi_pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "search_metadata": searchMetadata?.toJson(),
    "search_parameters": searchParameters?.toJson(),
    "search_information": searchInformation?.toJson(),
    "products": products.map((x) => x.toJson()).toList(),
    "filters": filters.map((x) => x.toJson()).toList(),
    "pagination": pagination?.toJson(),
    "serpapi_pagination": serpapiPagination?.toJson(),
  };
}

class Filter {
  Filter({
    required this.key,
    required this.value,
  });

  final String? key;
  final List<Value> value;

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    key: json["key"],
    value: json["value"] == null ? [] : List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value.map((x) => x.toJson()).toList(),
  };
}

class Value {
  Value({
    required this.name,
    required this.count,
    required this.value,
    required this.link,
  });

  final String? name;
  final String? count;
  final String? value;
  final String? link;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    name: json["name"],
    count: json["count"],
    value: json["value"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "count": count,
    "value": value,
    "link": link,
  };
}

class Pagination {
  Pagination({
    required this.current,
    required this.next,
    required this.otherPages,
    required this.nextLink,
  });

  final int current;
  final String? next;
  final Map<String, String> otherPages;
  final String? nextLink;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    current: json["current"] ?? 0,
    next: json["next"],
    otherPages: json["other_pages"] == null ? {} : Map<String, String>.from(json["other_pages"]),
    nextLink: json["next_link"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "next": next,
    "other_pages": otherPages,
    "next_link": nextLink,
  };
}

class Product {
  Product({
    required this.position,
    required this.productId,
    required this.title,
    required this.thumbnails,
    required this.link,
    required this.serpapiLink,
    required this.modelNumber,
    required this.collection,
    required this.favorite,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.delivery,
    required this.pickup,
    required this.badges,
    required this.brand,
    required this.variants,
    required this.priceWas,
    required this.priceSaving,
    required this.percentageOff,
    required this.priceBadge,
    required this.unit,
  });

  final int position;
  final String? productId;
  final String? title;
  final List<List<String>> thumbnails;
  final String? link;
  final String? serpapiLink;
  final String? modelNumber;
  final String? collection;
  final int favorite;
  final double rating;
  final int reviews;
  final double price;
  final Delivery? delivery;
  final Pickup? pickup;
  final List<String> badges;
  final String? brand;
  final List<Variant> variants;
  final double priceWas;
  final double priceSaving;
  final int percentageOff;
  final String? priceBadge;
  final String? unit;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    position: json["position"] ?? 0,
    productId: json["product_id"],
    title: json["title"],
    thumbnails: json["thumbnails"] == null ? [] : List<List<String>>.from(json["thumbnails"].map((x) => List<String>.from(x))),
    link: json["link"],
    serpapiLink: json["serpapi_link"],
    modelNumber: json["model_number"],
    collection: json["collection"],
    favorite: json["favorite"] ?? 0,
    rating: (json["rating"] is int ? (json["rating"] as int).toDouble() : (json["rating"] as double?) ?? 0.0),
    reviews: json["reviews"] ?? 0,
    price: (json["price"] is int ? (json["price"] as int).toDouble() : (json["price"] as double?) ?? 0.0),
    delivery: json["delivery"] == null ? null : Delivery.fromJson(json["delivery"]),
    pickup: json["pickup"] == null ? null : Pickup.fromJson(json["pickup"]),
    badges: json["badges"] == null ? [] : List<String>.from(json["badges"]),
    brand: json["brand"],
    variants: json["variants"] == null ? [] : List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    priceWas: (json["price_was"] is int ? (json["price_was"] as int).toDouble() : (json["price_was"] as double?) ?? 0.0),
    priceSaving: (json["price_saving"] is int ? (json["price_saving"] as int).toDouble() : (json["price_saving"] as double?) ?? 0.0),
    percentageOff: json["percentage_off"] ?? 0,
    priceBadge: json["price_badge"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "product_id": productId,
    "title": title,
    "thumbnails": thumbnails.map((x) => x.toList()).toList(),
    "link": link,
    "serpapi_link": serpapiLink,
    "model_number": modelNumber,
    "collection": collection,
    "favorite": favorite,
    "rating": rating,
    "reviews": reviews,
    "price": price,
    "delivery": delivery?.toJson(),
    "pickup": pickup?.toJson(),
    "badges": badges,
    "brand": brand,
    "variants": variants.map((x) => x.toJson()).toList(),
    "price_was": priceWas,
    "price_saving": priceSaving,
    "percentage_off": percentageOff,
    "price_badge": priceBadge,
    "unit": unit,
  };
}

class Delivery {
  Delivery({
    required this.scheduleDelivery,
    required this.free,
    required this.freeDeliveryThreshold,
  });

  final bool? scheduleDelivery;
  final bool? free;
  final bool? freeDeliveryThreshold;

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    scheduleDelivery: json["schedule_delivery"],
    free: json["free"],
    freeDeliveryThreshold: json["free_delivery_threshold"],
  );

  Map<String, dynamic> toJson() => {
    "schedule_delivery": scheduleDelivery,
    "free": free,
    "free_delivery_threshold": freeDeliveryThreshold,
  };
}

class Pickup {
  Pickup({
    required this.quantity,
    required this.storeName,
    required this.distance,
    required this.freeShipToStore,
  });

  final int? quantity;
  final String? storeName;
  final int? distance;
  final bool? freeShipToStore;

  factory Pickup.fromJson(Map<String, dynamic> json) => Pickup(
    quantity: json["quantity"] ?? 0,
    storeName: json["store_name"],
    distance: json["distance"] ?? 0,
    freeShipToStore: json["free_ship_to_store"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "store_name": storeName,
    "distance": distance,
    "free_ship_to_store": freeShipToStore,
  };
}

class SearchMetadata {
  SearchMetadata({
    required this.id,
    required this.status,
    required this.json,
  });

  final String? id;
  final String? status;
  final String? json;

  factory SearchMetadata.fromJson(Map<String, dynamic> json) => SearchMetadata(
    id: json["id"],
    status: json["status"],
    json: json["json"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "json": json,
  };
}

class SearchParameters {
  SearchParameters({
    required this.q,
    required this.start,
    required this.num,
    required this.p,
  });

  final String? q;
  final int? start;
  final int? num;
  final String? p;

  factory SearchParameters.fromJson(Map<String, dynamic> json) => SearchParameters(
    q: json["q"],
    start: json["start"] ?? 0,
    num: json["num"] ?? 0,
    p: json["p"],
  );

  Map<String, dynamic> toJson() => {
    "q": q,
    "start": start,
    "num": num,
    "p": p,
  };
}

class SearchInformation {
  SearchInformation({
    required this.totalResults,
    required this.searchTime,
  });

  final int? totalResults;
  final double? searchTime;

  factory SearchInformation.fromJson(Map<String, dynamic> json) => SearchInformation(
    totalResults: json["total_results"] ?? 0,
    searchTime: (json["search_time"] is int ? (json["search_time"] as int).toDouble() : (json["search_time"] as double?) ?? 0.0),
  );

  Map<String, dynamic> toJson() => {
    "total_results": totalResults,
    "search_time": searchTime,
  };
}

class Variant {
  Variant({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
  });

  final String? id;
  final String? title;
  final double price;
  final int stock;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    title: json["title"],
    price: (json["price"] is int ? (json["price"] as int).toDouble() : (json["price"] as double?) ?? 0.0),
    stock: json["stock"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "stock": stock,
  };
}