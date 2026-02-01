class AppConstants {
  static const String LOGIN = "Login";
  static const String USERNAME = "Username";
  static const String PASSWORD = "Password";
  static const String CONFIRM_PASSWORD = "Confirm Password";
  static const String ENTER_YOUR_USERNAME = "Enter your Username";
  static const String ENTER_YOUR_PASSWORD = "Enter your Password";
  static const String DONT_HAVE_ACCOUNT = "Don’t have an account? ";
  static const String ALREADY_HAVE_ACCOUNT = "Already have an account? ";
  static const String REGISTER = "Register";
  static const String REGISTER_SUCCESS = "Register Success";
  static const String INDEX = "Index";
  static const String CALENDAR = "Calendar";
  static const String FOCUSE = "Focuse";
  static const String PROFILE = "Profile";
  static const String IMAGE_URL_TEST ="https://cellphones.com.vn/sforum/wp-content/uploads/2024/02/avatar-anh-meo-cute-3.jpg";
  static const String WHAT_DO_YOU_WANT_TO_DO ="What do you want to do today?";
  static const String TAP_TO_ADD_TASK ="Tap + to add your tasks";
  static const String ADD_TASK ="Add Task";
  static const String TASK_NAME ="Task name";
  static const String TASK_TITLE ="Task title:";
  static const String TASK_DESCRIPTION ="Task description";
  static const String DESCRIPTION ="Description";
  static const String NOT_NULL = "Empty";
  static const String REQUIRED = "Required";
  static const String CANCEL = "Cancel";
  static const String CHOOSE_TIME = "Choose Time";
  static const String SAVE = "Save";
  static const String TASK_PRIORITY = "Task Priority";
  static const String CHOOSE_CATEGORY = "Choose Category";
  static const String CREATE_NEW = "Create New";
  static const String PLEASE_SELECT_DATE = "Please select date";
  static const String PLEASE_SELECT_CATEGORY = "Please select category";
  static const String SEARCH_FOR_YOUR_TASK = "Search for your task...";
  static const String TODAY = "Today";
  static const String ALL_TIME = "All Time";
  static const String YESTERDAY = "Yesterday";
  static const String AT = "At";
  static const String COMPLETED = "Completed";
  static const String IN_COMPLETED = "Incompleted";
  static const String TASK_TIME = "Task Time:";
  static const String TASK_CATEGORY = "Task Category:";
  static const String SUB_TASK = "Sub-Task:";
  static const String DELETE_TASK = "Delete Task";
  static const String ARE_YOU_SURE_DELETE_TASK = "Are You sure you want to delete this task?";
  static const String EDIT_TASK = "Edit Task";
  static const String ADD_SUB_TASK = "Add Sub-Task";
  static const String DEFAULT = "Default";
  static const String UNDEFINED = "Undefined";
  static const String TIME_OUT = "Time out!";
  static const String NOT_RESPONSE = "Server not response";
  static const String USERNAME_NOT_FOUND = "Username not found";
  static const String WRONG_USERNAME_OR_PASSWORD = "Wrong username or password";
  static const String PASSWORD_NOT_MATCH = "Password not match";
  static const String NETWORK_ERROR = "Network Error";
  static const String DATABASE_ERROR = "Database Error";
}

class API {
  static const BASE_URL = 'https://6969ace53a2b2151f845f24d.mockapi.io/api/v1';

  // Authentication
  static const AUTH = '$BASE_URL/auth';
  //Profile
  static const TASK = '$BASE_URL/tasks';
}