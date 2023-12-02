import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuncstore/cubits/cubits.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "/forgetpassword";
  ForgetPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ForgetPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Sıfırla'),
      ),
      body: BlocConsumer<PasswordResetCubit, PasswordResetState>(
        listener: (context, state) {
          if (state is PasswordResetSuccess) {
            // Şifre sıfırlama başarılı ise kullanıcıyı bilgilendir
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Şifre sıfırlama e-postası gönderildi.'),
              ),
            );
          } else if (state is PasswordResetFailure) {
            // Şifre sıfırlama başarısız ise hata mesajını göster
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hata: ${state.error}'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'E-posta'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    if (email.isNotEmpty) {
                      // E-posta alanı boş değilse şifre sıfırlama e-postası gönder
                      context
                          .read<PasswordResetCubit>()
                          .passwordReset(email: email, context: context);
                    } else {
                      // E-posta alanı boş ise kullanıcıyı uyar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Lütfen bir e-posta adresi girin.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Şifremi Sıfırla'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
