/**
 * prepara a edição de comida na tab 4
 * 
 * @param id id da comida 
 */
async function prepareEditComida(id)
{
    //muda avisibilidade do conteudo
    document.getElementById("tab-4-noId").className = "tab-4-content-hidden";
    document.getElementById("tab-4-content").className = "tab-4-content";

    //muda a tab
    changeTab(4);

    //pega dados do prato dados do form
    dados = await getAllPratoData(id);
    console.log(dados);
    
    //bota os dados no form
    await loadForm4(dados);
}

async function loadForm4(dados)
{
    //dados normais
    document.getElementById("form-4-nome").value = dados.nome;
    document.getElementById("form-4-descr").value = dados.descricao;
    document.getElementById("form-4-pes-vol").value = Number(dados.pesoVol);
    document.getElementById("form-4-unid").selectedIndex = (dados.unid == "gramas") ? 0 : 1;

    //ingredientes
    document.getElementById("table-4").innerHTML = await getTable4(dados.ingredientes);
}

/**
 * realiza um GET request para uma pagina que processa a tabela de ingrediestes para selecao em html, e retorna o html pronto pra view
 * 
 * @param ingredientes os ingredientes do prato
 * @returns string pro html
 */
async function getTable4(ingredientes)
{
    let htmlstring;

    let params = {teste: teste, edit: true, ingredientes: ingredientes};
    await $.get(path + "model/interfaces-java/tabela-ingredientes-pratos.jsp", params, (response) =>
    {   
        //if is html, sucesso
        if(response.trim().startsWith("<table>")){
            htmlstring = response;
        }
        //else erro
        else{
            alert("Erro ao carregar tabela");
            console.log(response)
            htmlstring = response;
        }
    });

    return htmlstring;
}

/**
 * desabilita edicao na tab 4
 */
function closeEdit()
{
    document.getElementById("tab-4-noId").className = "tab-4-content";
    document.getElementById("tab-4-content").className = "tab-4-content-hidden";
}