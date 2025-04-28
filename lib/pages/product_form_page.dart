import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.isAbsolute ?? false;
    bool endsWithFile =
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData).then((value) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [IconButton(onPressed: _submitForm, icon: Icon(Icons.save))],
      ),
      body: _isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: InputDecoration(labelText: 'Nome:'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted:
                    (_) => {FocusScope.of(context).requestFocus(_priceFocus)},
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  final name = _name ?? '';

                  if (name.trim().isEmpty) {
                    return 'O nome do produto é obrigatório.';
                  }

                  if (name.trim().length < 3) {
                    return 'O nome deve conter pelo menos 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: InputDecoration(labelText: 'Preço:'),
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted:
                    (_) => {
                      FocusScope.of(context).requestFocus(_descriptionFocus),
                    },
                onSaved:
                    (price) => _formData['price'] = double.parse(price ?? '0'),
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: InputDecoration(labelText: 'Descrição:'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved:
                    (description) =>
                        _formData['description'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';

                  if (description.trim().isEmpty) {
                    return 'A descrição é obrigatória.';
                  }

                  if (description.trim().length < 10) {
                    return 'A descrição precisa no mínimo de 10 letras.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Insira a Url da imagem:',
                      ),
                      focusNode: _imageUrlFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      maxLines: null,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => _submitForm(),
                      onSaved:
                          (imageUrl) => _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';

                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma URL válida!';
                        }

                        return null;
                      },
                    ),
                  ),
                  Tooltip(
                    message:
                        'Se a sua URL não conter os formatos de imagens ou correlatos, ela não irá funcionar. Se não houver, insira no final da URL.',
                    padding: EdgeInsets.all(5),
                    child: Icon(size: 25, Icons.help_outline),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(top: 5, left: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    alignment: Alignment.center,
                    child:
                        _imageUrlController.text.isEmpty
                            ? Text('Informe a url')
                            : FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(_imageUrlController.text),
                            ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
