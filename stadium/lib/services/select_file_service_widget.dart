// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:stadium/autenticacao/autenticacao_controller.dart';
import 'package:stadium/services/files_service.dart';

class SelectFileService extends StatelessWidget {
  const SelectFileService({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<AutenticacaoController>();
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildOption(
            icon: Icons.photo,
            label: 'Galeria',
            onTap: () async {
              controller.fotoPerfilCadastro = await pickImageFromGallery();
              Navigator.of(context).pop();
            },
          ),
          buildOption(
            icon: Icons.archive,
            label: 'Arquivo',
            onTap: () async {
              controller.fotoPerfilCadastro = await pickImageFromFolders();
              Navigator.of(context).pop();
            },
          ),
          buildOption(
            icon: Icons.camera_alt,
            label: 'Tirar foto',
            onTap: () async {
              controller.fotoPerfilCadastro = await captureImageFromCamera();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget buildOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff09554B).withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  icon,
                  size: 30,
                  color: const Color(0xff09554B),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
