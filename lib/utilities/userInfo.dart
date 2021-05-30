class UserInfo {
  String? userName;
  String? email;
  String? phone;
  String? password;

  UserInfo({
    this.userName,
    this.email,
    this.phone,
    this.password,
});

  List<String> getFirstLastName() {
    if (userName == null) {
      return <String>[];
    }
    List<String> temp = userName!.split(' ');
    if (temp.length == 1) {
      return temp;
    }
    else {
      return <String>[temp.first, temp.last];
    }
  }
}