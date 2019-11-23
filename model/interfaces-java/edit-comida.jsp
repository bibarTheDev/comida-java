<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String teste = request.getParameter("teste");

String id = request.getParameter("id");
String nome = request.getParameter("nome");
String descricao = request.getParameter("descricao");
String pesoVol = request.getParameter("pesoVol") + " " + request.getParameter("unid");
String[] ingredientes = request.getParameterValues("ingredientes[]");


if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//insere o prato
String sql = "UPDATE comida SET nome = '" + nome + "', peso_volume = '" + pesoVol + "', descricao = '" + descricao + "' WHERE id = " + id + "; ";
boolean ret = Banco.noReturnQuery(sql);

if(!ret){
    throw new Exception("erro ao realizar a 1a query");
}

//reseta tabela de relacao
sql = "DELETE FROM rel_ingredientes WHERE comida = " + id + "; ";
ret = Banco.noReturnQuery(sql);

if(!ret){
    throw new Exception("erro ao realizar a 2a query");
}

//add os ingrdedientes
sql = "INSERT INTO rel_ingredientes VALUES";
for(int i = 0; i < ingredientes.length; i++){
    //adiciona o id da comida (ja obtido) e seleciona o id de cada ingrediente pra adicionar junto
    sql += "( " + id + ", (SELECT id FROM ingredientes WHERE nome = '" + ingredientes[i] + "'))";
    sql += (i == (ingredientes.length - 1)) ? ";" : ",";
}
ret = Banco.noReturnQuery(sql);

if(!ret){
    throw new Exception("erro ao realizar a 3a query");
}

%>

<%-- output de dados --%>
<%
    if(ret){
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
    out.print("Erro na pagina edit-prato.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>