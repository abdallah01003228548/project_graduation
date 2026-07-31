class ApiConstants {
  static const String serverUrl =
      'https://supermarket-dan1.onrender.com';

  static const String baseUrl ='$serverUrl/api/v1';

  static const String register = '/auth/signUp';
  static const String login = '/auth/signIn';

  static const String productsFilter =
      '/home/productsFilter';

  static const String getProfile ='/portfoilo/userData';
  static const String updateProfile ='/portfoilo/editUserData';
  static const String addImage ='/portfoilo/addImage';

  static const String getCart ='/user/getCart';
  static const String addCart ='/user/addCart';
  static const String deleteCart ='/user/deleteCart';

  static const getFavourite = '/user/getFavorite';
  static const addFavourite = '/user/addFavorite';
  static const deleteFavourite = '/user/deleteFavorite';
}
