<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

//Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost

String sql = "DELETE FROM comida WHERE id = "+request.getParameter("id")+";";    
boolean resp = Banco.noReturnQuery(sql);

%>

<%-- output de dados --%>
<%
    if(resp == true){
        %> success <%
    }
    else{
        %> Fail <%
    }
%>

<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    %> Erro na pagina delete-comida.jsp: <br><%
    for(String log : Banco.getErrorList()){
        %><%= log %><br><%
    }
    %><%= ex.getMessage() %><br><%
}
%>