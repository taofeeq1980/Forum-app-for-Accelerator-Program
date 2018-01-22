using DataObject.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogic
{
    public interface IBusinessLayer
    {
        IList<sp_GetForumTopicReply_Result> GetForumTopicReply(out string trans, int? ForumTopicFK);
        User GetUser(out string transMessage, string username);
        bool AddUser(out string transMessage, params User[] item); 
        bool AddTopicReply(out string transMessage, params TopicReply[] item);
        bool AddForumTopic(out string transMessage, params ForumTopic[] item);
        IList<sp_GetForumTopics_Result> GetForumTopics(out string trans, int? ForumId = 0);
        IList<ForumTopic> GetSearchForumTopics(out string trans, string keyword);
    }
}
