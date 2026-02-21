import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessCoachApp());
}

class FitnessCoachApp extends StatelessWidget {
  const FitnessCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF4D6BFF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness AI',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1117),
      ),
      home: const FitnessShell(),
    );
  }
}

class FitnessShell extends StatefulWidget {
  const FitnessShell({super.key});

  @override
  State<FitnessShell> createState() => _FitnessShellState();
}

class _FitnessShellState extends State<FitnessShell> {
  int _currentIndex = 0;

  static const List<Widget> _screens = <Widget>[
    DashboardScreen(),
    WorkoutScreen(),
    NutritionScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.fitness_center), label: 'Тренировки'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Питание'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Профиль'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        _WelcomeHeader(),
        SizedBox(height: 16),
        _WeeklyScheduleCard(),
        SizedBox(height: 16),
        _TodayWorkoutCard(),
        SizedBox(height: 16),
        _MacroProgressCard(),
      ],
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Привет, Рустам 👋',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 6),
        Text(
          'Цель: набрать мышечную массу за 4 недели',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

class _WeeklyScheduleCard extends StatelessWidget {
  const _WeeklyScheduleCard();

  @override
  Widget build(BuildContext context) {
    const days = <String>['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Недельный прогресс',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: days
                  .map(
                    (day) => ChoiceChip(
                      selected: day == 'Вт' || day == 'Чт' || day == 'Сб',
                      label: Text(day),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            const Text('3 из 5 тренировок выполнено на этой неделе'),
          ],
        ),
      ),
    );
  }
}

class _TodayWorkoutCard extends StatelessWidget {
  const _TodayWorkoutCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Icon(Icons.flash_on_rounded),
                SizedBox(width: 8),
                Text(
                  'Сегодня: Спина + Бицепс',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _ExerciseTile(name: 'Тяга верхнего блока', sets: '4 x 12'),
            const _ExerciseTile(name: 'Тяга гантели к поясу', sets: '3 x 10'),
            const _ExerciseTile(name: 'Сгибания штанги', sets: '4 x 8'),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                label: const Text('Начать тренировку (45 мин)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseTile extends StatelessWidget {
  const _ExerciseTile({required this.name, required this.sets});

  final String name;
  final String sets;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(name),
          Text(sets, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _MacroProgressCard extends StatelessWidget {
  const _MacroProgressCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text('Питание сегодня', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            _MacroLine(label: 'Калории', progress: 0.72, target: '2160 / 3000 ккал'),
            _MacroLine(label: 'Белки', progress: 0.65, target: '130 / 200 г'),
            _MacroLine(label: 'Углеводы', progress: 0.78, target: '235 / 300 г'),
            _MacroLine(label: 'Жиры', progress: 0.54, target: '49 / 90 г'),
          ],
        ),
      ),
    );
  }
}

class _MacroLine extends StatelessWidget {
  const _MacroLine({required this.label, required this.progress, required this.target});

  final String label;
  final double progress;
  final String target;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$label • $target'),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const workouts = <(String, String, String)>[
      ('Понедельник', 'Грудь + Трицепс', '50 минут'),
      ('Среда', 'Ноги + Пресс', '55 минут'),
      ('Пятница', 'Спина + Плечи', '45 минут'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Text('План тренировок', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...workouts.map(
          (workout) => Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.fitness_center, size: 16)),
              title: Text(workout.$1),
              subtitle: Text(workout.$2),
              trailing: Text(workout.$3),
            ),
          ),
        ),
      ],
    );
  }
}

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const meals = <(String, String, String)>[
      ('Завтрак', 'Овсянка, яйца, банан', '620 ккал'),
      ('Обед', 'Рис, курица, овощи', '830 ккал'),
      ('Ужин', 'Лосось, картофель, салат', '590 ккал'),
      ('Перекус', 'Творог + орехи', '280 ккал'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Text('Дневник питания', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...meals.map(
          (meal) => Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant),
              title: Text(meal.$1),
              subtitle: Text(meal.$2),
              trailing: Text(meal.$3),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Добавить приём пищи'),
        ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('Профиль и прогресс', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          subtitle: Text('Отслеживай изменения тела и силовых показателей'),
        ),
        SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: Icon(Icons.monitor_weight_outlined),
            title: Text('Вес'),
            subtitle: Text('Было: 63.0 кг • Сейчас: 65.4 кг'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.ssid_chart),
            title: Text('Жим лёжа'),
            subtitle: Text('40 кг → 52.5 кг за 5 недель'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.flag_outlined),
            title: Text('Цель недели'),
            subtitle: Text('Сделать 4 тренировки и закрыть 90% плана по калориям'),
          ),
        ),
      ],
    );
  }
}
