using AppAuth.Data;
using AppAuth.Models;

namespace AppAuth.ViewModels;

public class LoginViewModel
{
    public string Login { get; set; } = "";
    public string Password { get; set; } = "";

    public User? AuthenticatedUser { get; private set; }

    public string ErrorMessage { get; private set; } = "";

    public bool LoginUser()
    {
        ErrorMessage = "";

        if (string.IsNullOrWhiteSpace(Login) || string.IsNullOrWhiteSpace(Password))
        {
            ErrorMessage = "Заполните все поля";
            return false;
        }

        var user = Database.Authenticate(Login, Password);

        if (user == null)
        {
            ErrorMessage = "Неверный логин или пароль";
            return false;
        }

        AuthenticatedUser = user;
        return true;
    }
}