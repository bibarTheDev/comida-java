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
    //data from form
    let data = getFormPratoData("tab-3-form");

    let params = {
        teste: teste, 
        nome: data.nome,
        descricao: data.descricao,
        pesoVol: data.pesoVolume,
        unid: data.unid,
        ingredientes: data.ingredientes,
    };
    $.get(path + "model/interfaces-java/add-comida.jsp", params, (response) =>
    {   
        //if sucesso
        if(response.trim() == "success"){
            alert("Prato adicionado");
        }
        //else erro
        else{
            alert("Erro ao adicionar o prato");
            console.log(response);                
        }
        
        loadTable1();
    });

    ev.preventDefault();
}