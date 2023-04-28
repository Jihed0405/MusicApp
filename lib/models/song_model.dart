class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
     required this.description, 
     required this.url,
     required this.coverUrl});

     static List<Song> songs =[
      Song(title: 'Easy on me', description: 'Easy on me',
       url:'assets/music/Adele - Easy On Me.mp3',
        coverUrl: 'assets/images/Adele - Easy On Me.jpg'),
       Song(title: 'Positions',
        description: 'Positions', 
        url: 'assets/music/Ariana Grande - positions.mp3',
         coverUrl: 'assets/images/Ariana Grande - positions.jpg'),
          Song(title: 'Satellite',
        description: 'Satellite', 
        url: 'assets/music/Bebe Rexha & Snoop Dogg - Satellite.mp3',
         coverUrl: 'assets/images/Bebe Rexha & Snoop Dogg - Satellite.jpg'),
         
     ];
}