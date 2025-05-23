import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import '../providers/user_provider.dart';
import '../utils/theme_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    // Reproduzir o áudio da tela de entrada
    _playAudio();

    // Verificar autenticação após um breve delay para mostrar a splash screen
    // Usando WidgetsBinding.instance.addPostFrameCallback para garantir que o contexto está disponível
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        // Verificar se o widget ainda está montado antes de usar o context
        if (mounted) {
          checkAuth();
        }
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio() async {
    try {
      // Corrigido: Usar AssetSource corretamente
      await _audioPlayer.play(AssetSource('audio/feixedaloodscren.mp3'));
    } catch (e) {
      debugPrint('Erro ao reproduzir áudio: $e');
    }
  }

  void checkAuth() async {
    // Garantir que o contexto está disponível e o widget montado
    if (!mounted) return;
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // Verificar se o usuário está logado
    if (FirebaseAuth.instance.currentUser != null) {
      // Navegar para a tela principal
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      // Navegar para a tela de login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      body: Container(
        // Removido 'const' para evitar potenciais problemas com errorBuilder não-constante
        decoration: BoxDecoration(
          image: DecorationImage(
            // Corrigido: Caminho do asset sem escapes extras
            image: AssetImage('assets/images_png/1000146032.png'),
            fit: BoxFit.cover,
            opacity: 0.3, // Opacidade reduzida para não atrapalhar o conteúdo
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou imagem do app
              Image.asset(
                'assets/images/1000216621.png',
                width: 150,
                height: 150,
                // errorBuilder é válido, mas seu conteúdo não deve ser const se ele próprio não for
                errorBuilder: (context, error, stackTrace) {
                  // Container retornado não precisa ser const
                  return Container(
                    width: 150,
                    height: 150,
                    color: ThemeConstants.primaryColor,
                    child: Center(
                      child: Text(
                        'LAMAFIA',
                        // TextStyle não precisa ser const aqui
                        style: TextStyle(
                          color: ThemeConstants.textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Removido 'const' para consistência, embora provavelmente não cause erro aqui
              SizedBox(height: 24),
              Text(
                'LaMafia: Federação',
                // TextStyle não precisa ser const aqui
                style: TextStyle(
                  color: ThemeConstants.textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Removido 'const' para consistência
              SizedBox(height: 48),
              // Removido 'const' para consistência
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
