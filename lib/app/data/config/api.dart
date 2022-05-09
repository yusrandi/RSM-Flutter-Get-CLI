class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  static const domain = "http://192.168.10.166/rsm-laravel";
  static const baseURL = domain + "/public/api";
  static const imageURL = "$domain/public/storage/product_photos_thumb";
  static const imageUserURL = "$domain/public/storage/user_photos_thumb";

  // static const domain = "https://maiwabreedingcenter.com";
  // static const baseURL = domain + "/api";
  // static const imageURL = "$domain/storage/photos_thumb";

  String getKabupatens = "$baseURL/kabupaten";
  String getCabangProducts = "$baseURL/cabang-product";
  String getUser = "$baseURL/user";
}
