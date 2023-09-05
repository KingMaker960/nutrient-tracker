// ignore: depend_on_referenced_packages
import 'package:postgres/postgres.dart';

// ignore: prefer_typing_uninitialized_variables
Future<List> loginAuthenticate(String userName, String passWord) async {
  var connection = PostgreSQLConnection(
      "ec2-3-219-229-143.compute-1.amazonaws.com", 5432, "dcmhfut8ocfqb3",
      username: "fpqweaeipbpowc",
      password:
          "52c4766bf65240a9e17c06d7dfdc150871131e510eb445c2d55a44a40d03949c",
      useSSL: true);
  try {
    await connection.open();
    var result = await connection
        .query('''SELECT password From Users where rollnumber = '$userName'
        ''');
    if (result.isEmpty) {
      //show error User Didnot Exists
      return [
        "Error Occured",
        "Wrong Details",
        "RollNumber is Not Registered Either The Details You entered Is Wrong. Please Check The Details Again.",
        "failed.json",
        true
      ];
    } else {
      if (result[0][0] != passWord) {
        return [
          "Error Occured",
          "Wrong Details",
          "Password You entered is Wrong. Please Check Again and Retry Or Click Forgot Password To Reset Your Password.",
          "failed.json",
          true
        ];
      } else {
        //Login Successs
        return [
          "Successful",
          "Loging In",
          "Please Wait While We Redirect You To Home Page.",
          "success.json",
          false
        ];
      }
    }
  } catch (e) {
    null;
  }
  return [];
}

Future<List> registerAuthenticate(String number, String rollNumber) async {
  var connection = PostgreSQLConnection(
      "ec2-3-219-229-143.compute-1.amazonaws.com", 5432, "dcmhfut8ocfqb3",
      username: "fpqweaeipbpowc",
      password:
          "52c4766bf65240a9e17c06d7dfdc150871131e510eb445c2d55a44a40d03949c",
      useSSL: true);
  try {
    await connection.open();

    var result = await connection
        .query(('''SELECT number From Users where rollnumber = '$rollNumber'
        '''));
    if (result.isEmpty) {
      result = await connection
          .query(('''SELECT rollnumber From Users where number = '$number'
        '''));
      if (result.isEmpty) {
        //register data
        return [
          "Authenticating",
          "Please Wait",
          "We Need To Verify Your Phone Number So Sending OTP to Given Number.",
          "loading.json",
          false
        ];
      } else {
        //error phone number already registered
        return [
          "Error Occured",
          "Duplicate Entry",
          "Phone Number You Entered is Already Registered. Please Check The Details You Entered And Try Again.",
          "failed.json",
          true
        ];
      }
    } else {
      //error username already registered
      return [
        "Error Occured",
        "Duplicate Entry",
        "RollNumber You Entered is Already Registered Either You Have Entered Wrong Information. If Registered Please Login To Continue.",
        "failed.json",
        true
      ];
    }
  } catch (e) {
    null;
  }
  return [];
}

Future createUser(String name, String age, String number, String rollNumber,
    String passsWord) async {
  var connection = PostgreSQLConnection(
      "ec2-3-219-229-143.compute-1.amazonaws.com", 5432, "dcmhfut8ocfqb3",
      username: "fpqweaeipbpowc",
      password:
          "52c4766bf65240a9e17c06d7dfdc150871131e510eb445c2d55a44a40d03949c",
      useSSL: true);
  try {
    await connection.open();
    await connection
        .query('''INSERT INTO Users(name,number,age,rollnumber,password)
    values(@name,@number,@age,@rollnumber,@password)
    ''', substitutionValues: {
      // ignore: unnecessary_string_interpolations
      'name': name,
      'number': number,
      'age': age,
      'rollnumber': rollNumber,
      'password': passsWord,
    });
//     await connection.query('''CREATE TABLE $rollNumber(
//       Date Text,
//       Protein Text,
//       Carbohydrate Text,
//       Fats Text,
//       Micros Text
//     )
// ''');
  } catch (e) {
    null;
  }
}

// Future delete(String rollNumber) async {
//   var connection = PostgreSQLConnection(
//       "ec2-3-219-229-143.compute-1.amazonaws.com", 5432, "dcmhfut8ocfqb3",
//       username: "fpqweaeipbpowc",
//       password:
//           "52c4766bf65240a9e17c06d7dfdc150871131e510eb445c2d55a44a40d03949c",
//       useSSL: true);
//   try {
//     await connection.open();
//     await connection.query('''DROP Table $rollNumber''');
//     print("Success");
// //     await connection.query('''CREATE TABLE $rollNumber(
// //       Date Text,
// //       Protein Text,
// //       Carbohydrate Text,
// //       Fats Text,
// //       Micros Text
// //     )
// // ''');
//   } catch (e) {
//     null;
//   }
// }
