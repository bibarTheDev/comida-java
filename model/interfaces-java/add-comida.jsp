<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{  

String teste = request.getParameter("teste");

String nome = request.getParameter("nome");
String descricao = request.getParameter("descricao");
String pesoVolume = request.getParameter("pesoVolume") + " " + request.getParameter("unid");
String[] ingredientes = request.getParameterValues("ingredientes[]");


if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

//adiciona o objeto prato
String sql = "INSERT INTO comida VALUES (DEFAULT, '" + nome + "', '" + pesoVolume + "', '" + descricao + "');";
boolean ret = Banco.noReturnQuery(sql);

if(!ret){
    out.print("fail\n");
    throw new Exception("oh sh");
}

//pega o id que acabou de ser adicionado
sql = "SELECT id FROM comida ORDER BY ID DESC LIMIT 1;";
ArrayList< ArrayList<String> > resp = Banco.selectQuery(sql);
String id = resp.get(0).get(0);

//add os ingrdedientes
sql = "INSERT INTO rel_ingredientes VALUES";
for(int i = 0; i < ingredientes.length; i++){
    //adiciona o id da comida (ja obtido) e seleciona o id de cada ingrediente pra adicionar junto
    sql += "( " + id + ", (SELECT id FROM ingredientes WHERE nome = '" + ingredientes[i] + "'))";
    sql += (i == (ingredientes.length - 1)) ? ";" : ",";
}
ret = Banco.noReturnQuery(sql);

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
    out.print("Erro na pagina add-prato.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>