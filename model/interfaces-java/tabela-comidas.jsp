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
    out.print("fail\n");
    throw new Exception("welp");
}
//else sucesso
else{
    %>
    <table>
        <tr class="table-header">
            <th class="table-1-cell">Id</th>
            <th class="table-1-cell">Nome</th>
            <th class="table-1-cell">Peso ou Volume</th>
            <th class="table-1-cell">descricao</th>
            <th class="table-1-cell"></th>
            <th class="table-1-cell"></th>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> prato : pratos){ 
        %>

        <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>" onclick="loadComidaInfo(<%= prato.get(0) %>)">
            <td class="table-1-cell"> <%= prato.get(0) %> </td>
            <td class="table-1-cell"> <%= prato.get(1) %> </td>
            <td class="table-1-cell"> <%= prato.get(2) %> </td>
            <td class="table-1-cell"> <%= prato.get(3) %> </td>
            <td class="table-1-cell"> <div class="edit-button icon" onclick="editComida(<%= prato.get(0) %>)"> <img class="img-icon" src="../images/static/edit.png" alt="editar"> </div> </td>
            <td class="table-1-cell"> <div class="delete-button icon" onclick="deleteComida(<%= prato.get(0) %>)"> <img class="img-icon" src="../images/static/delete.png" alt="deletar"> </div> </td>
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
    out.print("Erro na pagina tabela-comidas.jsp:\n");
    for(String log : Banco.getErrorList()){
        out.print(log + "\n");
    }
    out.print(ex.getMessage());
}
%>