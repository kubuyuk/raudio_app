class Song {
  int progress_ms;
  int duration_ms;
  bool isPlaying;
  String uri;
  String name;
  String artist;
  String image;

  Song(
      {this.progress_ms,
      this.duration_ms,
      this.isPlaying,
      this.uri,
      this.name,
      this.artist,
      this.image});
}
