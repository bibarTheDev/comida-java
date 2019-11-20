<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String id = request.getParameter("id");
String nome = request.getParameter("nome");
String teste = request.getParameter("teste");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//verifica por pratos com aquele ingrediente
String sql = "INSERT INTO ingredientes VALUES (DEFAULT, '" + nome + "');";
boolean resp = Banco.noReturnQuery(sql);

%>

<%-- output de dados --%>
<%
    if(resp){
        out.print("success");
    }
    else{
        out.print("fail\n");
        throw new Exception("oh sh");
    }
%>

<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    out.print("Erro na pagina add-ingrediente.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>