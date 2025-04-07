import 'package:flutter/material.dart';
import 'height.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final List<Map<String, dynamic>> genderOptions = [
    {'id': 'male', 'label': 'Male', 'isSelected': true, 'image': 'assets/pics/new_male_image.avif'},
    {'id': 'female', 'label': 'Female', 'isSelected': false, 'image': 'assets/pics/new_female_image.avif'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEEE8),
      body: Center(
        child: SizedBox(
          width: 393,
          height: 852,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 89),
              Text(
                'Gender',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 24, color: Colors.black),
              ),
              SizedBox(height: 15),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (rowIndex) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(1, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: 5,
                        width: 55,
                        margin: EdgeInsets.fromLTRB(1, 2, 14, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: rowIndex == 0
                                ? [
                                    Color(0xFFB19589),
                                    Color(0xFFB19589),
                                  ]
                                : [
                                    Color(0xFFDECEC7),
                                    Color(0xFFDECEC7),
                                  ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              SizedBox(height: 25),
              Text(
                'Tell Us About Yourself',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 27, fontWeight: FontWeight.w400, color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                'Select Your Gender to get a better\nExperience and result',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w300, color: Color(0xFF909090)),
              ),
              SizedBox(height: 40),
              Card(
                color: Color(0xFFB09489),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 0,
                child: Container(
                  width: 363,
                  height: 235,
                  padding: EdgeInsets.all(26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: genderOptions.map((gender) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            for (var g in genderOptions) {
                              g['isSelected'] = false;
                            }
                            gender['isSelected'] = true;
                          });
                        },
                        child: Container(
                          width: 145,
                          height: 171,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (gender['isSelected'])
                                Positioned(
                                  top: -1,
                                  right: 2,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 196, 121, 89),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(Icons.check, size: 15, color: Colors.white),
                                  ),
                                ),
                              Positioned(
                                top: 33,
                                child: Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 255, 237, 232),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      gender['image'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                child: Text(
                                  gender['label'],
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: gender['isSelected'] ? FontWeight.w600 : FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 183),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HeightScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFB09489),
                  minimumSize: Size(364, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GenderScreen(),
  ));
}