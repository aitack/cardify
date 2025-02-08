class BusinessCard {
  final String name;
  final String jobTitle;
  final String email;
  final String phone;
  final int number; // 追加：カードの番号

  BusinessCard({
    required this.name,
    required this.jobTitle,
    required this.email,
    required this.phone,
    required this.number, // 初期化
  });
}
