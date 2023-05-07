<%@ Page Language="C#"%>

<!DOCTYPE html>
<html>

    

<%  

    bool HasSqlInjection(string input)
    {
        // Define a list of SQL keywords and operators to check for
        string[] sqlKeywords = { "SELECT", "UPDATE", "DELETE", "INSERT", "INTO", "VALUES", "FROM", "WHERE", "OR", "AND", "NOT", "LIKE", "BETWEEN", "UNION", "JOIN", "ON", "ORDER BY", "GROUP BY", "HAVING", "LIMIT", "OFFSET", "UNION ALL", "DROP", "CREATE", "ALTER", "TRUNCATE", "TABLE", "INDEX", "CONSTRAINT", "PRIMARY KEY", "FOREIGN KEY", "CHECK", "DEFAULT", "CASCADE", "REFERENCES", "SET", "AS", "CASE", "WHEN", "THEN", "ELSE", "END", "COUNT", "SUM", "MAX", "MIN", "AVG", "DISTINCT", "TOP" };
        string[] sqlOperators = { "=", "<>", ">", "<", ">=", "<=", "LIKE", "IN", "IS", "NOT" };
        string[] sqlComments = { "--", "/*", "*/", ";" };

        // Check for SQL keywords, operators, and comments in the input string
        foreach (string keyword in sqlKeywords)
        {
            if (input.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0)
            {
                return true;
            }
        }
        foreach (string op in sqlOperators)
        {
            if (input.Contains(op))
            {
                return true;
            }
        }
        foreach (string comment in sqlComments)
        {
            if (input.Contains(comment))
            {
                return true;
            }
        }

        return false;
    }


    //require_once "FormValidations.aspx";
    //session_start();
    //echo $_SESSION['email'];

    string EnrollmentNumber = Request["email"];
    string Password = Request["password"];

    if (!string.IsNullOrEmpty(EnrollmentNumber) && !string.IsNullOrEmpty(Password))
    {
        if(HasSqlInjection(EnrollmentNumber) || HasSqlInjection(Password))
        {
            Response.Write("Has Sql Injection");
            return;
        }
        try
        {

            System.Security.Cryptography.SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
            byte[] Bytes = Encoding.ASCII.GetBytes(Password);
            byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
            string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

            string query = "select * from tbl_user where enrollment_number = " + EnrollmentNumber + " and password = '" + HashedPassword + "' and is_enabled = 'y'";
            string ConnectionString = "server=127.0.0.1;uid=root;pwd=root;database=Alumni_Association_System_Database";


            MySql.Data.MySqlClient.MySqlConnection connection = new MySql.Data.MySqlClient.MySqlConnection(ConnectionString);
            MySql.Data.MySqlClient.MySqlCommand Command = new MySql.Data.MySqlClient.MySqlCommand(query, connection);



            if (connection == null)
                Response.Write("not connected");
            else
                Response.Write("Connected");

            connection.Open();
            MySql.Data.MySqlClient.MySqlDataReader Data = Command.ExecuteReader();
            System.Data.DataTable DT = new System.Data.DataTable();
            DT.Load(Data);
            if (Data != null)
            {
                if (DT.Rows.Count == 1)
                {
                    //Response.Write("Query OK");
                    Session["enrollment_number"] = EnrollmentNumber;
                    Session["user_id"] = (int)DT.Rows[0]["user_id"];
                    Session["MY_USER_NAME_AND_IT_IS_FINAL"] = DT.Rows[0]["user_name"].ToString();
                    Session["user_type"] = (int)DT.Rows[0]["user_type"];
                    if ((int)DT.Rows[0]["user_type"] == 0)
                    {
                        //Response.Redirect("AdminPanel/html/index.aspx"); 
                        Response.Write("<script> function OpenInNewTab(url) { var win = window.open(url, '_blank'); window.self.close();win.focus(); return false;} OpenInNewTab('AdminPanel/html/index.aspx') </script>");
                    }
                    else
                    {
                        Response.Write("<script> function OpenInNewTab(url) { var win = window.open(url, '_blank'); window.self.close();win.focus(); return false;} OpenInNewTab('homePage.aspx') </script>");
                        //Response.Redirect("homePage.aspx");
                    }
                }
                else
                    Response.Write("<script>if(confirm('enrollment number or password is incorrect')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
            }

            connection.Close();
        }
        catch (Exception error)
        {
            Response.Write("<script>if(confirm('enrollment number required')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
        }
    }
    else
        Response.Write("<script>if(confirm('enrollment number or password is not provided')) document.location = 'Login.aspx';else  document.location = 'Login.aspx';</script>");
%>
</html>
