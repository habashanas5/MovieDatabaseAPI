namespace MovieDatabaseAPI.Models
{
    public class Movie
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Genre { get; set; }
        public string Director { get; set; }
        public int ReleaseYear { get; set; }
        public int WatchCount { get; set; }
        public double Rating { get; set; }  
    }
}