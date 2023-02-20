import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';

import 'package:flutter/material.dart';
import 'dart:math';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();
  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Map<String, Object> formData = {};

  @override
  void initState() {
    super.initState();
    imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        formData['id'] = product.id;
        formData['price'] = product.price;
        formData['name'] = product.name;
        formData['description'] = product.description;
        formData['imageUrl'] = product.imageUrl;

        imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlFocus.removeListener(updateImage);

    imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('png') ||
        url.toLowerCase().endsWith('jpg') ||
        url.toLowerCase().endsWith('jpeg');

    return isValidUrl && endsWithFile;
  }

  void submitForm() {
    final bool isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    formKey.currentState?.save(); //faz a chamada dos campos onSaved
    //print(formData.values);

    Provider.of<ProductList>(context, listen: false).saveProduct(formData);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Produto"),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: formData['name']?.toString(),
                decoration: InputDecoration(labelText: 'Nome'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(priceFocus);
                },
                onSaved: (name) => formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return "Nomé é obrigatório";
                  }

                  if (name.trim().length < 3) {
                    return "Nome precisa no mín. 3 letras";
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: formData['price']?.toString(),
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                focusNode: priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(descriptionFocus);
                },
                onSaved: (price) =>
                    formData['price'] = double.parse(price ?? '0'),
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price < 0) {
                    return "Preço inválido";
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                initialValue: formData['description']?.toString(),
                decoration: InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    formData['description'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return "Descrição é obrigatória";
                  }

                  if (description.trim().length < 10) {
                    return "Descrição precisa no mín. 10 letras";
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (_) => submitForm(),
                      decoration: InputDecoration(labelText: 'URL'),
                      textInputAction: TextInputAction.done,
                      focusNode: imageUrlFocus,
                      keyboardType: TextInputType.url,
                      controller: imageUrlController,
                      onSaved: (imageUrl) =>
                          formData['imageUrl'] = imageUrl ?? '',
                      validator: (_url) {
                        final url = _url ?? '';

                        if (!isValidUrl(url)) {
                          return "Informe uma URL válida";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
