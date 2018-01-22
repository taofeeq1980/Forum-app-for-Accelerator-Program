using BusinessLogic;
using DataObject.Model;
using ForumApp.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Microsoft.Owin.Security;


namespace ForumApp.Controllers
{
    public class AccountController : Controller
    {
        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;
        private readonly BusinessLayer _repository = new BusinessLayer();

        public ActionResult SignOut()  
        {
            var AuthenticationManager = HttpContext.GetOwinContext().Authentication;
            AuthenticationManager.SignOut(DefaultAuthenticationTypes.ApplicationCookie);           
            Session.RemoveAll();
            return RedirectToAction("Topics", "Forum");
        }
        // GET: Account
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [HttpPost]
        public async Task<ActionResult> Login(LoginViewModel model, string returnUrl)
        {
            var store = new UserStore<ApplicationUser>(new ApplicationDbContext());
            var userManager = new UserManager<ApplicationUser>(store);
            var user = userManager.FindByNameAsync(model.Username).Result;
            if (user == null)
            {
                ModelState.AddModelError("", "Invalid login attempt.");
                return View(model);
            }
            // To enable password failures to trigger account lockout, change to shouldLockout: true
            var result = await SignInManager.PasswordSignInAsync(model.Username, model.Password, false, shouldLockout: false);
            switch (result)
            {
                case SignInStatus.Success:
                    return !string.IsNullOrWhiteSpace(returnUrl) ? RedirectToLocal(returnUrl) : RedirectToAction("Topics", "Forum");
                case SignInStatus.Failure:
                    ModelState.AddModelError("", "login failure (username/password missing.");
                    return View(model);
                default:
                    ModelState.AddModelError("", "Invalid login attempt.");
                    return View(model);
            }
        }
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Register(RegisterViewModel model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", "Check your input"); // AddModelError(ModelState);
                return View(model);
            }
            var appuser = new ApplicationUser
            {
                UserName = model.Username,
                Email = model.Username.Contains("@") ? model.Username : model.Username + "@netforum.com",
                FirstName = model.FullName.Split(' ')[0],
                LastName = model.FullName.Split(' ').Length > 1 ? model.FullName.Split(' ')[1] : model.FullName.Split(' ')[0],
                PhoneNumber = "",
                EmailConfirmed = true,
                PhoneNumberConfirmed = true,
                LockoutEnabled = false
            };
            var result = await UserManager.CreateAsync(appuser, model.Password);
            if (result.Succeeded)
            {
                //Insert into User Table
                var user = new User { UserId = appuser.Id, Username = appuser.UserName };
                string trans;
                _repository.AddUser(out trans, user);
                //Assign Role to user Here 
                result = await UserManager.AddToRoleAsync(appuser.Id, model.Rolename);
                //Ends Here                     
                if (result.Succeeded)
                {
                    await SignInManager.SignInAsync(appuser, false, false);
                    return RedirectToAction("Topics", "Forum");
                }
            }
            ModelState.AddModelError("", result.Errors.First());
            return View(model);
        }
        public ActionResult Register()
        {
            return View();
        }
        private ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            set
            {
                _signInManager = value;
            }
        }
        private ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            set
            {
                _userManager = value;
            }
        }
        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            return RedirectToAction("Forum", "Topics");
        }
    }
}