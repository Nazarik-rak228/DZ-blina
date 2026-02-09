using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Text;

namespace BK.Controllers
{
    public class AccountController : Controller
    {
        private readonly string _usersFile = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "users.txt");

        [HttpGet]
        public IActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Register(string login, string password, string name)
        {
            if (string.IsNullOrWhiteSpace(login) || string.IsNullOrWhiteSpace(password))
            {
                ViewBag.Error = "Логин и пароль обязательны";
                return View();
            }

            login = login.Trim().ToLower();
            password = password.Trim();

            // провурка, существует ли уже профиль
            if (System.IO.File.Exists(_usersFile))
            {
                var lines = System.IO.File.ReadAllLines(_usersFile);
                foreach (var line in lines)
                {
                    var parts = line.Split(';');
                    if (parts.Length >= 1 && parts[0].Trim().ToLower() == login)
                    {
                        ViewBag.Error = "Такой логин уже занят";
                        return View();
                    }
                }
            }

            // пишем нового пользователя
            var newLine = $"{login};{password};{name ?? login};;;";
            System.IO.File.AppendAllText(_usersFile, newLine + Environment.NewLine);

            // сразу "логиним"
            HttpContext.Session.SetString("LoggedUser", login);

            return RedirectToAction("Index", "Profile");
        }

        [HttpGet]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Login(string login, string password)
        {
            login = login?.Trim().ToLower() ?? "";
            password = password?.Trim() ?? "";

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(password))
            {
                ViewBag.Error = "Заполни поля";
                return View();
            }

            if (!System.IO.File.Exists(_usersFile))
            {
                ViewBag.Error = "Нет пользователей";
                return View();
            }

            var lines = System.IO.File.ReadAllLines(_usersFile);
            foreach (var line in lines)
            {
                var parts = line.Split(';');
                if (parts.Length >= 2 &&
                    parts[0].Trim().ToLower() == login &&
                    parts[1].Trim() == password)
                {
                    HttpContext.Session.SetString("LoggedUser", login);
                    return RedirectToAction("Index", "Profile");
                }
            }

            ViewBag.Error = "Неверный логин или пароль";
            return View();
        }

        public IActionResult Logout()
        {
            HttpContext.Session.Remove("LoggedUser");
            return RedirectToAction("Index", "Home");
        }
    }
}