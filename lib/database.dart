
import 'firebase_options.dart';



class Database extends DefaultFirebaseOptions {

  int myAge = 0;

  int setAge(int age){
    myAge = age;
    return myAge;
  }

}
