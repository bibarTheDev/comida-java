<%@page import="database.Banco" %></%page%>
<%@page import="java.util.*" %></%page%>

<%   
    Banco.setParams("200.145.153.172", "5432", "turma73b", "jamon_eh_top", "turma73b", "comida_java");
    String sql = "SELECT id, nome, peso_volume, descricao FROM comida";    
    ArrayList< ArrayList<String> > pratos = Banco.selectQuery(sql);

    if(sql == null){
        %><%= "null kek" %><%
    }
    else{
        %><%= "sla paor" %><%
    }
%>  

<table>
    <tr>
        <th>id</th>
        <th>nome</th>
        <th>peso/volume</th>
        <th>descricao</th>
    </tr>

    <% for(ArrayList<String> prato : pratos){ %>
        <tr>
            <td> <%= prato.get(0) %> </td>
            <td> <%= prato.get(1) %> </td>
            <td> <%= prato.get(2) %> </td>
            <td> <%= prato.get(3) %> </td>
        </tr>
    <% } %>

</table>
