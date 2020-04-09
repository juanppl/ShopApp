import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/src/models/product_model.dart';
import 'package:shop_app/src/providers/products_provider.dart';

class EditProductPage extends StatefulWidget {
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Map<String, Object> _data = {};
  ProductModel _createdProduct;
  bool _isInit = true;
  String _productId;
  Map<String, Object> _initData = {
    'title':'',
    'price':'',
    'description':'',
    'imageUrl':'',
  };

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      _productId = ModalRoute.of(context).settings.arguments;
      if(_productId != null){
        _createdProduct = Provider.of<ProductsProvider>(context).findProductById(_productId);
        _initData = {
          'title':_createdProduct.title,
          'price':_createdProduct.price.toString(),
          'description':_createdProduct.description,
          'imageUrl':_createdProduct.imageUrl,
        };
        _imageUrlController.text = _createdProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveFormData() {
    bool _isCorrect = _formKey.currentState.validate();
    if (_isCorrect) {
      _formKey.currentState.save();
    } else {
      return;
    }
    
    if(_createdProduct.id == null){
      _createdProduct = ProductModel(
          id: DateTime.now().toString(), 
          title: _data['title'], 
          description: _data['description'], 
          price: double.parse(_data['price']), 
          imageUrl: _data['imageUrl'],
        );
      Provider.of<ProductsProvider>(context,listen: false).addProduct(_createdProduct);
    }else{
      _createdProduct = ProductModel(
          id: _productId, 
          title: _data['title'], 
          description: _data['description'], 
          price: double.parse(_data['price']), 
          imageUrl: _data['imageUrl'],
        );
      Provider.of<ProductsProvider>(context,listen: false).updateProduct(_productId, _createdProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveFormData,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _initData['title'],
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _data.addAll({'title': value});
                },
                validator: (value) {
                  if (value.length > 0) {
                    return null;
                  } else {
                    return 'You have to enter a title';
                  }
                },
              ),
              TextFormField(
                initialValue: _initData['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _data.addAll({'price': value.replaceAll(',', '.')});
                },
                validator: (value) {
                  if (value.length < 0) {
                    return 'You have to enter a price';
                  }
                  value = value.replaceAll(',', '.');
                  if (double.tryParse(value) == null) {
                    return 'You have to enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initData['description'],
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value) {
                  _data.addAll({'description': value});
                },
                validator: (value) {
                  if (value.length > 0) {
                    return null;
                  } else {
                    return 'You have to enter a description';
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL image')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _imageUrlController,
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlNode,
                      onFieldSubmitted: (_) {
                        _saveFormData();
                      },
                      onSaved: (value) {
                        _data.addAll({'imageUrl': value});
                      },
                      validator: (value) {
                        if (value.length < 0) {
                          return 'You have to enter a imageUrl';
                        }
                        if (!value.startsWith('http')) {
                          return 'You have to enter a valid imageUrl';
                        }
                        return null;
                      },
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
