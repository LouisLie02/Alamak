import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'provider.dart';

class Profile extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  Profile() : super();

  @override
  Widget build(BuildContext context) {
    final bioProvider = Provider.of<BioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: bioProvider.image != null
                    ? Image.file(
                        File(bioProvider.image!),
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 198, 198, 198)),
                        width: 200,
                        height: 200,
                        child: Icon(Icons.camera_alt, color: Colors.grey[800]),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      bioProvider.setImage(image.path);
                    }
                  },
                  child: Text('Take Image'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinBox(
                  max: 10.0,
                  min: 0.0,
                  value: bioProvider.score,
                  decimals: 1,
                  step: 0.1,
                  decoration: InputDecoration(labelText: 'Decimals'),
                  onChanged: (value) => bioProvider.setScore(value),
                ),
              ),
              TextFormField(
                initialValue: bioProvider.name,
                onChanged: (newValue) {
                  bioProvider.setName(newValue);
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),

              ElevatedButton(
                onPressed: () {
                  bioProvider.saveBio();
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
