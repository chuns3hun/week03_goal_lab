import 'package:flutter/material.dart';

void main() {
  runApp(const StudyGoalApp());
}

class StudyGoalApp extends StatelessWidget {
  const StudyGoalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 03 · Study Goal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GoalHomePage(),
    );
  }
}

class StudyGoal {
  final String id;
  final String title;
  bool isCompleted;

  StudyGoal({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  void toggle() {
    isCompleted = !isCompleted;
  }
}

class GoalHomePage extends StatefulWidget {
  const GoalHomePage({super.key});

  @override
  State<GoalHomePage> createState() => _GoalHomePageState();
}

class _GoalHomePageState extends State<GoalHomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<StudyGoal> _goals = [];
  String? _errorMessage;

  void _addGoal() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorMessage = '목표를 입력하세요';
      });
      return;
    }

    setState(() {
      _goals.add(StudyGoal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: text,
      ));
      _controller.clear();
      _errorMessage = null;
    });
  }

void _toggleGoal(StudyGoal goal) {
    setState(() {
      goal.toggle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 03 · Study Goal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '학습 목표 입력',
                      errorText: _errorMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addGoal,
                  child: const Text('추가'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _goals.isEmpty
                  ? const Center(child: Text('등록된 목표가 없습니다.'))
                  : ListView.builder(
                      itemCount: _goals.length,
                      itemBuilder: (context, index) {
                        final goal = _goals[index];
                        return CheckboxListTile(
                          title: Text(
                            goal.title,
                            style: TextStyle(
                              decoration: goal.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          value: goal.isCompleted,
                          onChanged: (_) => _toggleGoal(goal),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}