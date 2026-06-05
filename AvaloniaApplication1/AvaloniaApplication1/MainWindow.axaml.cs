using System.Linq;
using System.Net.Http;
using System.Text.RegularExpressions;
using Avalonia.Controls;
using Avalonia.Interactivity;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using Newtonsoft.Json;

namespace AvaloniaApplication1;

public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void GetDataFromAPI(object? sender, RoutedEventArgs e)
    {
        HttpClient client = new HttpClient();
        HttpRequestMessage request =
            new HttpRequestMessage(HttpMethod.Get, "http://62.109.5.161:4444/TransferSimulator/email");
        var res =  client.Send(request);
        dynamic json = JsonConvert.DeserializeObject(res.Content.ReadAsStringAsync().Result);
        email.Text = json.value;
    }

    private void SendResultTest(object? sender, RoutedEventArgs e)
    {
        string file = "ТестКейс.docx";

        string pattern = @"^[^@]+@[^@]+\.[^@]+$";
        //паттерны
        //"^\d{2} \d{2} \d{6}$" - паспорт
        //"^[^@]+@[^@]+\.[^@]+$"  - email
        //"^\+7 \d{3} \d{3}-\d{2}-\d{2}$" - номер телефона
        Regex regex = new Regex(pattern);

        if (regex.IsMatch(email.Text ?? ""))
        {
            Result.Text = "почта корректная";
            //успешный вариант теста
                ReplaceTextInDocx(file, "Result" , "Успешно"); //в документе поменяются данные, только тогда, когда там будет стоять маркер - Result
        }
        else
        {
            Result.Text = "почта не корректная";
            //неуспешный ваиант теста
            ReplaceTextInDocx(file, "#res#", "Не успешно"); //в документе поменяются данные, только тогда, когда там будет стоять маркер - #res#

        }
    }
    
    
    private void ReplaceTextInDocx(string file, string searchText, string replaceText)
    {
        using (WordprocessingDocument doc = WordprocessingDocument.Open(file, true))
        {
            var body = doc.MainDocumentPart.Document.Body;
            var runs = body.Descendants<Run>();

            foreach (var run in runs)
            {
                var found = run.Elements<Text>().Where(t => t.Text.StartsWith(searchText)).FirstOrDefault();

                if (found != null)
                {
                    found.Text = replaceText;
                    break;
                }
            }
            doc.MainDocumentPart.Document.Save();
        }
    }
    
}