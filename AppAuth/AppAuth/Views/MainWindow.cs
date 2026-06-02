using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;

namespace AppAuth.Views;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
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

    public void OnAdminClick(object? sender, RoutedEventArgs e)
    {
        var adminWindow = new AdminWindow();

        adminWindow.Show();
    }
}