import 'dart:convert';

class SmokedCig {
  final int amount;
  final DateTime date;
  final String userId;
  final String id;
  SmokedCig({
    required this.amount,
    required this.date,
    required this.userId,
    required this.id,
  });

  SmokedCig copyWith({
    int? amount,
    DateTime? date,
    String? userId,
    String? id,
  }) {
    return SmokedCig(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'user_id': userId,
    };
  }

  factory SmokedCig.fromMap(Map<String, dynamic> map) {
    return SmokedCig(
      amount: map['amount'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      userId: map['user_id'],
      id: map['\$id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SmokedCig.fromJson(String source) =>
      SmokedCig.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SmokedCig(amount: $amount, date: $date, userId: $userId, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SmokedCig &&
        other.amount == amount &&
        other.date == date &&
        other.userId == userId &&
        other.id == id;
  }

  @override
  int get hashCode {
    return amount.hashCode ^ date.hashCode ^ userId.hashCode ^ id.hashCode;
  }
}
