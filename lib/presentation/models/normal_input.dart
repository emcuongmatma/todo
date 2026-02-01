import 'package:formz/formz.dart';
import 'package:todo/core/constants/app_constants.dart';

enum NormalInputValidatorError { empty, wrong, notMatch }

class NormalInput extends FormzInput<String, NormalInputValidatorError> {
  final bool isWrong;
  final bool isMatched;

  const NormalInput.pure({this.isWrong = false, this.isMatched = true})
    : super.pure('');

  const NormalInput.dirty([
    super.value = '',
    this.isWrong = false,
    this.isMatched = true,
  ]) : super.dirty();

  @override
  NormalInputValidatorError? validator(String value) {
    if (value.isEmpty) return NormalInputValidatorError.empty;
    if (isWrong == true) return NormalInputValidatorError.wrong;
    if (isMatched == false) return NormalInputValidatorError.notMatch;
    return null;
  }
}

extension NormalInputX on NormalInput {
  String? get inputStatusText {
    if (isPure) return null;
    switch (error) {
      case NormalInputValidatorError.empty:
        return AppConstants.REQUIRED;
      case NormalInputValidatorError.wrong:
        return AppConstants.WRONG_USERNAME_OR_PASSWORD;
      case NormalInputValidatorError.notMatch:
        return AppConstants.PASSWORD_NOT_MATCH;
      default:
        return null;
    }
  }
}
