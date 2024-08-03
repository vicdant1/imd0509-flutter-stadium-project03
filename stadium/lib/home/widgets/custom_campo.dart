// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CampoGeralWidget extends StatelessWidget {
  String? valorSelecionado;
  String? texto;
  int? valorSelecionadoInt;
  List<DropdownMenuItem<String>>? items;
  List<DropdownMenuItem<int>>? itemsInt;
  void Function(String?)? onChanged;
  void Function(int?)? onChangedInt;
  double? width;
  bool isInt;
  bool obrigatorio;

  CampoGeralWidget({
    Key? key,
    this.valorSelecionado,
    this.texto,
    this.valorSelecionadoInt,
    this.items,
    this.itemsInt,
    this.onChanged,
    this.onChangedInt,
    this.width,
    this.isInt = false,
    this.obrigatorio = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDropdownString();
  }

  Widget _buildDropdownString() => Container(
        decoration: BoxDecoration(
            color: const Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField(
              isDense: true,
              isExpanded: true,
              dropdownColor: Colors.white,
              value: valorSelecionado == '' ? null : valorSelecionado,
              focusColor: Colors.white,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Color(0xff999999),
              ),
              onChanged: onChanged,
              items: items,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              validator: (String? text) {
                if (obrigatorio && (text?.isEmpty ?? true)) {
                  return 'Escolha um tipo';
                }

                return null;
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(17),
                filled: true,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 166, 166, 166),
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
                isDense: true,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: const Color(0xffDADADA).withOpacity(0.5),
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: const Color(0xffDADADA).withOpacity(0.5),
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
