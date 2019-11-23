<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");
String[] ids = request.getParameterValues("ingredientes[]");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

String idsSerial = "";
for(int i = 0; i != ids.length; i++){
    idsSerial += ids[i];
    idsSerial += (!(i == (ids.length - 1))) ? ", " : "";
}

String sql = "SELECT nome FROM ingredientes WHERE id IN (" + idsSerial + ");";
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
    String ingredientesNames = "";

    for(int i = 0; i != ingredientes.size(); i++){ 
        ingredientesNames += "ingredientes=" + ingredientes.get(i).get(0);
        ingredientesNames += (!(i == (ingredientes.size() - 1))) ? "&" : "";
    }

    out.print(ingredientesNames);
}
%>  

<%-- tratamento de excessoes --%>
<%

}
catch(Exception ex){
    out.print("Erro na pagina get-ingredientes-names.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>