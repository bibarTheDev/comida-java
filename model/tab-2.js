/**
 * realiza um GET request para uma pagina que processa a tabela de ingredientes em html, e carrega o retorno na view 
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
            alert("Erro ao carregar tabela");
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
                console.log(response);                
            }
            //else erro
            else{
                alert("Erro ao deletar ingrediente");
                console.log(response);                
            }

            loadTable2();
            loadTable3();
        });
    }
    //else nao
    else{

    }
}

/**
 * pergunta ao usuario o novo nome do ingrediente, e entao realiza um GET request para uma pagina que atualiza esse nome e recarrega a tabela 2
 * 
 * @param id o ID do ingrediente a ser alterado 
 */
function editIngrediente(id)
{
    //teste de consistencia
    let nome = prompt("Digite o novo nome do ingrediente:");
    //if sim
    if(nome){
        
        let params = {teste: teste, id: id, nome: nome};
        $.get(path + "model/interfaces-java/edit-ingrediente.jsp", params, (response) =>
        {        
            //if sucesso
            if(response.trim() == "success"){
                alert("Ingrediente atualizado");
            }
            //else erro
            else{
                alert("Erro ao atualizar ingrediente");
                console.log(response);                
            }
            
            loadTable2();
            loadTable3();
        });
    }
    //else nao
    else{

    }
}

/**
 * pergunta ao usuario o nome do novo ingrediente, e entao realiza um GET request para uma pagina que adiciona esse nome e recarrega a tabela 2 
 */
function addIngrediente()
{
    //teste de consistencia
    let nome = prompt("Digite o nome do novo ingrediente:");
    //if sim
    if(nome){
        
        let params = {teste: teste, nome: nome};
        $.get(path + "model/interfaces-java/add-ingrediente.jsp", params, (response) =>
        {        
            //if sucesso
            if(response.trim() == "success"){
                alert("Ingrediente adicionado");
            }
            //else erro
            else{
                alert("Erro ao adicionar o ingrediente");
                console.log(response);                
            }
            
            loadTable2();
            loadTable3();
        });
    }
    //else nao
    else{

    }
}