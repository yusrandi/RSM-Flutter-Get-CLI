class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const domain = "http://192.168.8.101/rsm-laravel/public";
  // static const baseURL = domain + "/public/api";
  // static const imageURL = "$domain/public/storage/product_photos_thumb";
  // static const imageUserURL = "$domain/public/storage/user_photos_thumb";

  // static const domain = "https://rsm.lp2muniprima.ac.id";
  static const baseURL = domain + "/api";
  static const imageURL = "$domain/storage/product_photos_thumb";
  static const imageUserURL = "$domain/storage/user_photos_thumb";

  String getKabupatens = "$baseURL/kabupaten";
  String getCabangProducts = "$baseURL/cabang-product";
  String getUser = "$baseURL/user";
  String loginUser = "$baseURL/user/login";
  String sale = "$baseURL/sales";
  String absen = "$baseURL/absen";
  String kategoriUrl = "$baseURL/kategori";
}
