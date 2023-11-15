import 'package:axon_ui/widgets/axon_theme.dart';
import 'package:axon_ui/widgets/primitives/axon_button.dart';
import 'package:axon_ui/widgets/primitives/axon_checkbox.dart';
import 'package:axon_ui/widgets/primitives/axon_combo_box.dart';
import 'package:axon_ui/widgets/primitives/axon_switch.dart';
import 'package:axon_ui/widgets/primitives/axon_text_form_field.dart';
import 'package:flutter/material.dart';

import 'widgets/primitives/axon_text_field.dart';
import 'widgets/primitives/utils.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool switched = false;
  int comboBoxValue = -1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.light,
          background: Colors.white,
          onBackground: const Color.fromARGB(255, 15, 15, 15),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
          background: const Color.fromARGB(255, 15, 15, 15),
          onBackground: Colors.white,
        ),
      ),
      home: AxonTheme(
        data: const AxonThemeData(
          borderRadius: 4,
        ),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                Text(
                  "Primitives",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(width: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.primary,
                      child: const Text("Primary"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: () {},
                      style: AxonButtonStyle.primary,
                      icon: const Icon(Icons.person),
                      text: const Text("Primary"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.icon(
                      onPressed: () {},
                      style: AxonButtonStyle.primary,
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: null,
                      style: AxonButtonStyle.primary,
                      icon: const Icon(Icons.person),
                      text: const Text("Primary"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.secondary,
                      child: const Text("Secondary"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: () {},
                      style: AxonButtonStyle.secondary,
                      icon: const Icon(Icons.person),
                      text: const Text("Secondary"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.icon(
                      onPressed: () {},
                      style: AxonButtonStyle.secondary,
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: null,
                      style: AxonButtonStyle.secondary,
                      icon: const Icon(Icons.person),
                      text: const Text("Secondary"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.outline,
                      child: const Text("Outline"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: () {},
                      style: AxonButtonStyle.outline,
                      icon: const Icon(Icons.person),
                      text: const Text("Outline"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.icon(
                      onPressed: () {},
                      style: AxonButtonStyle.outline,
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: null,
                      style: AxonButtonStyle.outline,
                      icon: const Icon(Icons.person),
                      text: const Text("Outline"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.ghost,
                      child: const Text("Ghost"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: () {},
                      style: AxonButtonStyle.ghost,
                      icon: const Icon(Icons.person),
                      text: const Text("Ghost"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.icon(
                      onPressed: () {},
                      style: AxonButtonStyle.ghost,
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: null,
                      style: AxonButtonStyle.ghost,
                      icon: const Icon(Icons.person),
                      text: const Text("Ghost"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.link,
                      child: const Text("Link"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: () {},
                      style: AxonButtonStyle.link,
                      icon: const Icon(Icons.person),
                      text: const Text("Link"),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.icon(
                      onPressed: () {},
                      style: AxonButtonStyle.link,
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 15),
                    AxonButton.iconAndText(
                      onPressed: null,
                      style: AxonButtonStyle.link,
                      icon: const Icon(Icons.person),
                      text: const Text("Link"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dark Mode"),
                    const SizedBox(width: 8),
                    AxonSwitch(
                      switched: switched,
                      onSwitched: (value) {
                        setState(() => switched = value);
                      },
                    ),
                    const SizedBox(width: 8),
                    AxonCheckbox(
                      checked: switched,
                      onChecked: (value) {
                        setState(() => switched = value);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AxonComboBox<int>(
                        expanded: true,
                        items: const [
                          AxonComboBoxItem<int>(child: Text("Zero"), value: 0),
                          AxonComboBoxItem<int>(child: Text("First"), value: 1),
                          AxonComboBoxItem<int>(child: Text("Second"), value: 2),
                          AxonComboBoxItem<int>(
                            icon: Icon(Icons.person),
                            child: Text("Person"),
                            value: 4,
                          ),
                        ],
                        value: comboBoxValue,
                        placeholder: const Text("Pick an option..."),
                        onSelected: (value) {
                          setState(() {
                            comboBoxValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    AxonComboBox<int>(
                      items: const [
                        AxonComboBoxItem(child: Text("Zero"), value: 0),
                        AxonComboBoxItem(child: Text("First"), value: 1),
                        AxonComboBoxItem(child: Text("Second"), value: 2),
                        AxonComboBoxItem(
                          icon: Icon(Icons.person),
                          child: Text("Person"),
                          value: 4,
                        ),
                      ],
                      value: comboBoxValue,
                      placeholder: const Text("Pick an option..."),
                      onSelected: (value) {
                        setState(() {
                          comboBoxValue = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                AxonTextField(
                  hintText: "Write Something...",
                  suffixBuilder: (controller, hovered, focused) => AnimatedVisibility(
                    duration: AxonTheme.of(context).normalDuration,
                    curve: AxonTheme.of(context).curve,
                    visible: controller.text.isNotEmpty,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: AxonButton(
                        onPressed: () {
                          controller.text = "";
                        },
                        style: AxonButtonStyle.ghost,
                        child: const Center(child: Icon(Icons.close)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: AxonTextField(
                        hintText: "Search...",
                        prefixBuilder: (controller, hovered, focused) => const Icon(Icons.search),
                      ),
                    ),
                    const SizedBox(width: 8),
                    AxonButton(
                      onPressed: () {},
                      style: AxonButtonStyle.secondary,
                      child: const Text("Go"),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                AxonTextFormField(
                  hintText: "Search...",
                  prefixBuilder: (controller, hovered, focused) => const Icon(Icons.search),
                ),
                const SizedBox(width: 8),
              ],
            ),
          );
        }),
      ),
    );
  }
}
