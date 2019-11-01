/**
 * realiza um GET request para uma pagina que processa a tabela 2 em html, e carrega o retorno na view 
 */
function loadTable2()
{
    $.get(path + "model/interfaces-java/tabela-ingredientes.jsp", (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            document.getElementById("table-2").innerHTML = response;
        }
        //else erro
        else{
            document.getElementById("table-2").innerHTML = response;
        }
    });
}

/**
 * realiza um GET request para uma pagina que deleta um prato e recarrega a tabela 1
 * 
 * @param id o ID do prato a ser deletado 
 */
function deleteIngrediente(id)
{
    //teste de consistencia
    //if sim
    if(confirm('Deseja deletar este prato?')){
        return;
        
        let params = {id: id};
        $.get(path + "model/interfaces-java/delete-comida.jsp", params, (response) =>
        {        
            //if sucesso
            if(response.trim() == "success"){
                alert("Prato deletado");
            }
            //else erro
            else{
                alert("Prato nao pode ser deletado");
            }

            loadTab1();
        });
    }
    //else nao
    else{

    }
}