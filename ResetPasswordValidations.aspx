<%@ Page Language="C#"%>

<!DOCTYPE html>
<%  
    
    //require_once "FormValidations.aspx";
    //session_start();
    //echo $_SESSION['email'];

    string EnrollmentNumber = Request["email"];
    string Password = Request["password"];

    if (!string.IsNullOrEmpty(EnrollmentNumber) && !string.IsNullOrEmpty(Password))
    {
        try
        {
            
            System.Security.Cryptography.SHA256Managed EncryptionAlgo = new System.Security.Cryptography.SHA256Managed();
            byte[] Bytes = Encoding.ASCII.GetBytes(Password);
            byte[] HashedBytes = EncryptionAlgo.ComputeHash(Bytes);
            string HashedPassword = BitConverter.ToString(HashedBytes).Replace("-", "");

            string query = "select * from tbl_user where enrollment_number = " + EnrollmentNumber + " and password = '" + HashedPassword + "'";
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
                    Response.Write("Query OK");
                    Session["enrollment_number"] = EnrollmentNumber;
                    Session["user_id"] = (int)DT.Rows[0]["user_id"];
                    Session["user_name"] = DT.Rows[0]["user_name"].ToString();
                    Session["user_type"] = (int)DT.Rows[0]["user_type"];
                    if ((int)DT.Rows[0]["user_type"] == 0)
                        Response.Redirect("AdminPanel/html/index.aspx");
                    else
                        Response.Redirect("homePage.aspx");
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
