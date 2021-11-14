class ApiGateway {
  // Tour
  static const getAllTour = 'tour/getAllTour';
  static const getOneTour = 'tour/getOneTour';
  static const findTourByName = 'tour/findTourByName';
  static const findTourByCategory = 'tour/findTourByCategory';
  static const findAllTourByCategory = 'tour/findAllTourByCategory';

  //Authen
  static const login = 'user/login';
  static const register = 'user/register';
  //User
  static const findUserByToken = 'user/findUserByToken';
  static const changePassword = 'user/changePassword';
  static const editProfile = 'user/editProfile';
  static const updateAvatar = 'user/updateAvatar';
  //Book Tour
  static const getUserBookTour = 'booktour/getUserBookTour';
  // Discount
  static const getAllDiscount = 'discount/getAllDiscount';
}
