import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../screens/home_screen.dart';
import '../blocs/auth_cubit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.isLoggedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome ${state.user!.fullname}")),
            );
            _goToChatPage(context);
          } else if (state.isError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message ?? "Error")));
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Text(
                "Sign up with Email",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                child: Text(
                  "Get chatting with friends and family today by signing up for our chat app!",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildUsernameField(),
                      SizedBox(height: 16),
                      _buildEmailField(),
                      SizedBox(height: 16),
                      _buildPasswordField(),
                      SizedBox(height: 30),
                      _buildConfirmPasswordField(),
                      SizedBox(height: 30),
                      _buildSignupButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      decoration: InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value == null || value.trim().length < 4) {
          return 'Please enter at least 4 characters';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(labelText: 'Email Address'),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value == null || value.trim().isEmpty || !value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().length < 6) {
          return 'Password must be at least 6 characters long.';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().length < 6) {
          return 'Password must be at least 6 characters long.';
        }
        return null;
      },
    );
  }

  Widget _buildSignupButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<AuthCubit>(context);
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(18),
              ),
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF24786D),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                cubit.signup(
                  fullname: _usernameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
            },
            child: Text(
              state.isLoading ? 'Loading' : 'Create an account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  void _goToChatPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }
}

// UserImagePicker(
//                               onPickImage: (File pickedImage) {
//                                 _selectedImage = pickedImage;
//                               },
//                             ),

// void _submit() async {
//   final valid = _formKey.currentState!.validate();

//   if (!valid || (!_isLogin && _selectedImage == null)) {
//     return;
//   }

//   try {
//     setState(() {
//       _isUpLoading = true;
//     });
//     if (_isLogin) {
//       await firebaseAuth.signInWithEmailAndPassword(
//         email: _enteredEmail,
//         password: _enteredPassword,
//       );
//     } else {
//       final UserCredential userCredential = await firebaseAuth
//           .createUserWithEmailAndPassword(
//             email: _enteredEmail,
//             password: _enteredPassword,
//           );

//       final Reference storageRef = firebaseStorage
//           .ref()
//           .child('user_image')
//           .child('${userCredential.user!.uid}.jpg');
//       await storageRef.putFile(_selectedImage!);
//       final imageUrl = await storageRef.getDownloadURL();
//       log(imageUrl);

//       await firebaseFirestore
//           .collection('users')
//           .doc(userCredential.user!.uid)
//           .set({
//             'username': _enteredUserName,
//             'email': _enteredEmail,
//             'image_url': imageUrl,
//           });
//     }
//   } on FirebaseAuthException catch (e) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(e.message ?? 'Authentication failed')),
//     );
//   }
//   setState(() {
//     _isUpLoading = false;
//   });

//   _formKey.currentState!.save();
//   log(_enteredEmail);
//   log(_enteredPassword);
// }
