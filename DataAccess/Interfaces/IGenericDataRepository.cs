using DataObject.Model;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;

namespace DataAccess.Interfaces
{
    public interface IGenericDataRepository<T> where T : class
    {
        IList<ForumTopic> GetSearchForumTopics(out string trans, string keyword);
        IList<sp_GetForumTopicReply_Result> GetForumTopicReply(out string trans, int? ForumTopicFK);
        IList<T> GetAll(out string transMessage, params Expression<Func<T, object>>[] navigationProperties); 
        IList<T> GetList(out string transMessage, Func<T, bool> where, params Expression<Func<T, object>>[] navigationProperties);
        T GetSingle(out string transMessage, Func<T, bool> where, params Expression<Func<T, object>>[] navigationProperties);
        bool Add(out string transMessage, params T[] items);
        bool Update(out string transMessage, params T[] items);
        IList<sp_GetForumTopics_Result> GetForumTopics(out string trans);
    }

    public interface IUser : IGenericDataRepository<User> { }  
    public interface IForumTopic : IGenericDataRepository<ForumTopic> { }
    public interface ITopicReply : IGenericDataRepository<TopicReply> { } 
}
