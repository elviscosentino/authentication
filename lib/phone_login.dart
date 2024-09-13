import 'package:authentication/phone_otp.dart';
import 'package:authentication/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class PhoneAuthentication extends StatefulWidget {
  const PhoneAuthentication({super.key});

  @override
  State<PhoneAuthentication> createState() => _PhoneAuthenticationState();
}

class _PhoneAuthenticationState extends State<PhoneAuthentication> {
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: (){
            myDialogBox(context);
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network("https://static.vecteezy.com/system/resources/thumbnails/010/829/986/small/phone-icon-in-trendy-flat-style-free-png.png",
                  height: 32,
                  color: Colors.white,
                ),
              ),
              const Text("  Login com celular",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              )
            ],
          ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Login com Celular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Digite seu celular",
                            hintText: "+5551991234567"
                        )
                    ),
                    const SizedBox(height: 20),
                    isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        onPressed: () async{
                          setState(() {
                            isLoading = true;
                          });
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: phoneController.text,
                            verificationCompleted: (phoneAuthCredential){},
                            verificationFailed: (error){
                              print(error);
                            },
                            codeSent: (verificationId, forceResendingToken){
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => OTPScreen(verificationId: verificationId)
                              ));
                            },
                            codeAutoRetrievalTimeout: (verificationId){}
                          );
                        },
                        child: const Text("Receber código via SMS",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                          ),
                        )
                    )
                  ]
              ),
            ),
          );
        }
    );
  }
}
