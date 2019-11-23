<%@page import="database.Banco" %>
<%@page import="java.util.*" %>

<%-- processamento de dados --%>
<%
try{

String teste = request.getParameter("teste");
int selection = Integer.parseInt(request.getParameter("selection"));

List<String> cams = null;

if(teste.equals("true")){
    Banco.setParams("127.0.0.1", "5432", "postgres", "bibar", "comida"); //ambiente localhost
}
else{
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java"); //server da escola
}

String sql = "";    
switch (selection) {
    case 1:
        sql = "SELECT id, nome, descricao, peso_volume FROM comida ORDER BY id;";
       campos = Arrays.asList(new String[]{"id", "nome", "descricao", "peso_olume"});
        break;
    
    case 2:
        sql = "SELECT * FROM ingredientes ORDER BY id;";
       campos = Arrays.asList(new String[]{"id", "nome");
        break;
    
    case 3:
        sql = "SELECT c.nome AS comida, i.nome AS ingrediente FROM rel_ingredientes AS r ";
        sql +=  "JOIN comida AS c ON r.comida = c.id ";
        sql +=  "JOIN ingredientes AS i ON r.ingr = i.id ";
        sql +=  "ORDER BY comida;";
       campos = Arrays.asList(new String[]{"comida.nome", "ingredientes.nome");
        break;
    
    default:
        break;
}

ArrayList< ArrayList<String> > dados = Banco.selectQuery(sql);

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
            <% 
                for(String campo : campos){ 
                    out.print("<th class='table-5-cell'>" + campo + "</th>");
                }
            %>
        </tr>

        <% 
            int i = 0;
            for(ArrayList<String> row : dados){ 
                String rowClass = ((i++ % 2 == 0) ? "table-row-par" : "table-row-impar");
                out.print("<tr class=" + rowClass +">");
                for(String celula : row){ 
                    out.print("<td class='table-5-cell'> " + celula + " </td>");
                }
                out.print("</tr>");
            }
        %>

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