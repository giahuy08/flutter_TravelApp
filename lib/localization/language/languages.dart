import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;
  String get loginWarn;
  String get emailForm;
  String get emailDesc;
  String get passForm;
  String get passDesc;
  String get saveInfo;
  String get forgotPassText;
  String get loginText;
  String get haveAccountText;
  String get registerText;
  String get orContinueText;
  String get registerAccountText;
  String get fullnameDescText;
  String get fullnameFormText;
  String get confirmPassDesText;
  String get confirmPassFormText;
  String get phoneDescText;
  String get phoneFormText;
  String get addressDescText;
  String get addressFormText;
  String get sendText;

  String get paymentSuccessText;
  String get confirmText;
  String get successText;

  //Ticket
  String get infoTicketText;
  String get toText;
  String get fromText;
  String get startDateText;
  String get endDateText;
  String get customerText;

  //Schedule tour
  String get freeSeatText;
  String get donthaveScheduleText;
  String get freeText;
  String get bookedText;
  String get bookedSeatText;
  String get bookNowText;
  String get goToPaymentText;
  String get discountText;

  // ReviewTour
  String get tourText;
  String get detailText;
  String get thankYouText;
  String get feedbackText;
  String get commentText;
  String get timeText;
  String get priceText;
  String get placeText;

  //Profile
  String get accountText;
  String get changePasswordText;
  String get customerCareText;
  String get logoutText;
  String get wantLogoutText;
  String get cancelText;
  String get userProfile;

  //Payment
  String get typeofPaymentText;
  String get paymentText;

  //Otp signup
  String get emailOtpText;
  String get authorOtpText;

  //Notification
  String get listnotiText;
  String get notiText;
  String get donthaveNoti;

  //Map
  String get maptext;

  //Login success
  String get loginSuccess;
  String get gotoHome;

  String get notFoundText;

  //List tour
  String get listToursText;
  String get starText;

  //Vehicle
  String get vehicleText;
  String get listVehicleText;

  //List enterprise
  String get partnerText;
  String get hotelText;
  String get restaurantText;

  //itinerary pdf
  String get gotoPageText;
  String get scheduleText;

  // discount
  String get saleText;
  String get codeText;

  // detail
  String get endText;
  String get dontUpdateServiceText;
  String get serviceText;
  String get dontHaveDiscountText;
  String get otherTourText;
  String get seeMoreText;
  String get donthaveCommentText;
  String get startingPointText;
  String get destinationText;
  String get watchScheduleText;

  //Chat
  String get messageText;
  String get enterMessageText;

  String get enterFullInfoText;

  //Change password

  String get newPasswordDes;
  String get newPasswordForm;

  String get oldPasswordDes;
  String get oldPasswordForm;
  String get searchText;

  String get waitStatusText;
  String get bookedStatusText;
  String get cancelStatusText;

  //Booked tour
  String get bookedTourText;

  //Home
  String get youCanCareText;
  String get youCanLikeText;
  String get visitedText;
  String get travelText;
  String get saveText;
  String get reEnterNewPassTextDes;
  String get reEnterNewPassTextForm;

  String get successChangePassText;
  String get successCreateAccountText;
  String get chooseDateText;
  String get duplicateReviewText;

  String get cashText;

  String get kEmailNullError;
  String get kInvalidEmailError;
  String get kPassNullError;
  String get kShortPassError;
  String get kMatchPassError;
  String get kNamelNullError;
  String get kPhoneNumberNullError;
  String get kAddressNullError;
  String get kEmailExistError;
  String get kEmailDontExistError;
  String get kOtpValidError;
  String get kOtpError;

  String get kLoginFail;
  String get kChangePasswordFail;
  String get kEditProfileFail;

  String get tourNotCompleted;
}
