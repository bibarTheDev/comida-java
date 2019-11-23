<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");
String id = request.getParameter("id");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

String sql = "SELECT nome, peso_volume, descricao FROM comida WHERE id=" + id + ";";    
ArrayList<String> prato = Banco.selectQuery(sql).get(0);

sql = "SELECT ingr FROM rel_ingredientes WHERE comida=" + id + ";";
ArrayList< ArrayList<String> > ingredientes = Banco.selectQuery(sql);

%>

<%-- output de dados --%>
<%

//if error
ArrayList<String> errorList = Banco.getErrorList(); 
if(errorList.size() != 0){
    out.print("fail\n");
    throw new Exception("welp");
}
//else sucesso
else{
    //formatacao
    String serialPrato = "id="+id;
    serialPrato += "&nome="+ prato.get(0);
    serialPrato += "&pesVol="+ prato.get(1);
    serialPrato += "&descricao="+ prato.get(2);

    for(ArrayList<String> ingr : ingredientes){ 
        serialPrato += "&ingredientes=" + ingr.get(0);
    }

    out.print(serialPrato);
}
%>  


<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    out.print("Erro na pagina tabela-ingredientes.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>