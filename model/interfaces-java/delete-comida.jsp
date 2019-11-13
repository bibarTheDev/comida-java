<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String id = request.getParameter("id");
String teste = request.getParameter("teste");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//deleta a relacao
String sql = "DELETE FROM rel_ingredientes WHERE comida = " + id + ";";    
boolean resp = Banco.noReturnQuery(sql);

if(resp == false){
    throw new Exception("selp");
}

sql = "DELETE FROM comida WHERE id = " + id + ";";    
resp = Banco.noReturnQuery(sql);

%>

<%-- output de dados --%>
<%
    if(resp == true){
        out.print("success");
    }
    else{
        out.print("fail\n");
        throw new Exception("welp");
    }
%>

<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    out.print("Erro na pagina delete-comida.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>