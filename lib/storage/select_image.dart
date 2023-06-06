import 'package:image_picker/image_picker.dart';

import 'dart:html' as html;

Future getImage() async {
  final picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile;
}

Future<html.File> getImageWeb() async {
  final html.FileUploadInputElement input = html.FileUploadInputElement();
  input.accept = 'image/*'; // Permite solo archivos de imagen
  input.click(); // Abre el diálogo de selección de archivo
  
  await input.onChange.first; // Espera a que se seleccione un archivo
  
  if (input.files!.isNotEmpty) {
    return input.files!.first;
  }
  
  throw Exception('No se seleccionó ninguna imagen.');
}

Future<String> getImageUrl(html.File file) {
  final reader = html.FileReader();
  reader.readAsDataUrl(file);
  
  return reader.onLoadEnd.first.then((value) {
    return reader.result as String;
  });
}