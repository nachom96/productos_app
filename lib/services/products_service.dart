import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {

  final String _baseUrl = 'flutter-varios-32494-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Product> products = [];

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  late Product selectedProduct;

  ProductsService() {
    loadProducts();
  }
  
  // Future<List<Product>>
  Future loadProducts() async {
    
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    // Decodificar json
    final Map<String, dynamic> productsMap = json.decode( resp.body );

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap( value );
      tempProduct.id = key;
      products.add(tempProduct);
     }); 

     isLoading = false;
     notifyListeners();

     // return products;
  }

  Future saverOrCreateProduct( Product product ) async {

    isSaving = true;
    notifyListeners();

    if ( product.id == null ){
      // Es necesario crear
      await createProduct(product);
    } else{
      // Actualizar
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();

  }

  Future<String> updateProduct ( Product product ) async {

    final url = Uri.https(_baseUrl, 'products/${ product.id }.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    print( decodedData );

    // Se puede hacer también con un forEach

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;

  }

  Future<String> createProduct ( Product product ) async {

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode( resp.body );

    product.id = decodedData['name'];
    
    products.add(product);
    return product.id!;

  }

  void updateSelectedProductImage( String path ){
    
    selectedProduct.picture = path;
    newPictureFile = File.fromUri( Uri(path: path));

    notifyListeners();    

  }

  Future<String?> uploadImage( ) async{
    
    if( newPictureFile == null ) return null;
    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dnvu6nl6b/image/upload?upload_preset=erdvktjf');
    
    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salió mal');
      print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];

  }

 }