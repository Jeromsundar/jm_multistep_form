import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jm_multistep_form/widgets/datefield.dart';
import 'package:jm_multistep_form/widgets/dropdownffield.dart.dart';
import 'package:jm_multistep_form/widgets/naveBTN.dart';
import 'package:jm_multistep_form/widgets/step_indicator.dart';
import 'package:jm_multistep_form/widgets/textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiStepCustomerForm() ,
    );
  }
}


class MultiStepCustomerForm extends StatefulWidget {
  const MultiStepCustomerForm({super.key});

  @override
  _MultiStepCustomerFormState createState() => _MultiStepCustomerFormState();
}

class _MultiStepCustomerFormState extends State<MultiStepCustomerForm> {
   int _currentStep = 0;

  void _changeStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _submitForm() {
    // Your submit logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form submitted successfully!')),
    );
  }
//main page allignment for full form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromARGB(255, 236, 205, 242),
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 220, 229, 244),
  title: const Text("Multi step  Form",style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),),
                centerTitle: true,
              ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          StepIndicator(
                currentStep: _currentStep,
                formNames: ['Personal Details', 'Education Details', 'Others'],
              ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                elevation: 5,
                shadowColor: Colors.grey.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                                  _getStepContent(),
                                  NavigationButtons(
                        currentStep: _currentStep,
                        onStepChange: _changeStep,
                        onSubmit: _submitForm, totalSteps: 3,
                      ),
                    ],
                  ),
                ),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getStepContent() {
    switch (_currentStep) {
      case 0:
        return personalProfileForm();
      case 1:
        return EducationDetailsForm();
      case 2:
        return OthersDetailsForm();
      default:
        return Container();
    }
  }
}


//form 1
class personalProfileForm extends StatefulWidget {
  const personalProfileForm({Key? key}) : super(key: key);

  @override
  _personalProfileFormState createState() => _personalProfileFormState();
}

class _personalProfileFormState extends State<personalProfileForm> {
  File? _profileImage;
  String? selectedGender;

  // Function to pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Show Dialog to select image source (Camera or Gallery)
   void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile picture section
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 55,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const NetworkImage(
                        "https://www.pinclipart.com/picdir/middle/552-5526227_cartoon-school-student-png-clipart.png",
                      ) as ImageProvider,
              ),
            ),
            GestureDetector(
              onTap: () =>_showImageSourceDialog(), // Show dialog on tap
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                ),
                child: const Icon(Icons.add_a_photo, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomTextField(icon: Icons.person, hintText: 'Name'),
        CustomDropdownField<String>(
          hintText: 'Select Gender',
          options: ['Male', 'Female', 'Others'],
          icon: Icons.person_3,
          onChanged: (String? newValue) {
            setState(() {
              selectedGender = newValue;
            });
          },
        ),
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.location_city, hintText: 'City')),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.email, hintText: 'Email', isEmail: true)),
          ],
        ),
        CustomTextField(icon: Icons.map, hintText: 'Zone'),
        CustomTextField(icon: Icons.home, hintText: 'Address 1'),
        CustomTextField(icon: Icons.home, hintText: 'Address 2'),
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.pin_drop, hintText: 'Pin Code')),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.confirmation_number, hintText: 'GST Number')),
          ],
        ),
        CustomTextField(icon: Icons.phone, hintText: 'Office Phone', isPhone: true),
        CustomTextField(icon: Icons.phone, hintText: 'Mobile', isPhone: true),
        CustomTextField(icon: Icons.web, hintText: 'Website'),
      ],
    );
  }
}


class EducationDetailsForm extends StatelessWidget {
  final String? selectedDegree; // Selected degree passed as a parameter
  final Function(String?)? onDegreeChanged; // Callback for degree selection
  final Function(String)? onTextFieldChanged; // Callback for text field input

  const EducationDetailsForm({
    Key? key,
    this.selectedDegree,
    this.onDegreeChanged,
    this.onTextFieldChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomDropdownField<String>(
          hintText: 'Select Degree',
          options: ['B.Sc', 'M.Sc', 'B.Tech', 'M.Tech', 'MBA', 'MCA'],
          icon: Icons.school,
          onChanged: (String? newValue) {
            onDegreeChanged?.call(newValue);
          },
        ),
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.location_city, hintText: 'City of Institution')),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.email, hintText: 'Institution Email', isEmail: true)),
          ],
        ),
        CustomTextField(icon: Icons.book, hintText: 'Course Name'),
        
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.pin_drop, hintText: 'Pin Code',)),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.grade, hintText: 'Grade/Percentage')),
          ],
        ),
        CustomTextField(icon: Icons.phone, hintText: 'Institution Contact Number', isPhone: true),
        CustomTextField(icon: Icons.web, hintText: 'Institution Website'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomDateField(icon: Icons.date_range, hintText: 'Start Date', ), ),
            const SizedBox(width: 20),
            Expanded(child: CustomDateField(icon: Icons.date_range, hintText: 'End Date',), )
          ],
        ),
        
      ],
    );
  }
}

class OthersDetailsForm extends StatelessWidget {
  final String? selectedDepartment; // Selected department passed as a parameter
  final Function(String?)? onDepartmentChanged; // Callback for department selection
  final Function(String)? onTextFieldChanged; 

  const OthersDetailsForm({
    Key? key,
    this.selectedDepartment,
    this.onDepartmentChanged,
    this.onTextFieldChanged,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomTextField(icon: Icons.person, hintText: 'Reference Name'),
        CustomDropdownField<String>(
          hintText: 'Select Department',
          options: ['HR', 'Finance', 'Engineering', 'Computer science', 'Marketing'],
          icon: Icons.business,
          onChanged: (String? newValue) {
            onDepartmentChanged?.call(newValue);
          },
        ),
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.location_city, hintText: 'Location')),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.email, hintText: 'Reference Email', isEmail: true)),
          ],
        ),
        CustomTextField(icon: Icons.notes, hintText: 'Additional Notes'),
        Row(
          children: [
            Expanded(child: CustomDateField(icon: Icons.date_range, hintText: 'Date of Joining', ),),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.calendar_today, hintText: 'Leave Balance'),),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: CustomTextField(icon: Icons.pin_drop, hintText: 'Location Code',)),
            const SizedBox(width: 20),
            Expanded(child: CustomTextField(icon: Icons.contact_phone, hintText: 'Emergency Contact Number', isPhone: true)),
          ],
        ),
        CustomTextField(icon: Icons.language, hintText: 'Preferred Language'),
        CustomTextField(icon: Icons.web, hintText: 'Website Link'),
      ],
    );
  }
}

