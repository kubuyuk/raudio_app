class Song {
  int progressMs;
  int durationMs;
  bool isPlaying;
  String uri;
  String name;
  String artist;
  String image;

  Song(
      {this.progressMs,
      this.durationMs,
      this.isPlaying,
      this.uri,
      this.name,
      this.artist,
      this.image});
}
