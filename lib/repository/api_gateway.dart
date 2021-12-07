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
  static const forgotPassword = 'user/forgotPassword';
  static const resetPassword = 'user/resetPassword';

  //User
  static const findUserByToken = 'user/findUserByToken';
  static const changePassword = 'user/changePassword';
  static const editProfile = 'user/editProfile';
  static const updateAvatar = 'user/updateAvatar';
  //Book Tour
  static const getUserBookTour = 'booktour/getUserBookTour';
  static const bookTour = 'booktour/bookTour';
  static const bookTourPayment = 'booktour/bookTourPayment';

  // Discount
  static const getAllDiscount = 'discount/getAllDiscount';

  //Review Tour
  static const getReviewOfTour = 'reviewtour/getReviewOfTour';
  static const createReviewTour = 'reviewtour/createReviewTour';

  //Enterprise
  static const getAllEnterprise = 'enterprise/getAllEnterprise';

  //Vehicle
  static const getAllVehicle = 'vehicle/getAllVehicle';
}
