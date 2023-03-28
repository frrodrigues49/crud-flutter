import 'package:crudflutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/user.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  void _loadFormData(user) {
    if (user != null) {
      _formData['id'] = user.id ?? '';
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments;

    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de usuario"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState!.save();
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'] ?? '',
                    name: _formData['name'] ?? '',
                    email: _formData['email'] ?? '',
                    avatarUrl: _formData['avatarUrl'] ?? '',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo obrigatório!";
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!),
              TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: "E-mail"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo obrigatório!";
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['email'] = value!),
              TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: "Url do Avatar"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo obrigatório!";
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['avatarUrl'] = value!),
            ],
          ),
        ),
      ),
    );
  }
}
