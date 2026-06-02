using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using AppAuth.Models;

namespace AppAuth.Views;

public partial class UserWindow : Window
{
    private User? _user;

    public UserWindow()
    {
        InitializeComponent();
    }

    public UserWindow(User user)
    {
        InitializeComponent();

        _user = user;

        var text = this.FindControl<TextBlock>("UserInfoText");

        text.Text =
            $"Добро пожаловать, {_user.Login}\n" +
            $"Ваша роль: {_user.Role}";
    }

    private void InitializeComponent()
    {
        AvaloniaXamlLoader.Load(this);
    }

    public void OnLogoutClick(object? sender, RoutedEventArgs e)
    {
        var loginWindow = new LoginWindow();

        loginWindow.Show();

        this.Close();
    }
}