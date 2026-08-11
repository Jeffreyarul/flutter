// ============================================================
//  FLUTTER BASICS — COMPLETE REFERENCE
//  Topics covered:
//    1. Entry point & MaterialApp
//    2. Stateless Widget
//    3. Stateful Widget + setState
//    4. Common Widgets (Text, Button, Image, Icon, etc.)
//    5. Layout Widgets (Column, Row, Stack, Container, Expanded)
//    6. Navigation (push / pop routes)
//    7. ListView & ListTile
//    8. Forms & TextFormField
//    9. Theme & custom colors
//   10. Async / FutureBuilder
// ============================================================

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// 1. ENTRY POINT
//    Every Flutter app starts with main() → runApp()
// ─────────────────────────────────────────────
void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────────
// 2. ROOT WIDGET — MaterialApp
//    Wraps the whole app, provides theme & routing
// ─────────────────────────────────────────────
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Basics',
      debugShowCheckedModeBanner: false,

      // 9. THEME — global look & feel
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),

      home: const HomePage(),
    );
  }
}

// ─────────────────────────────────────────────
// 3. STATELESS WIDGET
//    No mutable state — just reads data and builds UI.
//    Use when your widget never changes after it's built.
// ─────────────────────────────────────────────
class GreetingCard extends StatelessWidget {
  final String name; // data passed from parent

  const GreetingCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Hello, $name! 👋',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 4. STATEFUL WIDGET
//    Has mutable state. Call setState() to rebuild UI.
//    Split into two classes: Widget + State
// ─────────────────────────────────────────────
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0; // mutable state variable

  void _increment() {
    setState(() {
      // setState() tells Flutter to rebuild this widget
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        // 5a. ROW — horizontal layout
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: _decrement,
              icon: const Icon(Icons.remove),
              label: const Text('Decrement'),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _increment,
              icon: const Icon(Icons.add),
              label: const Text('Increment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 10. ASYNC / FutureBuilder
//     Fetch data asynchronously and build UI
//     based on loading / done / error states
// ─────────────────────────────────────────────
Future<String> fetchGreeting() async {
  await Future.delayed(const Duration(seconds: 2)); // simulate network call
  return 'Data loaded from the internet!';
}

class AsyncExample extends StatelessWidget {
  const AsyncExample({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchGreeting(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red));
        } else {
          return Text(snapshot.data ?? '',
              style: const TextStyle(color: Colors.green, fontSize: 16));
        }
      },
    );
  }
}

// ─────────────────────────────────────────────
// 8. FORMS & TextFormField
//    Collecting user input with validation
// ─────────────────────────────────────────────
class SimpleForm extends StatefulWidget {
  const SimpleForm({super.key});

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String _submittedValue = '';

  @override
  void dispose() {
    _controller.dispose(); // always dispose controllers!
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() => _submittedValue = _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              hintText: 'e.g. Flutter Dev',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Name cannot be empty';
              }
              return null; // null = valid
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: _submit, child: const Text('Submit')),
          if (_submittedValue.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Hello, $_submittedValue!',
                  style: const TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 6. NAVIGATION — second page
//    Navigator.push → go forward
//    Navigator.pop  → go back
// ─────────────────────────────────────────────
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text('You navigated here!',
                style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// MAIN HOME PAGE — ties everything together
// ─────────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Basics'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Info',
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Flutter Basics Reference App!')),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Stateless Widget ───────────
            _sectionTitle('2 & 3. Stateless Widget'),
            const GreetingCard(name: 'Flutter Developer'),

            // ── Stateful Widget ────────────
            _sectionTitle('4. Stateful Widget + setState'),
            const Center(child: CounterWidget()),

            const Divider(height: 32),

            // ── Common Widgets ─────────────
            _sectionTitle('5. Common Widgets'),
            const Text('Bold Text',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Colored Text',
                style: TextStyle(color: Colors.indigo, fontSize: 16)),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.flutter_dash, color: Colors.blue, size: 40),
                SizedBox(width: 8),
                Text('Flutter Dash — Icon widget'),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                    onPressed: () {}, child: const Text('TextButton')),
                OutlinedButton(
                    onPressed: () {}, child: const Text('OutlinedButton')),
                FilledButton(
                    onPressed: () {}, child: const Text('FilledButton')),
              ],
            ),

            const Divider(height: 32),

            // ── Layout Widgets ─────────────
            _sectionTitle('5a. Layout: Container + Gradient'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.indigo]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text('Container + BoxDecoration',
                      style:
                          TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Gradient background, rounded corners',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Stack
            _sectionTitle('5b. Layout: Stack'),
            SizedBox(
              height: 80,
              child: Stack(
                children: [
                  Container(
                      color: Colors.deepPurple.shade100,
                      width: double.infinity),
                  const Positioned(
                      left: 10, top: 10, child: Text('Bottom layer')),
                  const Positioned(
                    right: 10,
                    bottom: 10,
                    child: Text('Top layer',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // Expanded
            _sectionTitle('5c. Expanded (flex)'),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      height: 40,
                      color: Colors.purple.shade200,
                      child: const Center(child: Text('flex: 2'))),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: 40,
                      color: Colors.indigo.shade200,
                      child: const Center(child: Text('flex: 1'))),
                ),
              ],
            ),

            const Divider(height: 32),

            // ── ListView ───────────────────
            _sectionTitle('7. ListView & ListTile'),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        CircleAvatar(child: Text('${index + 1}')),
                    title: Text('Item ${index + 1}'),
                    subtitle:
                        Text('Subtitle for item ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 14),
                    onTap: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Tapped item ${index + 1}')),
                    ),
                  );
                },
              ),
            ),

            const Divider(height: 32),

            // ── Form ───────────────────────
            _sectionTitle('8. Form & TextFormField'),
            const SimpleForm(),

            const Divider(height: 32),

            // ── Navigation ─────────────────
            _sectionTitle('6. Navigation (push / pop)'),
            ElevatedButton.icon(
              icon: const Icon(Icons.navigate_next),
              label: const Text('Go to Second Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecondPage()),
                );
              },
            ),

            const Divider(height: 32),

            // ── FutureBuilder ──────────────
            _sectionTitle('10. Async / FutureBuilder'),
            const Center(child: AsyncExample()),

            const SizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('FAB pressed!')),
        ),
        tooltip: 'Press me',
        child: const Icon(Icons.touch_app),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple)),
    );
  }
}
