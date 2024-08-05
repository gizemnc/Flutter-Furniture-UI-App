
/*class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation Example'),
      ),
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: FlutterLogo(size: 100.0),
        ),
      ),
    );
  }
}*/

/*class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late FirebaseAuth auth ;
  String _email = "gzmnrcelik@gmail.com";
  String _password = "123456";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = FirebaseAuth.instance;
    auth.authStateChanges()
     .listen((User? user){
       if(user == null){
        debugPrint("User is currently signed out!");
      }else{
        debugPrint("User ${user.email} is signed in! ${user.emailVerified}");
      }
     });
    
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        actions: [ElevatedButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
        }, child:Icon(Icons.arrow_forward))],
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              createUserEmailAndPassword();
            }, child: Text("Email/şifre giriniz")),
            ElevatedButton(onPressed: (){
              loginUserEmailAndPassword();
            }, child: Text("Email/şifre kayıt"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),),
            ElevatedButton(onPressed: (){
              signOutUser();
            }, child: Text("Sign out"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),)
            ,
            ElevatedButton(onPressed: (){
              deleteUser();
            }, child: Text("Delete user"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),),
            ElevatedButton(onPressed: (){
              changePassword();
            }, child: Text("Change Password"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),)
          ],
        ),
      ),
    );
  }
  
  void createUserEmailAndPassword() async {
      try{
        var _userCredential = 
        (await auth.createUserWithEmailAndPassword(email: _email, password: _password));
        var _myUser = _userCredential.user;
        if(!_myUser!.emailVerified) {
          await  _myUser.sendEmailVerification();
        }else{
          debugPrint("Kullanıcının maili onaylanmıştır.");
        }


        debugPrint(_userCredential.toString());
      }catch(ex){
        debugPrint(ex.toString());
      }
  }
  
  void loginUserEmailAndPassword() async{
    try{
      var _usercredential =
       (await auth.signInWithEmailAndPassword(email: _email, password: _password)).user;
       debugPrint(_usercredential.toString());
    }catch(ex){
      debugPrint(ex.toString());
    }
  }
  void signOutUser() async{
    await auth.signOut();
  } 
  void deleteUser() async {
    if(auth.currentUser != null){
      await auth.currentUser!.delete();
    } else{
      debugPrint("Sistemde kullanıcı bulunmuyor.");
    }
  }
  
  void changePassword() async{
    try{   
    await auth.currentUser!.updatePassword("yenisifre");
    await auth.signOut();
    }on FirebaseAuthException catch(ex){
      if(ex.code == 'requires-recent-login'){
        var credential = EmailAuthProvider.credential(email: _email, password: _password);
        await auth.currentUser!.reauthenticateWithCredential(credential);
      
        await auth.currentUser!.updatePassword("yenisifre");
        await auth.signOut();
        debugPrint("The password changed. ");
      }
    }catch(ex){
      debugPrint(ex.toString());
    }
  }
}  */
