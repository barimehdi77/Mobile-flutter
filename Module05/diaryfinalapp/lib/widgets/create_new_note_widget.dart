import 'package:diaryapp/enums/feelings_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CreateNewNoteWidget extends StatelessWidget {
  CreateNewNoteWidget({
    super.key,
    required this.selectedFeeling,
    required this.onClose,
    required this.onSelectFeeling,
    required this.onSubmit,
    required this.titleEditingController,
    required this.contentEditingController,
  });

  final VoidCallback onClose;
  final Function(String feeling) onSelectFeeling;
  final String? selectedFeeling;
  final Future<void> Function() onSubmit;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleEditingController;
  final TextEditingController contentEditingController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add New Note:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: onClose,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
        Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            height: MediaQuery.of(context).size.height - 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: titleEditingController,
                  decoration: const InputDecoration(
                    hintText: "Type your note title here...",
                    border: OutlineInputBorder(),
                    labelText: "title",
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                ),
                Expanded(
                  child: Wrap(
                    children: FeelingsEnum.values.map(
                      (feeling) {
                        return SizedBox(
                          width: 60,
                          height: 60,
                          child: IconButton(
                            onPressed: () {
                              onSelectFeeling(feeling.name);
                            },
                            icon: Lottie.asset(
                              'assets/lotties/${feeling.name}.json',
                              fit: BoxFit.cover,
                              repeat: true,
                            ),
                            tooltip: feeling.name,
                            style: ButtonStyle(
                              backgroundColor: selectedFeeling == feeling.name
                                  ? MaterialStateProperty.all<Color>(
                                      Colors.blue)
                                  : MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: contentEditingController,
                      decoration: const InputDecoration(
                        hintText: "Type your note content here...",
                        border: OutlineInputBorder(),
                        labelText: "Content",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await onSubmit();
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
