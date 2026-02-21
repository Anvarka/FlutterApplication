import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessFuelApp());
}

class FitnessFuelApp extends StatelessWidget {
  const FitnessFuelApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF4D6BFF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness & Nutrition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E5BFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const _pages = [
    _DashboardPage(),
    _WorkoutPlanPage(),
    _NutritionPage(),
    _ProgressPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Workout',
          ),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Food'),
          NavigationDestination(icon: Icon(Icons.show_chart), label: 'Progress'),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _Header(),
        SizedBox(height: 16),
        _QuickStats(),
        SizedBox(height: 16),
        _TodayWorkoutCard(),
        SizedBox(height: 16),
        _CaloriesCard(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Привет, чемпион! 👋',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Твоя цель: набор мышц за 4 недели',
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatTile(label: 'Вес', value: '75.0 кг', icon: Icons.monitor_weight),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _StatTile(label: 'Тренировки', value: '3/5', icon: Icons.sports_gymnastics),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(color: Colors.white70)),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
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
          children: [
            const Text(
              'Сегодня: Верх тела',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Жим лёжа, тяга в наклоне, разводка — 45 минут.'),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow),
              label: const Text('Начать тренировку'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CaloriesCard extends StatelessWidget {
  const _CaloriesCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Питание на сегодня',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.68),
            const SizedBox(height: 8),
            const Text('2040 / 3000 ккал'),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Добавить приём пищи'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutPlanPage extends StatelessWidget {
  const _WorkoutPlanPage();

  @override
  Widget build(BuildContext context) {
    const workouts = [
      ('Понедельник', 'Грудь + Трицепс'),
      ('Среда', 'Спина + Бицепс'),
      ('Пятница', 'Ноги + Плечи'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'План тренировок',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        ...workouts.map(
          (item) => Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(item.$1),
              subtitle: Text(item.$2),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}

class _NutritionPage extends StatelessWidget {
  const _NutritionPage();

  @override
  Widget build(BuildContext context) {
    const meals = [
      ('Завтрак', 'Овсянка + яйца', '620 ккал'),
      ('Обед', 'Рис + курица + овощи', '830 ккал'),
      ('Ужин', 'Лосось + картофель', '590 ккал'),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Питание', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        ...meals.map(
          (meal) => Card(
            child: ListTile(
              title: Text(meal.$1),
              subtitle: Text(meal.$2),
              trailing: Text(meal.$3),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressPage extends StatelessWidget {
  const _ProgressPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text(
          'Прогресс',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Icon(Icons.monitor_weight_outlined),
            title: Text('Вес'),
            subtitle: Text('Было: 73.8 кг  •  Сейчас: 75.0 кг'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Силовые показатели'),
            subtitle: Text('Жим лёжа: 60 → 72.5 кг'),
          ),
        ),
      ],
    );
  }
}
