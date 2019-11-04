/**
 * realiza um GET request para uma pagina que processa a tabela 2 em html, e carrega o retorno na view 
 */
function loadTable2()
{
    let params = {teste: teste};
    $.get(path + "model/interfaces-java/tabela-ingredientes.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            document.getElementById("table-2").innerHTML = response;
        }
        //else erro
        else{
            console.log(response);
            document.getElementById("table-2").innerHTML = response;
        }
    });
}

/**
 * realiza um GET request para uma pagina que deleta um ingrediente e recarrega a tabela 2
 * 
 * @param id o ID do ingrediente a ser deletado 
 */
function deleteIngrediente(id)
{
    //teste de consistencia
    //if sim
    if(confirm('Deseja deletar este ingrediente?')){
        
        let params = {teste: teste, id: id};
        $.get(path + "model/interfaces-java/delete-ingrediente.jsp", params, (response) =>
        {        
            //if sucesso
            if(response.trim() == "success"){
                alert("Ingrediente deletado");
            }
            //else if erro
            else if(response.trim() == "fail"){
                alert("Ingrediente nao pode ser deletado (ainda ha pratos associados a ele!)");
            }
            //else erro
            else{
                console.log(response);                
            }

            loadTab2();
        });
    }
    //else nao
    else{

    }
}