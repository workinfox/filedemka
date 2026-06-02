using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using AppAuth.Data;
using AppAuth.Models;
using System.Linq;

namespace AppAuth.Views;

public partial class AdminWindow : Window
{
    public AdminWindow()
    {
        InitializeComponent();
        LoadUsers();
    }

    private void InitializeComponent()
    {
        AvaloniaXamlLoader.Load(this);
    }

    private void LoadUsers()
    {
        var list = this.FindControl<ListBox>("UsersList");

        list.ItemsSource = Database.GetAllUsers()
            .Select(x =>
                $"{x.Id} | {x.Login} | {x.Role} | Блокировка: {x.IsBlocked}")
            .ToList();
    }

    public void OnCreateUser(object sender, RoutedEventArgs args)
    {
        var login = this.FindControl<TextBox>("LoginBox");
        var password = this.FindControl<TextBox>("PasswordBox");
        var roleBox = this.FindControl<ComboBox>("RoleBox");
        var info = this.FindControl<TextBlock>("InfoText");

        if (Database.UserExists(login.Text ?? ""))
        {
            info.Text = "Пользователь уже существует";
            return;
        }

        string role = "Пользователь";

        if (roleBox.SelectedItem is ComboBoxItem item)
        {
            role = item.Content?.ToString() ?? "Пользователь";
        }

        Database.AddUser(new User
        {
            Login = login.Text ?? "",
            Password = password.Text ?? "",
            Role = role
        });

        info.Text = "Пользователь создан";

        LoadUsers();
    }

    public void OnDeleteUser(object sender, RoutedEventArgs args)
    {
        var list = this.FindControl<ListBox>("UsersList");

        if (list.SelectedIndex == -1)
            return;

        var user = Database.GetAllUsers()[list.SelectedIndex];

        Database.DeleteUser(user.Id);

        LoadUsers();
    }

    public void OnBlockUser(object sender, RoutedEventArgs args)
    {
        var list = this.FindControl<ListBox>("UsersList");

        if (list.SelectedIndex == -1)
            return;

        var user = Database.GetAllUsers()[list.SelectedIndex];

        user.IsBlocked = true;

        Database.UpdateUser(user);

        LoadUsers();
    }

    public void OnEditUser(object sender, RoutedEventArgs args)
    {
        var list = this.FindControl<ListBox>("UsersList");

        if (list.SelectedIndex == -1)
            return;

        var user = Database.GetAllUsers()[list.SelectedIndex];

        user.Password = "newpassword";

        Database.UpdateUser(user);

        LoadUsers();
    }

    public void OnLogoutClick(object sender, RoutedEventArgs args)
    {
        new LoginWindow().Show();

        Close();
    }
}