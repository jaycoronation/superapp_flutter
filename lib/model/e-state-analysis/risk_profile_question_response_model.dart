import 'dart:convert';
/// risk_profiler_questions : [{"question_id":"1","question":"Which of the following statements best describes your views when considering a new investment?","answers":[{"answer_id":"1","answer":"I am primarily concerned with protecting against loss at any time."},{"answer_id":"2","answer":"I am willing to bear some risk to achieve higher returns, but prefer that the majority of my assets are placed in low-risk investments."},{"answer_id":"3","answer":"I am equally concerned with minimizing the potential for loss and achieving growth in the value of my initial investment."},{"answer_id":"4","answer":"I am primarily interested in the growth of my investment, but have some concern regarding the potential for short-term losses."},{"answer_id":"5","answer":"I am primarily concerned with the growth of my investment and am willing to accept a higher level of short-term volatility."}]},{"question_id":"2","question":"Which statement below best describes how you might feel about short-term fluctuations in the value of one of your investments?","answers":[{"answer_id":"6","answer":"I would remain undisturbed."},{"answer_id":"7","answer":"I would become somewhat anxious."},{"answer_id":"8","answer":"I would be extremely concerned."}]},{"question_id":"3","question":"Assumed that one year ago you purchased an equity mutual fund. Today the market value of your investment is lower by 30%. Which of the following actions do you think you would be most inclined to take today?","answers":[{"answer_id":"9","answer":"I would sell the fund immediately and invest the proceeds in a less risky investment."},{"answer_id":"10","answer":"I would do nothing."},{"answer_id":"11","answer":"I would buy more to take advantage of the lower price."}]},{"question_id":"4","question":"Over time, inflation can drastically reduce the real rate of return on your investments. Which of the following statements best describes your attitude towards inflation and risk?","answers":[{"answer_id":"12","answer":"I am most concerned with maximizing returns and want a portfolio designed to significantly outpace inflation, even if I am exposed to substantial risk."},{"answer_id":"13","answer":"I am willing to accept a modest risk level with my investments and want a portfolio designed to moderately outpace inflation."},{"answer_id":"14","answer":"I am primarily concerned with protecting my principal and want a portfolio designed to minimize risk, while keeping pace with inflation."},{"answer_id":"15","answer":"I am not willing to accept even the slightest short-term erosion in my capital and want a portfolio designed to eliminate risk completely even if it means that I may not keep pace with inflation."}]},{"question_id":"5","question":"Given your investment objective, what is your anticipated time horizon for this account?.","answers":[{"answer_id":"16","answer":"1 year or less."},{"answer_id":"17","answer":"More than 1 year, up to and including 3 years."},{"answer_id":"18","answer":"More than 3 years, up to and including 10 years."},{"answer_id":"19","answer":"More than 10 years, up to and including 15 years."},{"answer_id":"20","answer":"More than 15 years."}]}]
/// message : "Questions & Answers found"
/// success : 1

RiskProfileQuestionResponseModel riskProfileQuestionResponseModelFromJson(String str) => RiskProfileQuestionResponseModel.fromJson(json.decode(str));
String riskProfileQuestionResponseModelToJson(RiskProfileQuestionResponseModel data) => json.encode(data.toJson());
class RiskProfileQuestionResponseModel {
  RiskProfileQuestionResponseModel({
      List<RiskProfilerQuestions>? riskProfilerQuestions, 
      String? message, 
      num? success,}){
    _riskProfilerQuestions = riskProfilerQuestions;
    _message = message;
    _success = success;
}

  RiskProfileQuestionResponseModel.fromJson(dynamic json) {
    if (json['risk_profiler_questions'] != null) {
      _riskProfilerQuestions = [];
      json['risk_profiler_questions'].forEach((v) {
        _riskProfilerQuestions?.add(RiskProfilerQuestions.fromJson(v));
      });
    }
    _message = json['message'];
    _success = json['success'];
  }
  List<RiskProfilerQuestions>? _riskProfilerQuestions;
  String? _message;
  num? _success;
RiskProfileQuestionResponseModel copyWith({  List<RiskProfilerQuestions>? riskProfilerQuestions,
  String? message,
  num? success,
}) => RiskProfileQuestionResponseModel(  riskProfilerQuestions: riskProfilerQuestions ?? _riskProfilerQuestions,
  message: message ?? _message,
  success: success ?? _success,
);
  List<RiskProfilerQuestions>? get riskProfilerQuestions => _riskProfilerQuestions;
  String? get message => _message;
  num? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_riskProfilerQuestions != null) {
      map['risk_profiler_questions'] = _riskProfilerQuestions?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    map['success'] = _success;
    return map;
  }

}

/// question_id : "1"
/// question : "Which of the following statements best describes your views when considering a new investment?"
/// answers : [{"answer_id":"1","answer":"I am primarily concerned with protecting against loss at any time."},{"answer_id":"2","answer":"I am willing to bear some risk to achieve higher returns, but prefer that the majority of my assets are placed in low-risk investments."},{"answer_id":"3","answer":"I am equally concerned with minimizing the potential for loss and achieving growth in the value of my initial investment."},{"answer_id":"4","answer":"I am primarily interested in the growth of my investment, but have some concern regarding the potential for short-term losses."},{"answer_id":"5","answer":"I am primarily concerned with the growth of my investment and am willing to accept a higher level of short-term volatility."}]

RiskProfilerQuestions riskProfilerQuestionsFromJson(String str) => RiskProfilerQuestions.fromJson(json.decode(str));
String riskProfilerQuestionsToJson(RiskProfilerQuestions data) => json.encode(data.toJson());
class RiskProfilerQuestions {
  RiskProfilerQuestions({
      String? questionId, 
      String? question, 
      List<Answers>? answers,}){
    _questionId = questionId;
    _question = question;
    _answers = answers;

}

  RiskProfilerQuestions.fromJson(dynamic json) {
    _questionId = json['question_id'];
    _question = json['question'];
    if (json['answers'] != null) {
      _answers = [];
      json['answers'].forEach((v) {
        _answers?.add(Answers.fromJson(v));
      });
    }
  }
  String? _questionId;
  String? _question;
  List<Answers>? _answers;
RiskProfilerQuestions copyWith({  String? questionId,
  String? question,
  List<Answers>? answers,
}) => RiskProfilerQuestions(  questionId: questionId ?? _questionId,
  question: question ?? _question,
  answers: answers ?? _answers,
);
  String? get questionId => _questionId;
  String? get question => _question;
  List<Answers>? get answers => _answers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = _questionId;
    map['question'] = _question;
    if (_answers != null) {
      map['answers'] = _answers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// answer_id : "1"
/// answer : "I am primarily concerned with protecting against loss at any time."

Answers answersFromJson(String str) => Answers.fromJson(json.decode(str));
String answersToJson(Answers data) => json.encode(data.toJson());
class Answers {
  Answers({
      String? answerId, 
      String? answer,
    bool? isSelected,}){
    _answerId = answerId;
    _answer = answer;
    _isSelected = isSelected;
}

  Answers.fromJson(dynamic json) {
    _answerId = json['answer_id'];
    _answer = json['answer'];
    _isSelected = json['isSelected'];
  }
  String? _answerId;
  String? _answer;
  bool? _isSelected;
Answers copyWith({  String? answerId,
  String? answer,
}) => Answers(  answerId: answerId ?? _answerId,
  answer: answer ?? _answer,
  isSelected: isSelected ?? _isSelected,
);
  String? get answerId => _answerId;
  String? get answer => _answer;
  bool? get isSelected => _isSelected;

  set isSelected(bool? value) {
    _isSelected = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answer_id'] = _answerId;
    map['answer'] = _answer;
    map['isSelected'] = _isSelected;

    return map;
  }

}