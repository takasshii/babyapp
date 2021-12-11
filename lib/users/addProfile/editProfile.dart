import 'package:babyapp/users/addProfile/editProfileModel.dart';
import 'package:babyapp/domain/user.dart';
import 'package:babyapp/users/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  final UserDetail user;
  const EditProfile(this.user);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(user),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Color(0xff181E27),
              title: Text(
                "Edit Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0.0,
            ),
            backgroundColor: Color(0xff181E27),
            body: Consumer<EditProfileModel>(builder: (context, model, child) {
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black,
                          border: Border.all(width: 2),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Image.file(model.imageFile!)
                              : user.imageURL != null
                                  ? Image.network(user.imageURL!)
                                  : Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 70,
                                      color: Color(0x98FFFFFF),
                                    ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () async {
                            await model.showImagePicker();
                          },
                          child: const Text(
                            'Change Photo',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            minimumSize: Size(150, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        //Statusを取得
                        padding: EdgeInsets.only(top: 20),
                        width: double.infinity,
                        child: Text(
                          "About You",
                          style: TextStyle(
                            color: Color(0x98FFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: model.nameController,
                          onChanged: (text) {
                            model.setName(text);
                          },
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color(0x98FFFFFF),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        child: Row(
                          children: [
                            /*new RadioListTile(
                                  activeColor: Colors.deepPurpleAccent,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text('Female'),
                                  value: 'female',
                                  groupValue: "gender",
                                   onChanged:(value) {
                                    //todo
                                  },
                                ),
                                new RadioListTile(
                                  activeColor: Colors.deepPurpleAccent,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  title: Text('Male'),
                                  value: 'male',
                                  groupValue: "gender",
                                  onChanged:(value) {
                                    //todo
                                  },
                                ),*/
                          ],
                        ),
                      ),
                      Container(
                        //Statusを取得
                        padding: EdgeInsets.only(top: 40),
                        width: double.infinity,
                        child: Text(
                          "Baby's Info",
                          style: TextStyle(
                            color: Color(0x98FFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: model.babyNameController,
                          onChanged: (text) {
                            model.setBabyName(text);
                          },
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color(0x98FFFFFF),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: model.babyBirthController,
                          onTap: () {
                            //ドラムロール式の生年月日選択ができるようにする
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(2018, 1, 1),
                                showTitleActions: true,
                                maxTime:
                                    DateTime.now().add(Duration(days: 360)),
                                onConfirm: (text) {
                              model.setBabyBirthDay(text);
                              model.babyBirthDay = text;
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.jp);
                          },
                          keyboardType: TextInputType.name,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            filled: true,
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Color(0x98FFFFFF),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 32),
                        child: ElevatedButton(
                          onPressed: model.isUpdated()
                              ? () async {
                                  model.startLoading;
                                  // 追加の処理
                                  try {
                                    await model.update();
                                    Navigator.of(context).pop(true);
                                  } catch (e) {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(e.toString()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                  model.endLoading();
                                }
                              : null,
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurpleAccent,
                            onPrimary: Colors.white,
                            minimumSize: Size(300, 60),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          Consumer<EditProfileModel>(builder: (context, model, child) {
            return model.isLoading
                ? Container(
                    color: Colors.grey.withOpacity(0.7),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
