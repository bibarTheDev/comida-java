<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%  

//Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost

String sql = "SELECT id, nome, peso_volume, descricao FROM comida ORDER BY id;";    
ArrayList< ArrayList<String> > pratos = Banco.selectQuery(sql);

%>

<%-- output de dados --%>
<%

//if error
if(sql == null){
    for(String log : Banco.getErrorList()){
        %><%= log %><br><%
    }
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
            <th class="table-1-5">Editar</th>
            <th class="table-1-6">Excluir</th>
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
            <td class="table-1-5" > <button onclick="editComida(<%= prato.get(0) %>)">ed</button> </td>
            <td class="table-1-6" > <button onclick="deleteComida(<%= prato.get(0) %>)">ex</button> </td>
        </tr>

        <% } %>

    </table>
    <%
}

%>  
