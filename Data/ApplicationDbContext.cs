using Microsoft.EntityFrameworkCore;
using MovieDatabaseAPI.Models;
using System.Data;

namespace MovieDatabaseAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<Movie> Movies { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //modelBuilder.Entity<Movie>().ToTable("Movies");
            modelBuilder.Entity<Movie>().ToTable("movies_partitioned");
            modelBuilder.Entity<Movie>()
                .HasIndex(m => m.Genre); 
            modelBuilder.Entity<Movie>()
                .HasIndex(m => m.Director);
        }
    }
}
