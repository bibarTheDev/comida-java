<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

String sql = "SELECT id, nome FROM ingredientes ORDER BY id;";    
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
    %>
    <table>
        <tr class="table-header">
            <th class="table-2-1">Id</th>
            <th class="table-2-2">Nome</th>
            <th class="table-2-3"></th>
            <th class="table-2-4"></th>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> ingr : ingredientes){ 
        %>

        <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>">
            <td class="table-2-1" > <%= ingr.get(0) %> </td>
            <td class="table-2-2" > <%= ingr.get(1) %> </td>
            <td class="table-2-3" > <div class="edit-icon" onclick="editIngrediente(<%= ingr.get(0) %>)"> <img class="img-icon" src="../images/static/edit.png" alt="editar"> </div> </td>
            <td class="table-2-4" > <div class="delete-icon" onclick="deleteIngrediente(<%= ingr.get(0) %>)"> <img class="img-icon" src="../images/static/delete.png" alt="deletar"> </div> </td>
        </tr>

        <% } %>

    </table>
    <%
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