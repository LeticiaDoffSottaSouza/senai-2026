import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InvestmentSimulator(),
    );
  }
}

class InvestmentSimulator extends StatefulWidget {
  const InvestmentSimulator({super.key});

  @override
  State<InvestmentSimulator> createState() => _InvestmentSimulatorState();
}

class _InvestmentSimulatorState extends State<InvestmentSimulator> {
  double investimentoMensal = 0.0;
  int numeroMeses = 0;
  double taxaJuros = 0.0;
  double montanteSemJuros = 0.0;
  double montanteComJuros = 0.0;
  bool resultadoVisivel = false;

  void calcular() {
    if (investimentoMensal == 0 || numeroMeses == 0 || taxaJuros == 0) {
      setState(() {
        resultadoVisivel = true;
        montanteSemJuros = 0;
        montanteComJuros = 0;
      });
    } else {
      double i = taxaJuros / 100;
      montanteSemJuros = investimentoMensal * numeroMeses;
      montanteComJuros = investimentoMensal * ((pow(1 + i, numeroMeses) - 1) / i);
      setState(() {
        resultadoVisivel = true;
      });
    }
  }

  void alert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Resultado"),
          content: Text(msg),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Simulador de Investimentos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFC51077),
      ),
      body: Container(
        color: const Color(0xFFF5E6E8),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Investimento mensal:"),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite o valor",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => investimentoMensal = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 20),
                const Text("Número de meses:"),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Quantos meses deseja investir",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => numeroMeses = int.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 20),
                const Text("Taxa de juros ao mês:"),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Digite a taxa de juros",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (v) => taxaJuros = double.tryParse(v) ?? 0,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    calcular();
                    if (resultadoVisivel) {
                      alert(
                        context,
                        "Valor total com juros compostos: R\$ ${montanteComJuros.toStringAsFixed(2)}",
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC51077),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    "Simular",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                if (resultadoVisivel)
                  Column(
                    children: [
                      Text(
                        "Valor total sem juros: R\$ ${montanteSemJuros.toStringAsFixed(2)}",
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Valor total com juros compostos: R\$ ${montanteComJuros.toStringAsFixed(2)}",
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