namespace AppAuth.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Login { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Role { get; set; } = "Пользователь";
        public bool IsBlocked { get; set; } = false;
        public int FailedAttempts { get; set; } = 0;
    }
}