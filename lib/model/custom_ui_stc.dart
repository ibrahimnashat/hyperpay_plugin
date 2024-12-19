enum STCPayVerificationOption {
  /// Mobile phone number option.
  mobilePhone,

  /// QR-Code option.
  qrCode,
}

class STCTransaction {
  /// The mobile phone number.
  final String? mobile;
  final String checkoutId;

  /// The verification option to proceed STC Pay transaction
  final STCPayVerificationOption verificationOption;

  /// [checkoutId] The checkout id of the transaction. Must not be empty.
  ///
  /// [verificationOption] The card number of the transaction.
  ///
  /// [mobile] The mobile phone number.
  STCTransaction({
    required this.checkoutId,
    required this.verificationOption,
    this.mobile,
  });

  Map<String, dynamic> toMap() {
    return {
      "type": "CustomUISTC",
      "checkoutId": checkoutId,
      "mobile": mobile,
      "verificationOption": verificationOption.name,
    }..removeWhere((key, value) => value == null);
  }
}
