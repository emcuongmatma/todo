import 'package:formz/formz.dart';
import 'package:todo/core/constants/app_constants.dart';

enum NormalInputValidatorError {empty}
class NormalInput extends FormzInput<String,NormalInputValidatorError> {
  const NormalInput.pure() : super.pure('');

  const NormalInput.dirty([super.value = '']) : super.dirty();

  @override
  NormalInputValidatorError? validator(String value) {
    if (value.isEmpty) return NormalInputValidatorError.empty;
    return null;
  }
}

extension NormalInputX on NormalInput {
  String? get inputStatusText {
    if (isPure) return null;
    switch (error) {
      case NormalInputValidatorError.empty:
        return AppConstants.REQUIRED;
      default:
        return null;
    }
  }
}