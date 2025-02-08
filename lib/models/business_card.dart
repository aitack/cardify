class BusinessCard {
  final String nickname;
  final String snsUsername; // InstagramなどのSNSユーザー名
  final String githubUsername; // Githubのユーザー名
  final String noteUsername; // Noteのユーザー名
  final String email;
  final String other;
  final int number;

  BusinessCard({
    required this.nickname,
    required this.snsUsername,
    required this.githubUsername,
    required this.noteUsername,
    required this.email,
    required this.other,
    required this.number,
  });
}
