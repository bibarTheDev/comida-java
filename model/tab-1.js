/**
 * realiza um GET request para uma pagina que processa a tabela de pratos em html, e carrega o retorno na view 
 */
function loadTable1()
{
    let params = {teste: teste};
    $.get(path + "model/interfaces-java/tabela-comidas.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            document.getElementById("table-1").innerHTML = response;
        }
        //else erro
        else{
            alert("Erro ao carregar tabela");
            console.log(response)
            document.getElementById("table-1").innerHTML = response;
        }
    });
}

/**
 * realiza um GET request para uma pagina que deleta um prato e recarrega a tabela 1
 * 
 * @param id o ID do prato a ser deletado 
 */
function deleteComida(id)
{
    //teste de consistencia
    //if sim
    if(confirm('Deseja deletar este prato?')){
        let params = {teste: teste, id: id};
        $.get(path + "model/interfaces-java/delete-comida.jsp", params, (response) =>
        {        
            //if sucesso
            if(response.trim() == "success"){
                alert("Prato deletado");
            }
            //else erro
            else{
                alert("Erro ao deletar prato");
                console.log(response);                
            }

            loadTab1();
        });
    }
    //else nao
    else{

    }
}