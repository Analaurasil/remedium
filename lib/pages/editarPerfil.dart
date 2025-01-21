import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TelaEditarPerfil extends StatefulWidget {
  @override
  _TelaEditarPerfilState createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  //final _dataNascController = TextEditingController();
  //final _emailController = TextEditingController();
  //final _senhaController = TextEditingController();
Future getImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('Nenhuma imagem Selecionada');
    }
  });
}
  /*Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('Nenhuma imagem Selecionada');
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Imagem de perfil
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: getImage,
                      ),
                    ),
                  ],
                ),
                // Campos de texto
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                // ... outros campos (data de nascimento, email, senha)
                // Botões
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para salvar as alterações
                        if (_formKey.currentState!.validate()) {
                          // Enviar os dados para o servidor
                        }
                      },
                      child: Text('Salvar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para cancelar as alterações
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}