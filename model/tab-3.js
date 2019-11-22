/**
 * realiza um GET request para uma pagina que processa a tabela de ingrediestes para selecao em html, e carrega o retorno na view 
 */
function loadTable3()
{
    let params = {teste: teste, edit: false};
    $.get(path + "model/interfaces-java/tabela-ingredientes-pratos.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            document.getElementById("table-3").innerHTML = response;
        }
        //else erro
        else{
            alert("Erro ao carregar tabela");
            console.log(response)
            document.getElementById("table-3").innerHTML = response;
        }
    });
}

/**
 * pega os dados do form e realiza um Get request pra adicionar o prato
 * 
 * @param ev evento submit 
 */
function addPrato(ev)
{
    let data = getFormPratoData("tab-3-form", false);
    console.log(data);
    ev.preventDefault();
        
}