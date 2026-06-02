using System.Collections.Generic;
using System.IO;
using System.Linq;
using AppAuth.Models;
using Newtonsoft.Json;

namespace AppAuth.Data
{
    public static class Database
    {
        private static string _filePath = "users.json";

        private static List<User> _users = new();

        static Database()
        {
            Load();
        }

        public static void Load()
        {
            if (!File.Exists(_filePath))
            {
                _users = new List<User>
                {
                    new User
                    {
                        Id = 1,
                        Login = "admin",
                        Password = "123",
                        Role = "Администратор"
                    }
                };

                Save();
                return;
            }

            string json = File.ReadAllText(_filePath);

            _users = JsonConvert.DeserializeObject<List<User>>(json)
                     ?? new List<User>();
        }

        public static void Save()
        {
            string json = JsonConvert.SerializeObject(_users, Formatting.Indented);

            File.WriteAllText(_filePath, json);
        }

        public static List<User> GetAllUsers()
        {
            return _users;
        }

        public static User? Authenticate(string login, string password)
        {
            var user = _users.FirstOrDefault(x => x.Login == login);

            if (user == null)
                return null;

            if (user.IsBlocked)
                return null;

            if (user.Password != password)
            {
                user.FailedAttempts++;

                if (user.FailedAttempts >= 3)
                {
                    user.IsBlocked = true;
                }

                Save();
                return null;
            }

            user.FailedAttempts = 0;

            Save();
            return user;
        }

        public static bool UserExists(string login)
        {
            return _users.Any(x => x.Login == login);
        }

        public static void AddUser(User user)
        {
            user.Id = _users.Any() ? _users.Max(x => x.Id) + 1 : 1;

            _users.Add(user);

            Save();
        }

        public static void DeleteUser(int id)
        {
            var user = _users.FirstOrDefault(x => x.Id == id);

            if (user != null)
            {
                _users.Remove(user);
                Save();
            }
        }

        public static void UpdateUser(User user)
        {
            var existing = _users.FirstOrDefault(x => x.Id == user.Id);

            if (existing != null)
            {
                existing.Login = user.Login;
                existing.Password = user.Password;
                existing.Role = user.Role;
                existing.IsBlocked = user.IsBlocked;

                Save();
            }
        }
    }
}