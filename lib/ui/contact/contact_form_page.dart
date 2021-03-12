import 'package:chat_balcoder/ui/contact/contact_service.dart';
import 'package:chat_balcoder/ui/contact/model/ContactModel.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatefulWidget {
  ContactFormPage ({this.contactModel});
  ContactModel contactModel;
  @override
  _ContactFormPageState createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  TextEditingController _nombreContacto = new TextEditingController();
  TextEditingController _numeroContacto = new TextEditingController();
  ContactService _contactService = new ContactService(); //usar metodo
  List<ContactModel> _contactList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.contactModel.contactKey != null){
      //Actualizar
      _numeroContacto.text = widget.contactModel.phoneNumber;
      _nombreContacto.text = widget.contactModel.contactName;

    }else{
      //Contacto nuevo
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xff0D5F64),
      title: Text("ContactPage"),
      ),
      backgroundColor: Color(0xffe9fbfc),
      body: Padding(
        padding: const EdgeInsets.only(top: 35.0, left: 35.0, right: 35.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nombreContacto,
              decoration: InputDecoration(icon: Icon(Icons.person, color: Color(0xff0F6B70),),
              labelText: "Nombre de contacto",
              labelStyle: TextStyle(color: Color(0xff0F6B70)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color(0xff0F6B70))),
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), 
              borderSide: BorderSide(color: Color(0xff17A8B0)))
              ),
            ),
            SizedBox(height: 25.0,),
            TextFormField(
              controller: _numeroContacto,
              decoration: InputDecoration(icon: Icon(Icons.phone_android, color: Color(0xff0F6B70),),
              labelText: "Numero de contacto",
              labelStyle: TextStyle(color: Color(0xff0F6B70)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Color(0xff0F6B70))),
              enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), 
              borderSide: BorderSide(color: Color(0xff17A8B0)))
              ),
            ),
            SizedBox(height: 50.0,),
            Container(
              height: 40,
              width: 150,
              child: TextButton.icon(
              
              icon: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(Icons.person_add_alt_1),
              ),
                           
              label: Text("GUARDAR"),
              style: TextButton.styleFrom(primary: Colors.white, backgroundColor: Color(0xff0F6B70), shadowColor: Colors.black, elevation: 15.0, 
              textStyle: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.bold)),
              onPressed: (){

                if (widget.contactModel.contactKey != null){

                  widget.contactModel.contactName= _nombreContacto.text;
                  widget.contactModel.phoneNumber= _numeroContacto.text;
                  _contactService.updateContact(widget.contactModel);
                }
                else{
                _contactService.addContact(new ContactModel(contactName: _nombreContacto.text, phoneNumber: _numeroContacto.text, isDeleted: false));
                _nombreContacto.text = "";
                _numeroContacto.text = "";
                showAlertDialog(context);
                }

                
              },),
            )

          ],
        ),
      ),
      
    );
  }
}

showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = FlatButton(
    child: Text("Aceptar"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("¡Exitoso!"),
    content: Text("Se ha agregado un nuevo contacto."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}