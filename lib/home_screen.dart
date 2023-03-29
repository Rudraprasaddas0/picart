import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:picart/colors.dart';

import 'api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var sizes = ["Small", "Medium", "Large"];
  var values = ["256*256", "512*512", "1024*1024"];
  String? dropValue;
  var textController = TextEditingController();
  String image = '';
  var isLoded = false;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                backgroundColor: btnColor,
              ),
              onPressed: () {},
              child: const Text("My Arts"),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          "AI Image Generator",
          style: TextStyle(
            fontFamily: "poppins_italic",
            color: whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextFormField(
                            controller: textController,
                            decoration: const InputDecoration(
                              hintText: "eg 'sun using suncream' ",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon:
                                const Icon(Icons.expand_more, color: btnColor),
                            value: dropValue,
                            hint: const Text("Select Size"),
                            items: List.generate(
                              sizes.length,
                              (index) => DropdownMenuItem(
                                child: Text(sizes[index]),
                                value: values[index],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                dropValue = value.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 300,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btnColor,
                        shape: const StadiumBorder(),
                      ),
                      // onPressed: () async {
                      //   if (textController.text.isNotEmpty ) {
                      //    setState(() {
                      //       isLoded = false;
                      //    });
                      //     image = await Api.generateImage(
                      //         textController.text, dropValue!);
                      //     setState(() {
                      //       isLoded = true;
                      //     });
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       const SnackBar(
                      //         content:
                      //             Text("Please Pass the Query and the Size"),
                      //       ),
                      //     );
                      //   }
                      // },
                      onPressed: () async {
                        if (textController.text.isNotEmpty && dropValue != null) {
                          setState(() {
                            isLoded = false;
                          });
                          try {
                            image = await Api.generateImage(textController.text, dropValue!);
                            setState(() {
                              isLoded = true;
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Failed to fetch image"),
                              ),
                            );
                            setState(() {
                              isLoded = true;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please pass the query and the size"),
                            ),
                          );
                        }
                      },



                      child: const Text("Generate"),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: isLoded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                    Icons.download_for_offline_rounded),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  backgroundColor: btnColor,
                                ),
                                onPressed: () {},
                                label: const Text("Download"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.share),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(8),
                                backgroundColor: btnColor,
                              ),
                              onPressed: () {},
                              label: const Text("Share"),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: whiteColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/loder.gif"),
                          const SizedBox(height: 12),
                          const Text(
                            "Waiting for Image to be Generated...",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Developed by Rudra",
                style: TextStyle(color: whiteColor, fontSize: 14.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
