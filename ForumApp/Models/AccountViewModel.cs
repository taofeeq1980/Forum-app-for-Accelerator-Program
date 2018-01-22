using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ForumApp.Models
{

    public class LoginViewModel
    {
        [Required(ErrorMessage = "*")]
        [Display(Name = "Username")]
        [DataType(DataType.Text)]
        //[EmailAddress]
        public string Username { get; set; }

        [Required(ErrorMessage = "*")]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }
    }

    public class RegisterViewModel
    {
        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Username")] 
        public string Username { get; set; }

        [Required]
        [DataType(DataType.Text)]
        [Display(Name = "Full Name")]
        public string FullName { get; set; }               

        [Required]
        [StringLength(100, ErrorMessage = "The {0} must be at least {2} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }

        public string Rolename { get; set; } = "User";

    }
}