///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsVi with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsVi({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.vi,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <vi>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsVi _root = this; // ignore: unused_field

	@override 
	TranslationsVi $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsVi(meta: meta ?? this.$meta);

	// Translations
	@override String get app_name => 'Ứng dụng Todo';
	@override String get login => 'Đăng nhập';
	@override String get username => 'Tên đăng nhập';
	@override String get password => 'Mật khẩu';
	@override String get confirm_password => 'Xác nhận mật khẩu';
	@override String get enter_your_username => 'Nhập tên đăng nhập';
	@override String get enter_your_password => 'Nhập mật khẩu';
	@override String get dont_have_account => 'Chưa có tài khoản? ';
	@override String get already_have_account => 'Đã có tài khoản? ';
	@override String get register => 'Đăng ký';
	@override String get register_success => 'Đăng ký thành công';
	@override String get index => 'Trang chủ';
	@override String get calendar => 'Lịch';
	@override String get focuse => 'Tập trung';
	@override String get profile => 'Cá nhân';
	@override String get what_do_you_want_to_do => 'Bạn muốn làm gì hôm nay?';
	@override String get tap_to_add_task => 'Nhấn + để thêm công việc';
	@override String get add_task => 'Thêm công việc';
	@override String get task_name => 'Tên công việc';
	@override String get task_title => 'Tiêu đề:';
	@override String get task_description => 'Mô tả công việc';
	@override String get description => 'Mô tả';
	@override String get not_null => 'Trống';
	@override String get required => 'Bắt buộc';
	@override String get cancel => 'Hủy';
	@override String get choose_time => 'Chọn thời gian';
	@override String get save => 'Lưu';
	@override String get task_priority => 'Độ ưu tiên';
	@override String get choose_category => 'Chọn danh mục';
	@override String get create_new => 'Tạo mới';
	@override String get please_input_description => 'Vui lòng nhập mô tả';
	@override String get please_select_date => 'Vui lòng chọn ngày';
	@override String get please_select_category => 'Vui lòng chọn danh mục';
	@override String get search_for_your_task => 'Tìm kiếm công việc...';
	@override String get today => 'Hôm nay';
	@override String get all_time => 'Tất cả';
	@override String get yesterday => 'Hôm qua';
	@override String get at => 'Lúc';
	@override String get completed => 'Đã hoàn thành';
	@override String get in_completed => 'Chưa hoàn thành';
	@override String get task_time => 'Thời gian:';
	@override String get task_category => 'Danh mục:';
	@override String get sub_task => 'Công việc phụ:';
	@override String get delete_task => 'Xóa công việc';
	@override String get are_you_sure_delete_task => 'Bạn có chắc muốn xóa công việc này không?';
	@override String get edit_task => 'Sửa công việc';
	@override String get edit_time => 'Sửa thời gian';
	@override String get edit => 'Sửa';
	@override String get add_sub_task => 'Thêm công việc phụ';
	@override String get kDefault => 'Mặc định';
	@override String get undefined => 'Chưa xác định';
	@override String get error_time_out => 'Hết thời gian chờ!';
	@override String get error_no_response => 'Server không phản hồi';
	@override String get error_username_not_found => 'Không tìm thấy tên đăng nhập';
	@override String get error_wrong_credentials => 'Sai tên đăng nhập hoặc mật khẩu';
	@override String get error_password_not_match => 'Mật khẩu không khớp';
	@override String get error_network => 'Lỗi kết nối mạng';
	@override String get error_database => 'Lỗi cơ sở dữ liệu';
	@override late final _TranslationsCategoriesVi categories = _TranslationsCategoriesVi._(_root);
	@override String id({required Object id}) => 'ID: ${id}';
	@override String showUsername({required Object username}) => '@${username}';
}

// Path: categories
class _TranslationsCategoriesVi implements TranslationsCategoriesEn {
	_TranslationsCategoriesVi._(this._root);

	final TranslationsVi _root; // ignore: unused_field

	// Translations
	@override String get grocery => 'Đi chợ';
	@override String get work => 'Công việc';
	@override String get sport => 'Thể thao';
	@override String get design => 'Thiết kế';
	@override String get university => 'Học tập';
	@override String get social => 'Xã hội';
	@override String get music => 'Âm nhạc';
	@override String get health => 'Sức khỏe';
	@override String get movie => 'Xem phim';
	@override String get home => 'Nhà cửa';
}

/// The flat map containing all translations for locale <vi>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsVi {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Ứng dụng Todo',
			'login' => 'Đăng nhập',
			'username' => 'Tên đăng nhập',
			'password' => 'Mật khẩu',
			'confirm_password' => 'Xác nhận mật khẩu',
			'enter_your_username' => 'Nhập tên đăng nhập',
			'enter_your_password' => 'Nhập mật khẩu',
			'dont_have_account' => 'Chưa có tài khoản? ',
			'already_have_account' => 'Đã có tài khoản? ',
			'register' => 'Đăng ký',
			'register_success' => 'Đăng ký thành công',
			'index' => 'Trang chủ',
			'calendar' => 'Lịch',
			'focuse' => 'Tập trung',
			'profile' => 'Cá nhân',
			'what_do_you_want_to_do' => 'Bạn muốn làm gì hôm nay?',
			'tap_to_add_task' => 'Nhấn + để thêm công việc',
			'add_task' => 'Thêm công việc',
			'task_name' => 'Tên công việc',
			'task_title' => 'Tiêu đề:',
			'task_description' => 'Mô tả công việc',
			'description' => 'Mô tả',
			'not_null' => 'Trống',
			'required' => 'Bắt buộc',
			'cancel' => 'Hủy',
			'choose_time' => 'Chọn thời gian',
			'save' => 'Lưu',
			'task_priority' => 'Độ ưu tiên',
			'choose_category' => 'Chọn danh mục',
			'create_new' => 'Tạo mới',
			'please_input_description' => 'Vui lòng nhập mô tả',
			'please_select_date' => 'Vui lòng chọn ngày',
			'please_select_category' => 'Vui lòng chọn danh mục',
			'search_for_your_task' => 'Tìm kiếm công việc...',
			'today' => 'Hôm nay',
			'all_time' => 'Tất cả',
			'yesterday' => 'Hôm qua',
			'at' => 'Lúc',
			'completed' => 'Đã hoàn thành',
			'in_completed' => 'Chưa hoàn thành',
			'task_time' => 'Thời gian:',
			'task_category' => 'Danh mục:',
			'sub_task' => 'Công việc phụ:',
			'delete_task' => 'Xóa công việc',
			'are_you_sure_delete_task' => 'Bạn có chắc muốn xóa công việc này không?',
			'edit_task' => 'Sửa công việc',
			'edit_time' => 'Sửa thời gian',
			'edit' => 'Sửa',
			'add_sub_task' => 'Thêm công việc phụ',
			'kDefault' => 'Mặc định',
			'undefined' => 'Chưa xác định',
			'error_time_out' => 'Hết thời gian chờ!',
			'error_no_response' => 'Server không phản hồi',
			'error_username_not_found' => 'Không tìm thấy tên đăng nhập',
			'error_wrong_credentials' => 'Sai tên đăng nhập hoặc mật khẩu',
			'error_password_not_match' => 'Mật khẩu không khớp',
			'error_network' => 'Lỗi kết nối mạng',
			'error_database' => 'Lỗi cơ sở dữ liệu',
			'categories.grocery' => 'Đi chợ',
			'categories.work' => 'Công việc',
			'categories.sport' => 'Thể thao',
			'categories.design' => 'Thiết kế',
			'categories.university' => 'Học tập',
			'categories.social' => 'Xã hội',
			'categories.music' => 'Âm nhạc',
			'categories.health' => 'Sức khỏe',
			'categories.movie' => 'Xem phim',
			'categories.home' => 'Nhà cửa',
			'id' => ({required Object id}) => 'ID: ${id}',
			'showUsername' => ({required Object username}) => '@${username}',
			_ => null,
		};
	}
}
