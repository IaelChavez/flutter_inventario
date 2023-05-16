class User {
  final String id;
  final String name;
  final String lastName;
  final String age;
  final String gender;
  final String email;
  final String password;

  User(
    {
      required this.id, 
      required this.name, 
      required this.lastName, 
      required this.age, 
      required this.gender, 
      required this.email, 
      required this.password
    }
  );
}