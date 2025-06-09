//Live
//const String API_URL = "http://alphacapital.coronation.in/api/services/";
const String API_URL = "https://portfolio.alphacapital.in/api/services/";
const String API_URL_ADD_VAULT = "https://vault.alphacapital.in/api/index.php/services/";
const String API_URL_ADD = "https://analysis.alphacapital.in/api/index.php/services/";
const String BASE_URL = "https://demo1.coronation.in/AlphacapitalReportApp/api/";

const String CHEETAH_TASK_LIST = '${BASE_URL}Task/GetAllTaskForClient';
const String GET_ALL_TASK_ATTACHMENT = '${BASE_URL}Task/GetAllTaskAttachemntByTaskId';
const String SaveTaskAttachment = '${BASE_URL}Task/SaveTaskAttachment';
const String TASK_DETAILS = "${BASE_URL}Task/GetTaskDetailById";
const String TASK_MESSAGE = "${BASE_URL}Task/GetAllTaskMessageByTaskId";
const String TASK_MESSAGE_SAVE = "${BASE_URL}Task/SaveTaskMessageByClient";
String authHeader = "Basic QWxwaGFjYXBpdGFsOkFwcC00U1RTQTY0TzYyV1FXWlIwUVNJSw==";

String login = "loginForSuperApp";

//=======
String additionalLinks = "additionallinks";
String contactSave = "inquiries/save";
String add = "last_used_module/add";

// Documents API //

String documentLists = '${API_URL}manage_documents/list';

// ========== MINT URLS ============

const String MINT_URL ="https://alphacapital.investwell.app/";

String mintLogin = "api/auth/login";
String forgotPassword = "api/auth/sendPasswordResetMail";