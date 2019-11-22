<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");
String edit = request.getParameter("edit");
String id = (edit.equals("true")) ? request.getParameter("id") : "0";

String updPrevSource = null;
String updPrevTarg = null;

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

String sql = "SELECT id, nome FROM ingredientes ORDER BY id;";    
ArrayList< ArrayList<String> > ingredientes = Banco.selectQuery(sql);

if(edit.equals("true")){
    //...
}
else{
    updPrevSource = "tab-3-form";
    updPrevTarg = "tab-3-preview";
}

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
            <th class="table-3-cell">Selecao</th>
            <th class="table-3-cell">Nome</th>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> ingr : ingredientes){ 
        %>

        <label>
            <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>">
                <td class="table-3-cell"> 
                    <input onchange="updatePreview('<%= updPrevSource %>', '<%= updPrevTarg %>')" type="checkbox" name="ingredientes" value="<%= ingr.get(1) %>"> 
                </td>
                <td class="table-3-cell"> <%= ingr.get(1) %> </td>
            </tr>
        </label>
        
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