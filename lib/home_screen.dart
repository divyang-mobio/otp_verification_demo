import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDString = '';
  bool otpCodeVisible = false;

  void sendOtp() {
    if (!(_phoneNoController.text == '')) {
      auth.verifyPhoneNumber(
          phoneNumber: '+91 ${_phoneNoController.text}',
          codeSent: (verificationID, token) {
            verificationIDString = verificationID;
            otpCodeVisible = true;
            setState(() {});
          },
          codeAutoRetrievalTimeout: (verificationID) {},
          verificationCompleted: (credential) async => await auth
              .signInWithCredential(credential)
              .then((value) => print('complete')),
          verificationFailed: (exception) => print(exception.message));
    }
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDString,
        smsCode: _passWordController.text);
    await auth.signInWithCredential(credential).then((value) {
      otpCodeVisible = false;
      return Navigator.pushReplacementNamed(context, '/success');
    });
  }

  BoxDecoration get _pinPutDecoration => BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0));

  _buttonOnPress() {
    if (otpCodeVisible) {
      return () => verifyCode();
    } else {
      return () => sendOtp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Otp Verification Screen')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Visibility(
            visible: !otpCodeVisible,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: TextField(
                    controller: _phoneNoController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: '1357924680'))),
          ),
          Visibility(
            visible: otpCodeVisible,
            child: TextFieldPin(
                margin: 10,
                codeLength: 6,
                autoFocus: true,
                defaultBoxSize: 40.0,
                selectedBoxSize: 40.0,
                onChange: (code) => setState(() {}),
                textController: _passWordController,
                alignment: MainAxisAlignment.center,
                textStyle: const TextStyle(fontSize: 16),
                defaultDecoration: _pinPutDecoration.copyWith(
                    border: Border.all(
                        color:
                            Theme.of(context).primaryColor.withOpacity(0.6))),
                selectedDecoration: _pinPutDecoration),
          ),
          MaterialButton(
              onPressed: _buttonOnPress(),
              child: Text(otpCodeVisible ? 'Verify Otp' : 'Get Otp'))
        ]),
      ),
    );
  }
}
