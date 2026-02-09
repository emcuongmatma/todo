///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Todo App'
	String get app_name => 'Todo App';

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Confirm Password'
	String get confirm_password => 'Confirm Password';

	/// en: 'Enter your Username'
	String get enter_your_username => 'Enter your Username';

	/// en: 'Enter your Password'
	String get enter_your_password => 'Enter your Password';

	/// en: 'Don’t have an account? '
	String get dont_have_account => 'Don’t have an account? ';

	/// en: 'Already have an account? '
	String get already_have_account => 'Already have an account? ';

	/// en: 'Register'
	String get register => 'Register';

	/// en: 'Register Success'
	String get register_success => 'Register Success';

	/// en: 'Index'
	String get index => 'Index';

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Focuse'
	String get focuse => 'Focuse';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'What do you want to do today?'
	String get what_do_you_want_to_do => 'What do you want to do today?';

	/// en: 'Tap + to add your tasks'
	String get tap_to_add_task => 'Tap + to add your tasks';

	/// en: 'Add Task'
	String get add_task => 'Add Task';

	/// en: 'Task name'
	String get task_name => 'Task name';

	/// en: 'Task title:'
	String get task_title => 'Task title:';

	/// en: 'Task description'
	String get task_description => 'Task description';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Empty'
	String get not_null => 'Empty';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Choose Time'
	String get choose_time => 'Choose Time';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Task Priority'
	String get task_priority => 'Task Priority';

	/// en: 'Choose Category'
	String get choose_category => 'Choose Category';

	/// en: 'Create New'
	String get create_new => 'Create New';

	/// en: 'Please input description'
	String get please_input_description => 'Please input description';

	/// en: 'Please select date'
	String get please_select_date => 'Please select date';

	/// en: 'Please select category'
	String get please_select_category => 'Please select category';

	/// en: 'Search for your task...'
	String get search_for_your_task => 'Search for your task...';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'All Time'
	String get all_time => 'All Time';

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';

	/// en: 'At'
	String get at => 'At';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Incompleted'
	String get in_completed => 'Incompleted';

	/// en: 'Task Time:'
	String get task_time => 'Task Time:';

	/// en: 'Task Category:'
	String get task_category => 'Task Category:';

	/// en: 'Sub-Task:'
	String get sub_task => 'Sub-Task:';

	/// en: 'Delete Task'
	String get delete_task => 'Delete Task';

	/// en: 'Are You sure you want to delete this task?'
	String get are_you_sure_delete_task => 'Are You sure you want to delete this task?';

	/// en: 'Edit Task'
	String get edit_task => 'Edit Task';

	/// en: 'Edit Time'
	String get edit_time => 'Edit Time';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Add Sub-Task'
	String get add_sub_task => 'Add Sub-Task';

	/// en: 'Default'
	String get kDefault => 'Default';

	/// en: 'Undefined'
	String get undefined => 'Undefined';

	/// en: 'Time out!'
	String get error_time_out => 'Time out!';

	/// en: 'Server not response'
	String get error_no_response => 'Server not response';

	/// en: 'Username not found'
	String get error_username_not_found => 'Username not found';

	/// en: 'Wrong username or password'
	String get error_wrong_credentials => 'Wrong username or password';

	/// en: 'Password not match'
	String get error_password_not_match => 'Password not match';

	/// en: 'Network Error'
	String get error_network => 'Network Error';

	/// en: 'Database Error'
	String get error_database => 'Database Error';

	late final TranslationsCategoriesEn categories = TranslationsCategoriesEn._(_root);

	/// en: 'ID: $id'
	String id({required Object id}) => 'ID: ${id}';

	/// en: '@$username'
	String showUsername({required Object username}) => '@${username}';
}

// Path: categories
class TranslationsCategoriesEn {
	TranslationsCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Grocery'
	String get grocery => 'Grocery';

	/// en: 'Work'
	String get work => 'Work';

	/// en: 'Sport'
	String get sport => 'Sport';

	/// en: 'Design'
	String get design => 'Design';

	/// en: 'University'
	String get university => 'University';

	/// en: 'Social'
	String get social => 'Social';

	/// en: 'Music'
	String get music => 'Music';

	/// en: 'Health'
	String get health => 'Health';

	/// en: 'Movie'
	String get movie => 'Movie';

	/// en: 'Home'
	String get home => 'Home';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Todo App',
			'login' => 'Login',
			'username' => 'Username',
			'password' => 'Password',
			'confirm_password' => 'Confirm Password',
			'enter_your_username' => 'Enter your Username',
			'enter_your_password' => 'Enter your Password',
			'dont_have_account' => 'Don’t have an account? ',
			'already_have_account' => 'Already have an account? ',
			'register' => 'Register',
			'register_success' => 'Register Success',
			'index' => 'Index',
			'calendar' => 'Calendar',
			'focuse' => 'Focuse',
			'profile' => 'Profile',
			'what_do_you_want_to_do' => 'What do you want to do today?',
			'tap_to_add_task' => 'Tap + to add your tasks',
			'add_task' => 'Add Task',
			'task_name' => 'Task name',
			'task_title' => 'Task title:',
			'task_description' => 'Task description',
			'description' => 'Description',
			'not_null' => 'Empty',
			'required' => 'Required',
			'cancel' => 'Cancel',
			'choose_time' => 'Choose Time',
			'save' => 'Save',
			'task_priority' => 'Task Priority',
			'choose_category' => 'Choose Category',
			'create_new' => 'Create New',
			'please_input_description' => 'Please input description',
			'please_select_date' => 'Please select date',
			'please_select_category' => 'Please select category',
			'search_for_your_task' => 'Search for your task...',
			'today' => 'Today',
			'all_time' => 'All Time',
			'yesterday' => 'Yesterday',
			'at' => 'At',
			'completed' => 'Completed',
			'in_completed' => 'Incompleted',
			'task_time' => 'Task Time:',
			'task_category' => 'Task Category:',
			'sub_task' => 'Sub-Task:',
			'delete_task' => 'Delete Task',
			'are_you_sure_delete_task' => 'Are You sure you want to delete this task?',
			'edit_task' => 'Edit Task',
			'edit_time' => 'Edit Time',
			'edit' => 'Edit',
			'add_sub_task' => 'Add Sub-Task',
			'kDefault' => 'Default',
			'undefined' => 'Undefined',
			'error_time_out' => 'Time out!',
			'error_no_response' => 'Server not response',
			'error_username_not_found' => 'Username not found',
			'error_wrong_credentials' => 'Wrong username or password',
			'error_password_not_match' => 'Password not match',
			'error_network' => 'Network Error',
			'error_database' => 'Database Error',
			'categories.grocery' => 'Grocery',
			'categories.work' => 'Work',
			'categories.sport' => 'Sport',
			'categories.design' => 'Design',
			'categories.university' => 'University',
			'categories.social' => 'Social',
			'categories.music' => 'Music',
			'categories.health' => 'Health',
			'categories.movie' => 'Movie',
			'categories.home' => 'Home',
			'id' => ({required Object id}) => 'ID: ${id}',
			'showUsername' => ({required Object username}) => '@${username}',
			_ => null,
		};
	}
}
