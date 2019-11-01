<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

//Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost

String sql = "SELECT id, nome FROM comida ORDER BY id;";    
ArrayList< ArrayList<String> > ingredientes = Banco.selectQuery(sql);

%>

<%-- output de dados --%>
<%

//if error
ArrayList<String> errorList = Banco.getErrorList(); 
if(errorList.size() != 0){
    throw new Exception("welp");
}
//else sucesso
else{
    %>
    <table>
        <tr class="table-header">
            <th class="table-2-1">Id</th>
            <th class="table-2-2">Nome</th>
            <th class="table-2-3">Excluir</th>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> ingr : ingredientes){ 
        %>

        <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>">
            <td class="table-2-1" > <%= ingr.get(0) %> </td>
            <td class="table-2-2" > <%= ingr.get(1) %> </td>
            <td class="table-2-3" > <button onclick="deleteIngrediente(<%= ingr.get(0) %>)">ex</button> </td>
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
    %> Erro na pagina delete-comida.jsp: <br><%
    for(String log : Banco.getErrorList()){
        %><%= log %><br><%
    }
    %><%= ex.getMessage() %><br><%
}
%>