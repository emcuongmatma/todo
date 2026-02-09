import 'package:formz/formz.dart';
import 'package:todo/i18n/strings.g.dart';

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
        return t.required;
      case NormalInputValidatorError.wrong:
        return t.error_wrong_credentials;
      case NormalInputValidatorError.notMatch:
        return t.error_password_not_match;
      default:
        return null;
    }
  }
}
