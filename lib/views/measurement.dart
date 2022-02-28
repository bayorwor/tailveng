import 'package:flutter/material.dart';

class Measurement extends StatelessWidget {
  const Measurement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 60,
                color: Colors.pink,
                child: const Text(
                  'Take measurement',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Form(
                  child: ListView(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter name client',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Gender',
                                    hintText: 'Enter your gender',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Style',
                                    hintText: 'Enter your style',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Waist',
                                    hintText: 'Enter your waist',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Breast',
                                    hintText: 'Enter your breast',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Hips',
                                    hintText: 'Enter your hips',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Skirt length',
                                    hintText: 'Enter your skirt length',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Total height',
                                    hintText: 'Enter your height',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Location',
                                    hintText: 'Enter your Location',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Text("Sample of Fabric"),
                      SizedBox(height: 18),
                      Image(image: AssetImage('assets/placeholder.jpg')),
                      SizedBox(height: 18),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text('Save measurement'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
