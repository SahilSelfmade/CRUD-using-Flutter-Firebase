import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// Main Home Page
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Flutter Firebase CRUD'),
            MaterialButton(
                child: Tooltip(
                  waitDuration: Duration(seconds: 1),
                  showDuration: Duration(seconds: 1),
                  message: 'Add Employee',
                  child: Icon(Icons.add),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddEmployee();
                  }));
                }),
          ],
        ),
      ),
      body: ListEmployee(),
    );
  }
}

// Employee Add Screen
class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  var name, email, password;

  final _emailController = TextEditingController();
  // Private Varibles Declare Here
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();

  final _passwordController = TextEditingController();

  void clearFields() {
    _nameController.clear();
    _passwordController.clear();
    _emailController.clear();
  }

  void addUser() {}

  TextFormField _formFields(
      String name, TextEditingController controller, validator) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please Enter $validator';
        }
        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text(name),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Page'),
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _formFields('Name:', _nameController, 'Name'),
              const SizedBox(height: 20),
              _formFields('E-Mail:', _emailController, 'E-Mail'),
              const SizedBox(height: 20),
              _formFields('Password:', _passwordController, 'Password'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = _nameController.text;
                            email = _emailController.text;
                            password = _passwordController.text;
                            addUser();
                            clearFields();
                          });
                        }
                      },
                      child: Text('Register')),
                  ElevatedButton(
                      onPressed: () {
                        clearFields();
                      },
                      child: Text('Reset')),
                ],
              )
            ],
          ),
        ),
      )),
    );
    ;
  }
}

// List Employee Screen
class ListEmployee extends StatefulWidget {
  const ListEmployee({Key? key}) : super(key: key);

  @override
  State<ListEmployee> createState() => _ListEmployeeState();
}

class _ListEmployeeState extends State<ListEmployee> {
  TableCell _firstRow(String name) {
    return TableCell(
      child: Container(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            1: FixedColumnWidth(140),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                _firstRow('Name'),
                _firstRow('Email'),
                TableCell(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateEmployee(),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteEmployee();
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                _firstRow('Sonam Bajwa'),
                _firstRow('Sahil@gmail.com'),
                _firstRow('Actions'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void deleteEmployee() {
  print('Employee Deleted');
}

// Update Employee
class UpdateEmployee extends StatefulWidget {
  const UpdateEmployee({Key? key}) : super(key: key);

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  final _formKey = GlobalKey<FormState>();
  updateUser() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              _textFormField('Name', false, 'Sahil Kaushal', 'Name'),
              const SizedBox(height: 20),
              _textFormField(
                  'E-Mail', false, 'SahilKaushal@gmail.com', 'E-Mail'),
              const SizedBox(height: 20),
              _textFormField('Name', true, 'Sahil Kaushal', 'Password'),
            ],
          ),
        ),
      ),
    );
  }

  Container _textFormField(String name, obscureText, initialValue, validator) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        autofocus: false,
        onChanged: (val) {},
        decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(),
        ),
        obscureText: obscureText,
        initialValue: initialValue,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Please Enter $validator';
          }
          return null;
        },
      ),
    );
  }
}
