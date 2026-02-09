using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Text;

namespace BK.Controllers
{
    public class ProfileController : Controller
    {
        private readonly string _usersFile = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "users.txt");

        private string? GetCurrentLogin() => HttpContext.Session.GetString("LoggedUser");

        private string[]? GetUserData(string login)
        {
            if (!System.IO.File.Exists(_usersFile)) return null;

            var lines = System.IO.File.ReadAllLines(_usersFile);
            foreach (var line in lines)
            {
                var parts = line.Split(';');
                if (parts.Length >= 1 && parts[0].Trim().ToLower() == login.ToLower())
                    return parts;
            }
            return null;
        }

        public IActionResult Index()
        {
            var login = GetCurrentLogin();
            if (string.IsNullOrEmpty(login))
                return RedirectToAction("Login", "Account");

            var data = GetUserData(login);
            if (data == null || data.Length < 6)
                return Content("Ошибка: пользователь не найден");

            ViewBag.Login = data[0];
            ViewBag.Name = data[2];
            ViewBag.Status = data[3];
            ViewBag.City = data[4];
            ViewBag.About = data[5];

            return View();
        }

        [HttpPost]
        public IActionResult Save(string name, string status, string city, string about)
        {
            var login = GetCurrentLogin();
            if (string.IsNullOrEmpty(login))
                return RedirectToAction("Login", "Account");

            if (!System.IO.File.Exists(_usersFile))
                return Content("Файл пользователей не найден");

            var lines = System.IO.File.ReadAllLines(_usersFile);
            var newLines = new List<string>();

            foreach (var line in lines)
            {
                var parts = line.Split(';');
                if (parts.Length >= 1 && parts[0].Trim().ToLower() == login.ToLower())
                {
                    // обновляем
                    var updated = $"{login};{parts[1]};{name ?? ""};{status ?? ""};{city ?? ""};{about ?? ""}";
                    newLines.Add(updated);
                }
                else
                {
                    newLines.Add(line);
                }
            }

            System.IO.File.WriteAllLines(_usersFile, newLines);

            return RedirectToAction("Index");
        }
    }
}