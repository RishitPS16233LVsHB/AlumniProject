<%--<%@ Language ="C#" %>--%>

<%
    void SessionCheck()
    {
        try
        {
            if (Session["enrollment_number"] == null || 
               Session["user_type"] == null ||
               Session["user_id"] == null ||
               Session["user_name"] == null )
                Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");

            else if (string.IsNullOrEmpty(Session["user_id"].ToString()) || string.IsNullOrEmpty(Session["enrollment_number"].ToString()) ||
                string.IsNullOrEmpty(Session["user_type"].ToString()) || string.IsNullOrEmpty(Session["user_name"].ToString()))
                  Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
        catch (Exception Error)
        {
            Response.Write("<script>if(confirm('Not in session')) document.location = 'LogOutSession.aspx';else  document.location = 'LogOutSession.aspx';</script>");
        }
    }
%>

