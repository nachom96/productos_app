import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;
  
  ProductFormProvider( this.product );

  updateAvailability(bool value){
    product.avaliable = value;
    notifyListeners();
  }



  bool isValidForm(){
    print( product.name);
    print( product.price);
    print( product.avaliable);
    return formKey.currentState?.validate() ?? false;
  }

}