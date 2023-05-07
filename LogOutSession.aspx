<%@ Page Language="C#"%>

<%
    Session["enrollment_number"] = "-1";
    Session["user_id"] = "-1";
    Session["user_type"] = "-1";
    Session.Clear();
    
%>
<script>
function OpenInNewTab(url) {
    
    var win = window.open(url, '_blank');
    window.self.close(); 
    win.focus();    
    return false;
}
    OpenInNewTab('Login.aspx');
</script>   