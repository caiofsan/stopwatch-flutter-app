class Record {
  final String uid;
  final double runtime;
  final int laps;
  final DateTime? timestp;

  Record(this.uid, this.runtime, this.laps, this.timestp);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'runtime': runtime, 'laps': laps, 'timestp': timestp};
  }

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(json['uid'], json['runtime'], json['laps'], json['timestp']);
  }
}
