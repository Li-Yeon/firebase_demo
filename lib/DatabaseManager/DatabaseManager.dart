import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  
Future createUser({required String name}) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();

  final user = User(
    id: docUser.id,
    name: name,
  );
  
  final json = user.toJson();
  await docUser.set(json);

  }
}

class User{
String id;
final String name;

User({
  this.id = '',
  required this.name,
});

Map<String, dynamic> toJson() => {
  'id': id,
  'name': name,
};

static User fromJson(Map<String, dynamic> json) =>
      User(
      id: json['id'],
      name: json['name'],
    );

}

