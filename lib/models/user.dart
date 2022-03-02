import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Users {
  final String password;
  late final String user_id;
  final bool user_type;

  Users({
    required this.password,
    required this.user_type,
    required this.user_id,
  });

  Users.fromJson(Map<String, Object?> json)
      : this(
          user_id: json['user_id']! as String,
          user_type: json['user_type']! as bool,
          password: json['password']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'student_id': user_id,
      'user_type': user_type,
      'password': password,
    };
  }
}
