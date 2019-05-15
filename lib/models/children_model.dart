class ChildrenModel {
  String studentId, fname, studentClass, room, roomnt, score, imagePath, parents;

  ChildrenModel(this.studentId, this.fname, this.studentClass, this.room,
      this.roomnt, this.score, this.imagePath, this.parents);

  ChildrenModel.objJSON(Map<String, dynamic> parseJSON) {
    studentClass = parseJSON['id'];
    fname = parseJSON['fname'];
    studentClass = parseJSON['class'];
    room = parseJSON['room'];
    roomnt = parseJSON['room_nt'];
    score = parseJSON['score'];
    imagePath = parseJSON['imagePath'];
    parents = parseJSON['parents'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'fname => $fname, imagePath => $imagePath';
  }

}
