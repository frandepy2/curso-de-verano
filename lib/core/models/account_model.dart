

// Esta clase sera el encargado de guardar como objeto los datos de usuario.


class AccountModel {
  final String uid;
  final String email;
  final String photoURL;
  final String name;
  final String phoneNumber;
  final String birthday;


  AccountModel({ required this.phoneNumber,required this.email, required this.photoURL, required this.name, required this.birthday, required this.uid});

  Map<String, Object> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'name': name,
      'birthday': birthday
    };
  }

  factory AccountModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return AccountModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoURL: snapshot['photoURL'],
      phoneNumber: snapshot['phone'],
      name: snapshot['name'],
      birthday: snapshot['birthday'],
    );
  }


  String toQRString() {
    return '''
      "uid" : $uid,
      "email" : $email,
      "photoURL" : $photoURL,
      "phoneNumber" : $phoneNumber,
      "name" : $name,
      "birthday" : $birthday,
    ''';
  }
}