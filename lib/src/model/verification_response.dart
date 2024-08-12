class VerificationResponse {
  final String accountName;
  final String accountNumber;

  VerificationResponse(
      {required this.accountName, required this.accountNumber});

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      accountName: json['account_name'],
      accountNumber: json['account_number'],
    );
  }
}
