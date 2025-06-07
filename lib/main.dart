gimport 'package:flutter/material.dart';

import 'package:myapp/models/weekly_plan.dart';
import 'package:myapp/models/music_track.dart'; // Import the MusicTrack model
import 'package:myapp/services/audio_service.dart'; // Import the AudioService
void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Required for audioplayers
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.blueGrey[900], // A calm, muted primary color for dark mode
          // You can customize other colors here as needed
        ),
        // You can further customize other theme properties here,
        // like text themes, button themes, etc.
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
  late AudioService _audioService; // Declare the audio service
  final List<DailyPlan> weeklyPlan = [
    DailyPlan(activityType: "ASMR Story", details: "The Enchanted Forest"),
    DailyPlan(activityType: "Breathing Exercise", details: "Box Breathing Technique"),
    DailyPlan(activityType: "Calm Music Session", details: "Rainy Day Sounds"),
    DailyPlan(activityType: "Guided Meditation", details: "Body Scan for Relaxation"),
    DailyPlan(activityType: "ASMR Story", details: "Whispers of the Ocean"),
    DailyPlan(activityType: "Journaling Prompt", details: "Reflect on your day"),
    DailyPlan(activityType: "Calm Music Session", details: "Forest Ambiance"),
  ];
  final List<MusicTrack> musicLibrary = [
    MusicTrack(title: "White Noise", audioUrl: 'https://file-examples-com.github.io/uploads/2017/11/file_example_WAV_1MG.wav'), // Placeholder URL
    MusicTrack(title: "Ocean Waves", audioUrl: 'https://file-examples-com.github.io/uploads/2017/11/file_example_WAV_1MG.wav'), // Placeholder URL
    MusicTrack(title: "Forest Sounds", audioUrl: 'https://file-examples-com.github.io/uploads/2017/11/file_example_WAV_1MG.wav'), // Placeholder URL
  ];

  @override
  void initState() {
    super.initState();
    _audioService = AudioService(); // Initialize the audio service
  }

  @override
  void dispose() {
    _audioService.dispose(); // Dispose of the audio service
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calm App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week-wise Plan',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: weeklyPlan.length,
                itemBuilder: (context, index) {
                  final day = weeklyPlan[index];
                  final dayOfWeek = [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ][index];
                  return ListTile(
                    title: Text('$dayOfWeek: ${day.activityType}'),
                    subtitle: Text(day.details),
                    onTap: () {
                      if (day.activityType == "ASMR Story") {
                        _audioService.play('https://file-examples-com.github.io/uploads/2017/11/file_example_WAV_1MG.wav'); // Placeholder URL
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16), // Spacing between sections
            // Calm Music Library Section
            Text(
              'Calm Music Library',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: musicLibrary.length,
                itemBuilder: (context, index) {
                  final track = musicLibrary[index];
                  return ListTile(
                    title: Text(track.title),
                    onTap: () {
                      _audioService.play(track.audioUrl);
                    },
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
