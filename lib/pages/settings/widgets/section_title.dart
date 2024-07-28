Widget sectionTitle(String title) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          letterSpacing: 5,
          color: PomodoroUI.backgroundColor,
          fontStyle: GoogleFonts.kumbhSans().fontStyle,
          fontWeight: FontWeight.bold,
        ),
        textScaler: const TextScaler.linear(1),
      ),
    ),
  );
}
