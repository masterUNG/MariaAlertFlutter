class ChildrenModel {
  String studentId, fname, studentClass, room, roomnt, score;

  ChildrenModel(this.studentId, this.fname, this.studentClass, this.room,
      this.roomnt, this.score);

  ChildrenModel.objJSON(Map<String, dynamic> parseJSON) {
    studentClass = parseJSON['id'];
    fname = parseJSON['fname'];
    studentClass = parseJSON['class'];
    room = parseJSON['room'];
    roomnt = parseJSON['room_nt'];
    score = parseJSON['score'];
  }
}
