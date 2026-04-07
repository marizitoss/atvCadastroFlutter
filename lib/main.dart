import 'package:flutter/material.dart';
import 'package:atv_cadastro/confirmacao.dart';

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
        useMaterial3: true,
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
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const FormCadastro(),
    );
  }
}

class FormCadastro extends StatefulWidget {
  const FormCadastro({super.key});

  @override
  State<FormCadastro> createState() => _FormCadastroState();
}

class _FormCadastroState extends State<FormCadastro> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool aceitouTermos = false;
  String? generoSelecionado;

  _trocarTela() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Confirmacao(
            title: 'Confirmação',
            nome: _nomeController.text,
            idade: int.parse(_idadeController.text),
            email: _emailController.text,
            genero: generoSelecionado!,
            aceitouTermos: aceitouTermos,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Preencha os campos abaixo:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo "nome" não pode ser vazio.'
                      : null,
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _idadeController,
                  decoration: const InputDecoration(
                    labelText: 'Idade',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua idade';
                    }
                    final idade = int.tryParse(value);
                    if (idade == null || idade < 18) {
                      return 'Você deve ter 18 para prosseguir';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo "email" não pode ser vazio.';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Insira um email válido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: "Selecione o Gênero",
                    border: OutlineInputBorder(),
                  ),
                  value: generoSelecionado,
                  items: ['Masculino', 'Feminino', 'Outro']
                      .map(
                        (valor) =>
                            DropdownMenuItem(value: valor, child: Text(valor)),
                      )
                      .toList(),
                  onChanged: (valor) {
                    setState(() {
                      generoSelecionado = valor;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Selecione um gênero.' : null,
                ),

                const SizedBox(height: 16),

                FormCheckbox(
                  onChanged: (value) {
                    aceitouTermos = value ?? false;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _trocarTela,
                  child: const Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormCheckbox extends FormField<bool> {
  FormCheckbox({super.key, required Function(bool?) onChanged})
    : super(
        initialValue: false,
        validator: (value) {
          if (value != true) {
            return 'Aceite os termos de uso para continuar';
          }
          return null;
        },
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: const Text('Aceito os termos de uso'),
                value: state.value,
                onChanged: (value) {
                  state.didChange(value);
                  onChanged(value);
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    state.errorText!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          );
        },
      );
}
