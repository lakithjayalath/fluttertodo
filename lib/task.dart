class Task {
  String _taskName;
  String _taskDetails;
  String _taskDate;
  String _taskTime;
  String _taskType;

  Task(this._taskName, this._taskDetails, this._taskDate, this._taskTime, this._taskType);

  Task.map(dynamic obj) {
    this._taskName = obj['taskName'];
    this._taskDetails = obj['taskDetails'];
    this._taskDate = obj['taskDate'];
    this._taskTime = obj['taskTime'];
    this._taskType = obj['taskType'];
  }

  String get taskname => _taskName;
  String get taskdetails => _taskDetails;
  String get taskdate => _taskDate;
  String get tasktime => _taskTime;
  String get tasktype => _taskType;

  //de-serialize the data
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['taskName'] = _taskName;
    map['taskDetails'] = _taskDetails;
    map['taskDate'] = _taskDate;
    map['taskTime'] = _taskTime;
    map['taskType'] = _taskType;
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    this._taskName = map['taskName'];
    this._taskDetails = map['taskDetails'];
    this._taskDate = map['taskDate'];
    this._taskTime = map['taskTime'];
    this._taskType = map['taskType'];
  }
}