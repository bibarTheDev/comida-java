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

String sql = "SELECT id, nome, peso_volume, descricao FROM comida ORDER BY id;";    
ArrayList< ArrayList<String> > pratos = Banco.selectQuery(sql);

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
            <th class="table-1-1">Id</th>
            <th class="table-1-2">Nome</th>
            <th class="table-1-3">Peso ou Volume</th>
            <th class="table-1-4">descricao</th>
            <th class="table-1-5"></th>
            <th class="table-1-6"></th>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> prato : pratos){ 
        %>

        <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>" onclick="loadComidaInfo(<%= prato.get(0) %>)">
            <td class="table-1-1" > <%= prato.get(0) %> </td>
            <td class="table-1-2" > <%= prato.get(1) %> </td>
            <td class="table-1-3" > <%= prato.get(2) %> </td>
            <td class="table-1-4" > <%= prato.get(3) %> </td>
            <td class="table-1-5" > <div class="edit-icon" onclick="editComida(<%= prato.get(0) %>)"> <img class="img-icon" src="../images/static/edit.png" alt="editar"> </div> </td>
            <td class="table-1-6" > <div class="delete-icon" onclick="deleteComida(<%= prato.get(0) %>)"> <img class="img-icon" src="../images/static/delete.png" alt="deletar"> </div> </td>
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