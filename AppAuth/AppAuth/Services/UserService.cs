using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;
using AppAuth.Models;

namespace AppAuth.Services
{
    public class UserService
    {
        private const string UsersFilePath = "users.json";
        private List<User> _users = new();

        public UserService()
        {
            LoadUsers();
        }

        public bool AddUser(string login, string password, string role)
        {
            // Валидация входных данных
            if (string.IsNullOrWhiteSpace(login))
                return false;
            if (string.IsNullOrWhiteSpace(password))
                return false;
            if (string.IsNullOrWhiteSpace(role))
                role = "Пользователь";

            // Проверка на дублирование логина
            if (_users.Any(u => u.Login == login))
                return false;

            var newUser = new User
            {
                Id = GenerateUniqueId(),
                Login = login.Trim(),
                Password = HashPassword(password), // хешируем пароль
                Role = role,
                IsBlocked = false
            };

            _users.Add(newUser);
            SaveUsers();
            return true;
        }

        // Метод для генерации уникального ID
        private int GenerateUniqueId()
        {
            return _users.Count == 0 ? 1 : _users.Max(u => u.Id) + 1;
        }

        // Хеширование пароля (требуется установка пакета BCrypt.Net-Next)
        private string HashPassword(string password)
        {
            return BCrypt.Net.BCrypt.HashPassword(password);
        }

        // Проверка пароля
        public bool VerifyPassword(string enteredPassword, string storedHash)
        {
            return BCrypt.Net.BCrypt.Verify(enteredPassword, storedHash);
        }

        // Получение всех пользователей
        public List<User> GetAllUsers()
        {
            return new List<User>(_users);
        }

        // Блокировка пользователя
        public bool BlockUser(int userId)
        {
            var user = _users.FirstOrDefault(u => u.Id == userId);
            if (user != null)
            {
                user.IsBlocked = true;
                SaveUsers();
                return true;
            }
            return false;
        }

        // Разблокировка пользователя
        public bool UnblockUser(int userId)
        {
            var user = _users.FirstOrDefault(u => u.Id == userId);
            if (user != null)
            {
                user.IsBlocked = false;
                SaveUsers();
                return true;
            }
            return false;
        }

        private void LoadUsers()
        {
            try
            {
                if (File.Exists(UsersFilePath))
                {
                    var json = File.ReadAllText(UsersFilePath);
                    _users = JsonSerializer.Deserialize<List<User>>(json) ?? new List<User>();
                }
                else
                {
                    // Создаём пустой файл, если его нет
                    SaveUsers();
                }
            }
            catch (Exception ex)
            {
                // Логируем ошибку (в реальном приложении — в файл/лог)
                Console.WriteLine($"Ошибка загрузки пользователей: {ex.Message}");
                _users = new List<User>();
            }
        }

        private void SaveUsers()
        {
            try
            {
                var json = JsonSerializer.Serialize(_users, new JsonSerializerOptions
                {
                    WriteIndented = true
                });
                File.WriteAllText(UsersFilePath, json);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Ошибка сохранения пользователей: {ex.Message}");
                throw;
            }
        }
    }
}
