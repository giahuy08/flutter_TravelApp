class ApiGateway {
  // Tour
  static const getAllTour = 'tour/getAllTour';
  static const getOneTour = 'tour/getOneTour';
  static const findTourByName = 'tour/findTourByName';
  static const findTourByCategory = 'tour/findTourByCategory';
  static const findAllTourByCategory = 'tour/findAllTourByCategory';
  static const getUserFarvorite = 'tour/getUserFarvorite';
  static const getHistoryAccess = 'tour/getHistoryAccess';
  static const findTourByDate = 'tour/findTourByDate';

  //Authen
  static const login = 'user/login';
  static const register = 'user/register';
  static const forgotPassword = 'user/forgotPassword';
  static const resetPassword = 'user/resetPassword';
  static const loginwithGoogle = 'user/loginwithGoogle';

  //User
  static const findUserByToken = 'user/findUserByToken';
  static const changePassword = 'user/changePassword';
  static const editProfile = 'user/editProfile';
  static const updateAvatar = 'user/updateAvatar';
  static const verifyUser = 'user/verifyUser';

  //Book Tour
  static const getUserBookTour = 'booktour/getUserBookTour';
  static const getUserBookTourByDate = 'booktour/getUserBookTourByDate';
  static const bookTour = 'booktour/bookTour';
  static const bookTourPayment = 'booktour/bookTourPayment';
  static const getScheduleTourOfTourByEXP =
      'scheduletour/getScheduleTourOfTourByEXP';

  // Discount
  static const getAllDiscount = 'discount/getAllDiscount';
  static const getAllDiscountByEXP = 'discount/getAllDiscountByEXP';
  static const getDiscountOfTourByEXP = 'discount/getDiscountOfTourByEXP';

  //Review Tour
  static const getReviewOfTour = 'reviewtour/getReviewOfTour';
  static const createReviewTour = 'reviewtour/createReviewTour';

  //Enterprise
  static const getAllEnterprise = 'enterprise/getAllEnterprise';
  static const getOneEnterprise = 'enterprise/getOneEnterprise';
  static const getRoomOfEnterprise = 'hotelroom/getRoomOfEnterprise';
  static const getTableOfEnterprise = 'restauranttable/getTableOfEnterprise';

  //Vehicle
  static const getAllVehicle = 'vehicle/getAllVehicle';
  static const getOneVehicle = 'vehicle/getOneVehicle';

  // Message
  static const getMessage = 'chat/getMessage';
  static const getlistroom = 'chat/getRoom';

  //Favorite
  static const favoriteTour = 'favorite/access';
}
