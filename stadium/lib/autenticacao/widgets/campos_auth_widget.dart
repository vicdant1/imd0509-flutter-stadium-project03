// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CamposAuthWidget extends StatefulWidget {
  final TextEditingController loginTextController;
  final TextEditingController senhaTextController;
  bool? isobscureText;
  final Key formKey;

  CamposAuthWidget({
    Key? key,
    required this.loginTextController,
    required this.senhaTextController,
    this.isobscureText,
    required this.formKey,
  }) : super(key: key);

  @override
  State<CamposAuthWidget> createState() => _CamposAuthWidgetState();
}

class _CamposAuthWidgetState extends State<CamposAuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.loginTextController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo email obrigatório *';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20),
              hintText: 'Email',
              filled: true,
              hintStyle: const TextStyle(
                color: Color(0xffBDBDBD),
                fontSize: 16,
              ),
              isDense: true,
              fillColor: const Color(0xffF6F6F6),
              focusColor: const Color(0xffF6F6F6),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xffC8C8C8).withOpacity(0.5),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xffC8C8C8).withOpacity(0.5),
                  width: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            child: TextFormField(
              obscureText: widget.isobscureText ?? false,
              controller: widget.senhaTextController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo senha obrigatório *';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                hintText: 'Senha',
                hintStyle: const TextStyle(
                  color: Color(0xffBDBDBD),
                  fontSize: 16,
                ),
                isDense: true,
                filled: true,
                suffix: GestureDetector(
                  onTap: () {
                    if (widget.isobscureText != null) {
                      widget.isobscureText = !widget.isobscureText!;
                    }
                    setState(() {});
                  },
                  child: const Text(
                    'Mostrar',
                    style: TextStyle(
                        color: Color(
                          0xff09554B,
                        ),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                fillColor: const Color(0xffF6F6F6),
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: const Color(0xffC8C8C8).withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: const Color(0xffC8C8C8).withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
