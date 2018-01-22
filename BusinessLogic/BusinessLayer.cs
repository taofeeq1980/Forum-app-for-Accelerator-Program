using DataAccess.Interfaces;
using DataAccess.Respositories;
using DataObject.Model;
using System.Collections.Generic;
using System.Linq;

namespace BusinessLogic
{
    public class BusinessLayer : IBusinessLayer
    {
        readonly IUser _user;
        readonly IForumTopic _forumTopic;
        readonly ITopicReply _topicReply;

        public BusinessLayer()
        {
            _user = new userRepository();
            _forumTopic = new TopicRepository();
            _topicReply = new RepliedRepository(); 
        }
        public User GetUser(out string transMessage, string username) 
        {
            return _user.GetSingle(out transMessage, x=> x.Username == username);
        }
        public bool AddUser(out string transMessage, params User[] item)
        {
            return _user.Add(out transMessage, item);
        }
        public bool AddTopicReply(out string transMessage, params TopicReply[] item)
        {
            return _topicReply.Add(out transMessage, item);
        }
        public bool AddForumTopic(out string transMessage, params ForumTopic[] item)
        {
            return _forumTopic.Add(out transMessage, item);
        }
        public IList<sp_GetForumTopics_Result> GetForumTopics(out string trans, int? ForumId = 0)
        {
            var retVal = _forumTopic.GetForumTopics(out trans);
            if (retVal == null) return retVal;
            return retVal.Any() && ForumId == 0 ? retVal : retVal.Where(x => x.ID == ForumId).ToArray();
        }
        public IList<sp_GetForumTopicReply_Result> GetForumTopicReply(out string trans, int? ForumTopicFK)
        {
            var retVal = _topicReply.GetForumTopicReply(out trans, ForumTopicFK);             
            return retVal;
        }

        public IList<ForumTopic> GetSearchForumTopics(out string trans, string keyword)
        {
            return _forumTopic.GetSearchForumTopics(out trans, keyword);
        }
    }
}
