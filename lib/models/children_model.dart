class ChildrenModel {
  String studentId, fname, studentClass, room, roomnt, score, imagePath;

  ChildrenModel(this.studentId, this.fname, this.studentClass, this.room,
      this.roomnt, this.score, this.imagePath);

  ChildrenModel.objJSON(Map<String, dynamic> parseJSON) {
    studentClass = parseJSON['id'];
    fname = parseJSON['fname'];
    studentClass = parseJSON['class'];
    room = parseJSON['room'];
    roomnt = parseJSON['room_nt'];
    score = parseJSON['score'];
    imagePath = parseJSON['imagePath'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'fname => $fname, imagePath => $imagePath';
  }

}
