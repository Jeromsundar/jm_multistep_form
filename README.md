# jm_multistep_form

A Flutter package for creating multi-step forms with custom input fields, step indicators, and form validation.

## Features
- Custom text fields, dropdowns, and date pickers
- Navigation buttons for multi-step forms
- Step indicators for user guidance

## Installation
Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  jm_multistep_form: ^0.0.1

## Example Usage

 int _currentStep = 0;

  void _changeStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  void _submitForm() {
    // Submit form logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi-step Form"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StepIndicator(currentStep: _currentStep, formNames: ['Personal', 'Education', 'Other']),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _getStepContent(),
                        NavigationButtons(
                          currentStep: _currentStep,
                          onStepChange: _changeStep,
                          onSubmit: _submitForm,
                          totalSteps: 3,
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
        return PersonalDetailsForm();
      case 1:
        return EducationDetailsForm();
      case 2:
        return OtherDetailsForm();
      default:
        return Container();
    }
  }
}

// Personal Details Form
class PersonalDetailsForm extends StatefulWidget {
  @override
  _PersonalDetailsFormState createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 50, backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null),
        ElevatedButton(onPressed: () => _pickImage(ImageSource.gallery), child: const Text("Pick Image")),
        CustomTextField(icon: Icons.person, hintText: 'Name'),
        CustomDropdownField(hintText: 'Gender', options: ['Male', 'Female', 'Other']),
        CustomTextField(icon: Icons.location_city, hintText: 'City'),
        CustomTextField(icon: Icons.email, hintText: 'Email', isEmail: true),
        CustomTextField(icon: Icons.phone, hintText: 'Mobile', isPhone: true),
      ],
    );
  }
}

// Education Details Form
class EducationDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownField(hintText: 'Degree', options: ['B.Sc', 'M.Sc', 'B.Tech', 'M.Tech', 'MBA', 'MCA']),
        CustomTextField(icon: Icons.book, hintText: 'Course Name'),
        CustomTextField(icon: Icons.grade, hintText: 'Grade/Percentage'),
        Row(
          children: [
            Expanded(child: CustomDateField(icon: Icons.date_range, hintText: 'Start Date')),
            const SizedBox(width: 20),
            Expanded(child: CustomDateField(icon: Icons.date_range, hintText: 'End Date')),
          ],
        ),
      ],
    );
  }
}

// Other Details Form
class OtherDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(icon: Icons.person, hintText: 'Reference Name'),
        CustomDropdownField(hintText: 'Department', options: ['HR', 'Finance', 'Engineering', 'Marketing']),
        CustomTextField(icon: Icons.email, hintText: 'Reference Email', isEmail: true),
        CustomDateField(icon: Icons.date_range, hintText: 'Date of Joining'),
        CustomTextField(icon: Icons.phone, hintText: 'Emergency Contact', isPhone: true),
      ],
    );
  }