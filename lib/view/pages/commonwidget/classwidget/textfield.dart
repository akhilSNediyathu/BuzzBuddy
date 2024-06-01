import 'package:buzz_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.icon,
      required this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.rightIcon,
      this.validator});

  final TextEditingController controller;
  final String hintText;
  final String? icon;
  final Widget? rightIcon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: textFieldBorderColor, width: 2.0),
              borderRadius: kradius20),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
              borderRadius: kradius20),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
              borderRadius: kradius20),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
              borderRadius: kradius20),
        ));
  }
}

class CustomTextField2 extends StatefulWidget {
  const CustomTextField2({
    super.key,
    required this.hintText,
    this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    // this.obscureText = false,
    this.validator,
  });

  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  // final bool obscureText;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

bool isObsecure = true;

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.all(0),
      child: StatefulBuilder(
        builder: (context, setState) {
          // bool isObscure = isObsecure;
          return TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: isObsecure,
            validator: widget.validator,
            decoration: InputDecoration(
              labelText: widget.hintText,
              labelStyle: TextStyle(fontWeight: FontWeight.w500),
              prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
              suffixIcon: IconButton(
                icon: Icon(
                  isObsecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: textFieldBorderColor, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
                borderRadius: kradius20,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: kradius20,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.redAccent, width: 2.0),
                borderRadius: kradius20,
              ),
            ),
          );
        },
      ),
    );
  }
}


// bool obsecure = true;

// class TextFormFieldPasswordRegister extends StatefulWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String? Function(String?)? validator;

//   const TextFormFieldPasswordRegister({
//     super.key,
//     required this.controller,
//     required this.hintText,
//     this.validator,
//   });

//   @override
//   State<TextFormFieldPasswordRegister> createState() =>
//       _TextFormFieldPasswordRegisterState();
// }

// class _TextFormFieldPasswordRegisterState
//     extends State<TextFormFieldPasswordRegister> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorWidth: 2,
//       controller: widget.controller,
//       validator: widget.validator,
//       cursorColor: Colors.black,
//       style: const TextStyle(fontWeight: FontWeight.w600),
//       decoration: InputDecoration(
//           fillColor: Colors.amber,
//           filled: true,
//           hintText: widget.hintText,
//           border: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black45)),
//           focusedBorder:
//               const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
//           enabledBorder:
//               const OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
//           suffixIcon: IconButton(
//               onPressed: () {
//                 setState(() {
//                   obsecure = !obsecure;
//                 });
//               },
//               icon: obsecure == true
//                   ? const Icon(
//                       Icons.visibility_off,
//                       color: Colors.grey,
//                     )
//                   : const Icon(Icons.visibility, color: Colors.grey))),
//       obscureText: obsecure,
//     );
//   }
// }