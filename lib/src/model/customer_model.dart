class Customer {
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;

  Customer({
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
    };
  }
}
