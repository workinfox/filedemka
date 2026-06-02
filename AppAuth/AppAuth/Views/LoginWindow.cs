using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using AppAuth.Data;
using System.Collections.Generic;

namespace AppAuth.Views;

public partial class LoginWindow : Window
{
    private readonly List<int> _captcha = new();

    public LoginWindow()
    {
        InitializeComponent();
    }

    private void InitializeComponent()
    {
        AvaloniaXamlLoader.Load(this);
    }

    public void CaptchaClick1(object? sender, RoutedEventArgs e)
    {
        _captcha.Add(3);
        UpdateCaptchaText();
    }

    public void CaptchaClick2(object? sender, RoutedEventArgs e)
    {
        _captcha.Add(1);
        UpdateCaptchaText();
    }

    public void CaptchaClick3(object? sender, RoutedEventArgs e)
    {
        _captcha.Add(4);
        UpdateCaptchaText();
    }

    public void CaptchaClick4(object? sender, RoutedEventArgs e)
    {
        _captcha.Add(2);
        UpdateCaptchaText();
    }

    private void UpdateCaptchaText()
    {
        var text = this.FindControl<TextBlock>("CaptchaText");

        text.Text = "Выбрано: " + string.Join(" ", _captcha);
    }

    public void OnLoginClick(object? sender, RoutedEventArgs args)
    {
        var loginBox = this.FindControl<TextBox>("LoginTextBox");
        var passwordBox = this.FindControl<TextBox>("PasswordTextBox");
        var error = this.FindControl<TextBlock>("ErrorTextBlock");

        string result = string.Join("", _captcha);

        if (result != "1234")
        {
            error.Text = "Капча введена неверно";

            _captcha.Clear();

            UpdateCaptchaText();

            return;
        }

        var user = Database.Authenticate(
            loginBox.Text ?? "",
            passwordBox.Text ?? ""
        );

        if (user == null)
        {
            error.Text = "Неверный логин или пароль";

            return;
        }

        if (user.Role == "Администратор")
        {
            new AdminWindow().Show();
        }
        else
        {
            new UserWindow(user).Show();
        }

        this.Close();
    }
}