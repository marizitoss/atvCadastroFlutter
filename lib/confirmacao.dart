import 'package:flutter/material.dart';

class Confirmacao extends StatefulWidget {
  const Confirmacao({
    super.key,
    required this.title,
    required this.nome,
    required this.idade,
    required this.email,
    required this.genero,
    required this.aceitouTermos,
  });

  final String title;
  final String nome;
  final int idade;
  final String email;
  final String genero;
  final bool aceitouTermos;

  @override
  State<Confirmacao> createState() => _ConfirmacaoState();
}

class _ConfirmacaoState extends State<Confirmacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ConfirmacaoCard(
                nome: widget.nome,
                idade: widget.idade,
                email: widget.email,
                genero: widget.genero,
                aceitouTermos: widget.aceitouTermos,
              ),
            ],
          ),
        )
    );
  }
}

class ConfirmacaoCard extends StatelessWidget {
  const ConfirmacaoCard({
    super.key,
    required this.nome,
    required this.idade,
    required this.email,
    required this.genero,
    required this.aceitouTermos,
  });

  final String nome;
  final int idade;
  final String email;
  final String genero;
  final bool aceitouTermos;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confirme seus dados:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Text('Nome: $nome'),
            Text('Idade: $idade'),
            Text('Email: $email'),
            Text('Gênero: $genero'),
            Text('Aceitou termos: ${aceitouTermos ? "Sim" : "Não"}'),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Cadastro confirmado!')),
                    );
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
