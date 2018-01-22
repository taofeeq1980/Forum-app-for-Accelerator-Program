using DataAccess.EntitiesModel;
using DataAccess.Interfaces;
using DataObject.Model;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace DataAccess.Respositories
{
    public class GenericDataRepository<T> : IGenericDataRepository<T> where T : class
    {
        public virtual IList<T> GetAll(out string transMessage, params Expression<Func<T, object>>[] navigationProperties)
        {
            transMessage = ""; 
            try
            {
                List<T> list;
                using (var context = new ForumAppDBEntities())
                {
                    IQueryable<T> dbQuery = context.Set<T>();
                    //Apply eager loading
                    dbQuery = navigationProperties.Aggregate(dbQuery, (current, navigationProperty) => current.Include(navigationProperty));

                    list = dbQuery
                        .AsNoTracking()
                        .ToList();
                }
                transMessage = list.Count > 0 ? "true" : "false";
                return list;
            }
            catch (Exception ex)
            {
                transMessage = ex.Message + ex.StackTrace;    
                return null;
            }
        }
        public virtual IList<T> GetList(out string transMessage, Func<T, bool> where, 
            params Expression<Func<T, object>>[] navigationProperties)
        {
            transMessage = "";
            try
            {
                List<T> list;
                using (var context = new ForumAppDBEntities())
                {
                    IQueryable<T> dbQuery = context.Set<T>();
                    //Apply eager loading
                    dbQuery = navigationProperties.Aggregate(dbQuery, (current, navigationProperty) => current.Include(navigationProperty));

                    list = dbQuery
                        .AsNoTracking()
                        .Where(where)
                        .ToList();
                }
                transMessage = list.Count > 0 ? "true" : "false";
                return list;
            }
            catch (Exception ex)
            {
                transMessage = ex.Message + ex.StackTrace;
                return null;
            }
        }
        public virtual T GetSingle(out string transMessage, Func<T, bool> where,
             params Expression<Func<T, object>>[] navigationProperties)
        {
            transMessage = "";
            try
            {
                T item;
                using (var context = new ForumAppDBEntities()) 
                {
                    IQueryable<T> dbQuery = context.Set<T>();

                    //Apply eager loading
                    dbQuery = navigationProperties.Aggregate(dbQuery, (current, navigationProperty) => current.Include(navigationProperty));

                    item = dbQuery
                        .AsNoTracking() //Don't track any changes for the selected item
                        .FirstOrDefault(where); //Apply where clause
                }
                transMessage = item != null ? "true" : "false";
                return item;
            }
            catch (Exception ex)
            {
                transMessage = ex.Message + ex.StackTrace;
                return null;
            }
        }

        public virtual bool Add(out string transMessage, params T[] items)
        {
            transMessage = "";
            using (var context = new ForumAppDBEntities())
            {
                using (var dbTran = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var item in items)
                        {
                            context.Entry(item).State = EntityState.Added; 
                        }
                        //saves all above operations within one transaction
                        var result = context.SaveChanges();
                        //commit transaction
                        dbTran.Commit();
                        transMessage = result > 0 ? "true" : "false";
                        return result > 0;
                    }
                    catch (Exception ex)
                    {
                        //Rollback transaction if exception occurs
                        dbTran.Rollback();
                        transMessage = ex.Message;
                        return false;
                    }
                }
            }
        }
        public virtual bool Update(out string transMessage, params T[] items)
        {
            transMessage = "";
            using (var context = new ForumAppDBEntities())
            {
                using (var dbTran = context.Database.BeginTransaction())
                {
                    try
                    {
                        foreach (var item in items)
                        {
                            context.Entry(item).State = EntityState.Modified;
                        }
                        //saves all above operations within one transaction
                        var result = context.SaveChanges();
                        //commit all transactions
                        dbTran.Commit();
                        transMessage = result  > 0 ? "true" : "false";
                        return result > 0;
                    }
                    catch (Exception ex)
                    {
                        //Rollback transaction if exception occurs
                        dbTran.Rollback();
                        transMessage = ex.Message;
                        return false;
                    }
                }
            }
        }
        public IList<sp_GetForumTopicReply_Result> GetForumTopicReply(out string trans, int? ForumTopicFK)
        {
            trans = "";
            try
            {
                IList<sp_GetForumTopicReply_Result> list;
                using (var cxt = new ForumAppDBEntities())
                {
                    var query = cxt.sp_GetForumTopicReply(ForumTopicFK);
                    list = query.ToList();
                }
                trans = list.Any() ? "success" : "No Forum Topic";
                return list;
            }
            catch (Exception ex)
            {
                trans = ex.Message + "#######" + ex.StackTrace;
                return null;
            }
        }
        public IList<sp_GetForumTopics_Result> GetForumTopics(out string trans)
        {
            trans = "";
            try
            {
                IList<sp_GetForumTopics_Result> list;
                using (var cxt = new ForumAppDBEntities())
                {
                    var query = cxt.sp_GetForumTopics();
                    list = query.ToList();
                }
                trans = list.Any() ? "true" : "No Topic found, please modified your search parameter";
                return list;
            }
            catch (Exception ex)
            {
                trans = ex.Message + "#######" + ex.StackTrace;
                return null;
            }
        }

        public IList<ForumTopic> GetSearchForumTopics(out string trans, string keyword) 
        {
            trans = "";
            try
            {
                IList<ForumTopic> list;
                using (var cxt = new ForumAppDBEntities())
                {
                    var query = cxt.ForumTopics.Where(p => p.ForumTitle.Contains(keyword));                  
                    list = query.ToList();
                }
                trans = list.Any() ? "success" : "No Forum Topic";
                return list;
            }
            catch (Exception ex)
            {
                trans = ex.Message + "#######" + ex.StackTrace;
                return null;
            }
        }
    }

    public class userRepository : GenericDataRepository<User>, IUser { } 
    public class TopicRepository : GenericDataRepository<ForumTopic>, IForumTopic { }
    public class RepliedRepository : GenericDataRepository<TopicReply>, ITopicReply { }
}

