using BusinessLogic;
using DataObject.Model;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ForumApp.Controllers
{
    public class ForumController : Controller
    {
        private IBusinessLayer repository = new BusinessLayer();

        [AllowAnonymous]
        public ActionResult SearchTopic(string q)
        {
            string trans;
            var model = repository.GetSearchForumTopics(out trans, q);
            ViewBag.Error = trans != "true" ? trans : "";            
            return View(model);
        }
        // GET: Forum
        [Authorize(Roles = "User")]
        public ActionResult NewTopic()
        {
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "User")]
        public ActionResult NewTopic(ForumTopic model)
        {
            string trans = "";
            var ctx = new ForumTopic
            {
                ForumDesc = model.ForumDesc,
                DatePosted = DateTime.Now.ToString("dd/MM/yyyy"),
                ForumTitle = model.ForumTitle,
                ID = 0,
                PostedBy = GetUserId(),
                TimePosted = DateTime.Now.ToString("hh:mm:ss tt")
            };

            ForumTopic[] item = new[] { ctx };
            if (repository.AddForumTopic(out trans, ctx))
                return RedirectToAction("Topics", "Forum");

            ViewBag.Error = trans;
            return View(model);
        }

        [AllowAnonymous]
        public ActionResult Topics()
        {
            string trans = "";
            var model = GetForumTopics(out trans);
            return View(model);
        }
        [Authorize(Roles = "User")]
        public ActionResult ReplyTopics(IEnumerable<sp_GetForumTopics_Result> model, string Id)
        {
            string trans = "";
            model = model != null && model.Any() ? model : GetForumTopics(out trans, Id != null ? Convert.ToInt32(Id) : 0);
            var tuple1 = model.FirstOrDefault(x => x.ID == Convert.ToInt32(Id));
            var tuple2 = GetTopicReplies(out trans, Convert.ToInt32(Id));
            var tuple = new Tuple<sp_GetForumTopics_Result, IEnumerable<sp_GetForumTopicReply_Result>>(tuple1, tuple2);
            return View(tuple);
        }

        [HttpPost]
        [Authorize(Roles = "User")]
        public ActionResult ReplyTopics(sp_GetForumTopics_Result tuple, FormCollection c)
        {
            try
            {
                string transMessage = "";
                var repliedMessage = c["newreply"];
                tuple.ID = Convert.ToInt32(c["Item1.ID"]);
                var topicReply = new TopicReply
                {
                    DateReplied = DateTime.Now.ToString("dd/MM/yyyy"),
                    ForumTopicFK = tuple.ID,
                    ReplyMessage = repliedMessage,
                    RepliedBy = GetUserId(),
                    TimeReplied = DateTime.Now.ToString("hh:mm:ss tt")
                };

                TopicReply[] item = new[] { topicReply };
                if (repository.AddTopicReply(out transMessage, item))
                    return RedirectToAction("ReplyTopics", "Forum", new { Id = topicReply.ForumTopicFK.ToString() });

                ViewBag.Error = transMessage;
                return View(tuple);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message + "#####" + ex.StackTrace;
                return View(tuple);
            }
        }
        private long? GetUserId()
        {
            string transMessage = "";
            var username = User.Identity.GetUserName();
            return repository.GetUser(out transMessage, username).ID;
        }
        private IEnumerable<sp_GetForumTopics_Result> GetForumTopics(out string trans, int? ForumId = 0)
        {
            try
            {
                return repository.GetForumTopics(out trans, ForumId);
            }
            catch (Exception ex)
            {
                trans = ex.Message + "#####" + ex.StackTrace;
                return new List<sp_GetForumTopics_Result>();
            }
        }

        private IEnumerable<sp_GetForumTopicReply_Result> GetTopicReplies(out string trans, int? ForumTopicFK)
        {
            try
            {
                return repository.GetForumTopicReply(out trans, ForumTopicFK);
            }
            catch (Exception ex)
            {
                trans = ex.Message + "#####" + ex.StackTrace;
                return new List<sp_GetForumTopicReply_Result>();
            }
        }
    }
}