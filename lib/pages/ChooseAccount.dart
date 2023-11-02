
import 'package:disiniwork/components/CustomButton.dart';
import 'package:flutter/material.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffefeff),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
                Image.asset('lib/images/create_account_polygon.png',height: 100, width: 100),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Choose your account',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 30
                      )
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child:Text(
                    'Lorium spun doller sit amit test description Lorium spun doller sit amit test ',
                    style: TextStyle(color: Color(0xff9d9d9d),fontSize: 12),
                  ),
                ),

                const SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    // You can customize the card's appearance with properties like elevation, shape, and color.
                    elevation: 4, // The shadow depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2), // Custom border shape
                    ),
                    color: Colors.white, // Background color of the card
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('lib/images/gigs_icon.png',height: 40, width: 40,),
                          const SizedBox(width: 10,),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GIGs",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff031a38),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                "Lorem Ipsum is simply dummy text,",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000000),
                                ),
                                textAlign: TextAlign.justify,
                              )
                            ],
                          ),
                          const SizedBox(width: 10,),
                          Image.asset(
                            'lib/images/arrow-down.png',
                            height: 40,
                            width: 40,
                          )
                        ],
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    // You can customize the card's appearance with properties like elevation, shape, and color.
                    elevation: 4, // The shadow depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2), // Custom border shape
                    ),
                    color: Colors.white, // Background color of the card
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('lib/images/gigs_icon.png',height: 40, width: 40,),
                            const SizedBox(width: 10,),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CLIENTs",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff031a38),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "Lorem Ipsum is simply dummy text,",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                            const SizedBox(width: 10,),
                            Image.asset(
                              'lib/images/arrow-down.png',
                              height: 40,
                              width: 40,
                            )
                          ],
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 100,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(onPressed: () => {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()))
                  },btnText: 'CONTINUE',),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
