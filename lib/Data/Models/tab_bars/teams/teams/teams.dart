// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'result.dart';

class Teams {
  int? success;
  List<Result>? result;

  Teams({this.success, this.result});

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
        success: json['success'] as int?,
        result: (json['result'] as List<dynamic>?)
            ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'result': result?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Teams) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => success.hashCode ^ result.hashCode;
}
