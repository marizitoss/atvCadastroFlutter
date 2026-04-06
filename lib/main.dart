import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuários',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const MyHomePage(title: 'Cadastro de Usuários'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FormCadastro(),
    );
  }
}

class FormCadastro extends StatefulWidget {
  @override
  State<FormCadastro> createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  bool isChecked = false;
  String? generoSelecionado;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text('Preencha os campos abaixo:'),
          const TextField(
            decoration: InputDecoration(
              label: Text('Nome'),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              label: Text('Idade'),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              label: Text('Email'),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          DropdownButton<String>(
            isExpanded: true,
            hint: const Text("Selecione o Gênero"),
            value: generoSelecionado,
            items: ['Masculino', 'Feminino', 'Outro'].map((String valor) {
              return DropdownMenuItem<String>(value: valor, child: Text(valor));
            }).toList(),
            onChanged: (valor) {
              setState(() {
                generoSelecionado = valor;
              });
            },
          ),
          Row(
            children: [
              const Text('Aceito os termos de uso'),
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // add a logica do cadastro, criar uma classe pra isso e chamar aqui
            },
            child: const Text('Cadastrar'),
          ),
        ],
      ),
    );
  }
}

class DadosUsuario {
  final String nome;
  final int idade;
  final String email;

  DadosUsuario(this.nome, this.idade, this.email);

}