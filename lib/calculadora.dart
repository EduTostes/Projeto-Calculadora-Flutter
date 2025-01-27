import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'C';
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == 'DEL') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else if (valor == '.' &&
          (_expressao.isEmpty || _expressao.contains('.'))) {
        return;
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Não é possivel Calcular';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {}) as double;
  }

  Widget _botao(String valor, {Color? corFundo, Color? corTexto}) {
    return SizedBox(
      width: 70,
      height: 70,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: corFundo ?? Colors.grey.shade300,
        ),
        onPressed: () => _pressionarBotao(valor),
        child: Center(
          child: Text(
            valor,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: corTexto ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                _expressao,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                _resultado,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _botao('7'),
                _botao('8'),
                _botao('9'),
                _botao('÷', corFundo: Colors.orange, corTexto: Colors.white),
                _botao('4'),
                _botao('5'),
                _botao('6'),
                _botao('x', corFundo: Colors.orange, corTexto: Colors.white),
                _botao('1'),
                _botao('2'),
                _botao('3'),
                _botao('-', corFundo: Colors.orange, corTexto: Colors.white),
                _botao('0'),
                _botao('.'),
                _botao('DEL',
                    corFundo: Colors.red.shade400, corTexto: Colors.white),
                _botao('+', corFundo: Colors.orange, corTexto: Colors.white),
                _botao('C',
                    corFundo: Colors.red.shade600, corTexto: Colors.white),
                _botao('=', corFundo: Colors.green, corTexto: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
