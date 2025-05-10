import 'package:equatable/equatable.dart';

class CustorError extends Equatable {
  final String errMsg;
  const CustorError({
    this.errMsg = '',
  });

  @override
  List<Object> get props => [errMsg];

  @override
  bool get stringify => true;
}
