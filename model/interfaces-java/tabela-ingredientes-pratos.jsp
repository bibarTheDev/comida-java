<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");
boolean edit = (request.getParameter("edit").equals("true")) ? true : false;
List<String> pratIngr = null;

String updPrevSource = null;
String updPrevTarg = null;

if(edit){
    //transforma array de ingredientes do request numa lista
    pratIngr = Arrays.asList(request.getParameterValues("ingredientes[]"));
    updPrevSource = "tab-4-form";
    updPrevTarg = "tab-4-preview";
}
else{
    updPrevSource = "tab-3-form";
    updPrevTarg = "tab-3-preview";
}

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
    String tableNumber = (edit) ? "4" : "3";

    %>
    <table>
        <tr class="table-header">
            <th class="<%="table-" + tableNumber + "-cell" %>">Selecao</th>
            <th class="<%="table-" + tableNumber + "-cell" %>">Nome</th>
        </tr>

        <% 
            int i = 0;
            boolean isInIgr = false;
            for(ArrayList<String> ingr : ingredientes){

                //checa se um ingrediente e parte dos ingredietes do prato
                if(edit){
                    isInIgr = pratIngr.contains(ingr.get(0)) ? true : false;
                }
        %>

        <label>
            <tr class="<%= ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar") %>">
                <td class="<%="table-" + tableNumber + "-cell" %>"> 
                    <input onchange="updatePreviewFromForm('<%= updPrevSource %>', '<%= updPrevTarg %>')" type="checkbox" name="ingredientes" value="<%= ingr.get(1) %>" <%= (isInIgr) ? "checked" : "" %>> 
                </td>
                <td class="<%="table-" + tableNumber + "-cell" %>"> <%= ingr.get(1) %> </td>
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