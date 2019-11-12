<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String id = request.getParameter("id");
int code; //status da operacao: 0- sucesso, 1- fracasso (ainda ha pratos associados), 2- erro
String teste = request.getParameter("teste");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//verifica por pratos com aquele ingrediente
String sql = "SELECT COUNT(*) FROM rel_ingredientes WHERE ingr = " + id + ";";
String resp = Banco.selectQuery(sql).get(0).get(0);

//caso ainda haja pratos associados
if(resp != "0"){
    code = 1;
}
else{
    
    sql = "DELETE FROM ingredientes WHERE id = " + id + ";";    
    boolean ret = Banco.noReturnQuery(sql);
    code = (ret) ? 0 : 2;
}



%>

<%-- output de dados --%>
<%
    switch(code){
        //case sucesso
        case 0:
            %> success <%
            break;
        
        //case fracasso
        case 1:
            %> fail <%
            break;
        
        //case error
        case 2:
            throw new Exception("welp");
            //break;
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