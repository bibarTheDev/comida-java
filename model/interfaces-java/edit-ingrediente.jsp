<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String id = request.getParameter("id");
String nome = request.getParameter("nome"); //status da operacao: 0- sucesso, 1- fracasso (ainda ha pratos associados), 2- erro
String teste = request.getParameter("teste");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//verifica por pratos com aquele ingrediente
String sql = "UPDATE ingredientes SET nome = '" + nome + "' WHERE id = " + id + ";";
boolean resp = Banco.noReturnQuery(sql);

%>

<%-- output de dados --%>
<%
    if(resp){
        %> success <%
    }
    else{
        %> fail <%
        throw new Exception("oh sh");
    }
%>

<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    %> Erro na pagina edit-ingrediente.jsp: <br><%
    for(String log : Banco.getErrorList()){
        %><%= log %><br><%
    }
    %><%= ex.getMessage() %><br><%
}
%>