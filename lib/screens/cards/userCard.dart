import 'package:flutter/material.dart';
import 'package:practica_inventario/Model/UserModel.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              color: Colors.blue,
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildUserDetailRow('Name:', user.name),
                    SizedBox(height: 8),
                    buildUserDetailRow('Last Name:', user.lastName),
                    SizedBox(height: 8),
                    buildUserDetailRow('Age:', user.age),
                    SizedBox(height: 8),
                    buildUserDetailRow('Gender:', user.gender),
                    SizedBox(height: 8),
                    buildUserDetailRow('Email:', user.email),
                    SizedBox(height: 8),
                    buildUserDetailRow('Password:', user.password),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}