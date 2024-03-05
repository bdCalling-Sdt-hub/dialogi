


class LocalTime {
  static String localTime(String createdAt) {
    DateTime localTime = DateTime.parse(createdAt).toLocal();
    var time = localTime.toString().split(" ")[1];
    var hour = time.split(":")[0];
    var minute = time.split(":")[1].split(":")[0];

    return "$hour:$minute";
  }

}